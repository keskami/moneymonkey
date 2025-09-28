import 'package:flutter/material.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/AcademicServices.dart';
import 'package:money_monkey/Backend/Services/DirectFirebaseService.dart';
import 'package:money_monkey/LessonPages/Pages/LessonHomeUnit.dart';
import 'package:money_monkey/GlobalWidgets/Scoreboard.dart';
import 'package:money_monkey/themes/color_themes.dart';

class LessonsHome extends StatefulWidget {
  const LessonsHome({Key? key}) : super(key: key);

  @override
  State<LessonsHome> createState() => _LessonsHomeState();
}

class _LessonsHomeState extends State<LessonsHome> {
  final localService = DirectFirebaseService();
  final ScrollController _scrollController = ScrollController();

  List<Lesson> lessons = [];
  String _currentLessonTitle = '';
  String _currentUnitId = "A.1";
  String unitTitle = "";

  // For illustration, assume each "lesson block" is ~400px tall
  final double _lessonBlockHeight = 700;

  @override
  void initState() {
    super.initState();
    _loadData();

    if (lessons.isNotEmpty) {
      _currentLessonTitle = lessons.first.title;
    }
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadData() async {
    try {
      // Wait for the unit to be fetched since getUnit returns a Future
      final Unit currentUnit = await localService.getUnit(_currentUnitId);

      // Update the state with the unit title
      setState(() {
        unitTitle = currentUnit.title;
      });

      // Get lessons for each lesson ID
      List<Lesson> loadedLessons = [];
      for (String lessonId in currentUnit.lessonIds) {
        try {
          final lesson = await localService.getLesson(lessonId);
          loadedLessons.add(lesson);
        } catch (e) {
          print('Error loading lesson $lessonId: $e');
        }
      }

      // Update the state with loaded lessons
      setState(() {
        lessons = loadedLessons;
      });
    } catch (e) {
      print('Error loading unit data: $e');
    }
  }

  void _onScroll() {
    if (lessons.isEmpty) return;
    final offset = _scrollController.offset;
    int index = (offset / _lessonBlockHeight).floor();
    if (index < 0) index = 0;
    if (index >= lessons.length) index = lessons.length - 1;

    final newTitle = lessons[index].title;
    if (newTitle != _currentLessonTitle) {
      setState(() => _currentLessonTitle = newTitle);
    }
  }

  void _onBackArrowTap(String currentUnitId) {
    List<String> parts = currentUnitId.split('.');
    int incrementedNumber = int.parse(parts[1]) - 1;

    if (incrementedNumber < 1) {
    } else {
      setState(() {
        String result = '${parts[0]}.$incrementedNumber';
        _currentUnitId = result;
        _loadData();
        if (lessons.isNotEmpty) {
          _currentLessonTitle = lessons.first.title;
        }
        _scrollController.jumpTo(0);
      });
    }
  }

  void _onSkipNextUnit(String currentUnitId) {
    List<String> parts = currentUnitId.split('.');
    int incrementedNumber = int.parse(parts[1]) + 1;

    if (incrementedNumber > 2) {
    } else {
      setState(() {
        String result = '${parts[0]}.$incrementedNumber';
        _currentUnitId = result;
        _loadData();
        if (lessons.isNotEmpty) {
          _currentLessonTitle = lessons.first.title;
        }
        _scrollController.jumpTo(0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // 1) Scrollable content behind pinned heading
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // The lessons themselves
                LessonsHomeUnit(lessons: lessons),

                // The skip container
                // The skip container
                // The skip container
                Align(
                  alignment:
                      Alignment.centerLeft, // Aligns the container to the left
                  child: Container(
                    width: screenWidth * 0.4, // Keep it half the screen width
                    color: Colors.grey.shade50,
                    padding: const EdgeInsets.all(16),
                    margin: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ready to Move Ahead?",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "You’ve made great progress! Feel free to skip to the next unit...",
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.lock,
                                  color: Colors.grey, size: 28),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Unit : Coming Up Next",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Advanced money management techniques...",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LightTheme().primaryBlue,
                            ),
                            onPressed: () => _onSkipNextUnit(_currentUnitId),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Skip to Next Unit ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Icon(Icons.arrow_forward,
                                    color: Colors.black, size: 18),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            "You can always come back to review this unit later",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
              top: 0,
              left: 0,
              height: screenHeight * 0.05,
              width: screenWidth * 0.45,
              child: Container(
                color: LightTheme().primaryBackgroundColor,
              )),
          // 2) Pinned heading at top-left
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.025,
            height: 120,
            width: screenWidth * 0.45,
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  screenWidth * 0.02, 0, screenWidth * 0.02, 0),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Lesson title
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          unitTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _currentLessonTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Back arrow
                  GestureDetector(
                    onTap: () => _onBackArrowTap(_currentUnitId),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: LightTheme().primaryBlue),
            ),
          ),

          // 3) NEW scoreboard pinned top-right
          Positioned(
            top: 0,
            right: 20,
            width: MediaQuery.of(context).size.width * 0.3,
            child: const ScoreboardWidget(),
          ),
        ],
      ),
    );
  }
}
