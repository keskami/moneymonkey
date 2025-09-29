import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/CacheServices.dart';
import 'package:money_monkey/Backend/Services/DirectFirebaseService.dart';
import 'package:money_monkey/LessonPages/Pages/LoadingScreen/loading_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonsHomeUnit extends StatefulWidget {
  final List<Lesson> lessons;

  const LessonsHomeUnit({
    Key? key,
    required this.lessons,
  }) : super(key: key);

  @override
  State<LessonsHomeUnit> createState() => _LessonsHomeUnitState();
}

class _LessonsHomeUnitState extends State<LessonsHomeUnit> {
  late List<Future<List<Widget>>> _pageFutures;
  final StudentProfileService _profileService = StudentProfileService();
  String? _currentProgress;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProgress();
    _pageFutures = widget.lessons.map((lesson) => _getPages(lesson.components)).toList();
  }

  @override
  void didUpdateWidget(LessonsHomeUnit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lessons != widget.lessons) {
      _pageFutures = widget.lessons.map((lesson) => _getPages(lesson.components)).toList();
    }
  }

  Future<void> _loadUserProgress() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final student = await _profileService.loadProfileOfflineFirst(userId);
      setState(() {
        _currentProgress = student.progress;
        _isLoading = false;
      });
      debugPrint('Current user progress: $_currentProgress');
    } catch (e) {
      debugPrint('Error loading user progress: $e');
      setState(() => _isLoading = false);
    }
  }

  /// Calculate the current index (0-3) based on student's progress and lesson section
  /// Returns the index of the current lesson within this section
  int _calculateCurrentIndex(Lesson lesson) {
    if (_currentProgress == null || lesson.components.isEmpty) {
      return 0; // Default to first lesson if no progress
    }

    // Get the section from the first component (e.g., "A.1.1" from "A.1.1.1")
    final firstComponent = lesson.components.first;
    final lessonSection = _extractSection(firstComponent);
    
    // Get the section from current progress (e.g., "A.1.1" from "A.1.1.3")
    final progressSection = _extractSection(_currentProgress!);
    
    debugPrint('Lesson section: $lessonSection, Progress section: $progressSection');
    
    // Compare sections to determine unlock status
    final sectionComparison = _compareSections(progressSection, lessonSection);
    
    if (sectionComparison > 0) {
      // Progress is ahead of this section - unlock all lessons
      debugPrint('Section completed - unlocking all ${lesson.components.length} lessons');
      return lesson.components.length; // All lessons unlocked
    } else if (sectionComparison < 0) {
      // Progress is behind this section - lock all lessons
      debugPrint('Section locked - no lessons unlocked');
      return -1; // Changed from 0 to -1
    } else {
      // We're in the current section - find the specific lesson
      final currentIndex = _findLessonIndex(lesson.components, _currentProgress!);
      debugPrint('In current section - lesson index: $currentIndex');
      return currentIndex;
    }
  }

  /// Extract section from lesson ID (e.g., "A.1.1.1" -> "A.1.1")
  String _extractSection(String lessonId) {
    final parts = lessonId.split('.');
    if (parts.length >= 3) {
      return '${parts[0]}.${parts[1]}.${parts[2]}';
    }
    return lessonId;
  }

  /// Compare two sections to determine which is ahead
  /// Returns: -1 if section1 < section2, 0 if equal, 1 if section1 > section2
  int _compareSections(String section1, String section2) {
    final parts1 = section1.split('.');
    final parts2 = section2.split('.');
    
    // Compare level (A, B, C...)
    if (parts1[0] != parts2[0]) {
      return parts1[0].compareTo(parts2[0]);
    }
    
    // Compare unit
    final unit1 = int.tryParse(parts1[1]) ?? 0;
    final unit2 = int.tryParse(parts2[1]) ?? 0;
    if (unit1 != unit2) {
      return unit1.compareTo(unit2);
    }
    
    // Compare section
    final sect1 = int.tryParse(parts1[2]) ?? 0;
    final sect2 = int.tryParse(parts2[2]) ?? 0;
    return sect1.compareTo(sect2);
  }

  /// Find the index of the current lesson within the components list
  /// Maps: A.X.X.1 -> 0, A.X.X.3 -> 1, A.X.X.5 -> 2, A.X.X.6 -> 3
  int _findLessonIndex(List<String> components, String progress) {
    // Extract the lesson number from progress (e.g., "1" from "A.1.1.1")
    final progressParts = progress.split('.');
    if (progressParts.length < 4) return 0;
    
    final progressLesson = int.tryParse(progressParts[3]) ?? 1;
    
    // Map lesson number to index: 1->0, 3->1, 5->2, 6->3
    final lessonToIndex = {
      1: 0,
      3: 1,
      5: 2,
      6: 3,
    };
    
    final index = lessonToIndex[progressLesson] ?? 0;
    
    // Return index + 1 to indicate "completed up to this point"
    // e.g., if on lesson 1 (index 0), we've completed 0 lessons
    // if on lesson 3 (index 1), we've completed lesson 1 (index 0)
    return index;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double heightUnit = screenHeight / 1342;
    double widthUnit = screenWidth / 1920;

    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.lessons.length,
      itemBuilder: (context, index) {
        final lesson = widget.lessons[index];
        final currentIndex = _calculateCurrentIndex(lesson);
        
        return FutureBuilder<List<Widget>>(
          future: _pageFutures[index],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final pageLinks = snapshot.data ?? [];
            return LessonHomeUnit_NewUI(
              heightUnit: heightUnit,
              widthUnit: widthUnit,
              currentIndex: currentIndex,
              pageLinks: pageLinks,
              lesson: lesson,
            );
          },
        );
      },
    );
  }

  Future<List<Widget>> _getPages(List<String> componentIds) async {
    final List<Widget> pagesLink = [];
    if (componentIds.isEmpty) {
      return pagesLink;
    }
    final _firebaseService = DirectFirebaseService();
    for (String componentId in componentIds) {
      try {
        final component = await _firebaseService.getComponent(componentId);
        pagesLink.add(LoadingPageWrapper(
          type: component.type, 
          componentId: componentId,
        ));
      } catch (e) {
        print("Error fetching component $componentId: $e");
        pagesLink.add(Container());
      }
    }
    return pagesLink;
  }
}

// -------- Merged NewUI Classes --------
class LessonHomeUnit_NewUI extends StatelessWidget {
  final double heightUnit;
  final double widthUnit;
  final int currentIndex;
  final List<Widget> pageLinks;
  final dynamic lesson;

  LessonHomeUnit_NewUI({
    Key? key,
    required this.heightUnit,
    required this.widthUnit,
    required this.currentIndex,
    required this.pageLinks,
    required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double baseY = heightUnit * 320;
    final double spacingVal = heightUnit * 215;
    final double boxH = heightUnit * 137;
    final double totalHeight = baseY + spacingVal * (pageLinks.length - 1) + boxH;
    
    return Container(
      width: widthUnit * 1500,
      height: totalHeight,
      child: Align(
        alignment: Alignment.centerLeft,
        child: CustomPaint(
          size: Size(widthUnit * 900, totalHeight),
          painter: BoxConnectorPainter(
            currentIndex: currentIndex,
            heightUnit: heightUnit,
            widthUnit: widthUnit,
            itemCount: pageLinks.length,
          ),
          child: Stack(
            children: List.generate(pageLinks.length, (index) {
              final link = pageLinks[index];
              final double left = (index % 4 == 1)
                  ? widthUnit * 100
                  : (index % 4 == 3)
                      ? widthUnit * 500
                      : widthUnit * 300;
              final double top = baseY + spacingVal * index;
              
              // Determine if this lesson is unlocked or current
              final isUnlocked = index < currentIndex;
              final isCurrent = index == currentIndex && currentIndex >= 0;
              
              return Positioned(
                top: top,
                left: left,
                child: _buildLessonBox(
                  context,
                  title: 'Lesson Part ${index + 1}',
                  subtitle: lesson.title ?? '',
                  isUnlocked: isUnlocked,
                  isCurrent: isCurrent,
                  heightUnit: heightUnit,
                  widthUnit: widthUnit,
                  onTap: () {
                    if (isUnlocked || isCurrent) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => link),
                      );
                    } else {
                      // Show locked message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Complete previous lessons to unlock this one!'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    }
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildLessonBox(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isUnlocked,
    required bool isCurrent,
    required double heightUnit,
    required double widthUnit,
    required VoidCallback onTap,
  }) {
    return Container(
      width: widthUnit * 287,
      height: heightUnit * 137,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: isUnlocked
                ? Color.fromRGBO(25, 160, 18, 1)
                : isCurrent
                    ? Color.fromRGBO(135, 206, 235, 1)
                    : Color.fromRGBO(178, 182, 182, 1),
            width: 1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: widthUnit * 15, 
          top: heightUnit * 10, 
          right: widthUnit * 15
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.baloo2(
                    fontSize: heightUnit * 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  isUnlocked 
                      ? Icons.check_circle 
                      : isCurrent
                          ? Icons.play_circle_outline
                          : Icons.lock,
                  color: isUnlocked
                      ? Color.fromRGBO(25, 160, 18, 1)
                      : isCurrent
                          ? Color.fromRGBO(135, 206, 235, 1)
                          : Color.fromRGBO(178, 182, 182, 1),
                  size: heightUnit * 30,
                ),
              ],
            ),
            Text(
              subtitle,
              style: GoogleFonts.baloo2(
                fontSize: heightUnit * 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Center(
                child: Container(
                  width: widthUnit * 257,
                  height: heightUnit * 43,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black, width: .6),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isUnlocked
                            ? Text(
                                "Review",
                                style: GoogleFonts.baloo2(
                                  fontSize: heightUnit * 27,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              )
                            : Row(
                                children: [
                                  Text(
                                    "Start (+10 ",
                                    style: GoogleFonts.baloo2(
                                      fontSize: heightUnit * 21,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/img_monkeymoney_52.png',
                                    height: heightUnit * 22,
                                  ),
                                  Text(
                                    ")",
                                    style: GoogleFonts.baloo2(
                                      fontSize: heightUnit * 21,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(width: isUnlocked ? widthUnit * 3 : 0),
                        if (isUnlocked)
                          Icon(Icons.refresh, size: heightUnit * 27, color: Colors.black)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BoxConnectorPainter extends CustomPainter {
  final int currentIndex;
  final double heightUnit;
  final double widthUnit;
  final int itemCount;

  BoxConnectorPainter({
    required this.currentIndex,
    required this.heightUnit,
    required this.widthUnit,
    required this.itemCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double boxW = widthUnit * 287;
    final double boxH = heightUnit * 137;
    final double halfW = boxW / 2;
    final double halfH = boxH / 2;
    final double baseY = heightUnit * 320;
    final double spacing = heightUnit * 215;
    final paintDone = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Color.fromRGBO(25, 160, 18, 1);
    final paintPending = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Color.fromRGBO(178, 182, 182, 1);
    
    for (int i = 0; i < itemCount - 1; i++) {
      double x1;
      switch (i % 4) {
        case 1:
          x1 = widthUnit * 100;
          break;
        case 3:
          x1 = widthUnit * 500;
          break;
        default:
          x1 = widthUnit * 300;
      }
      double x2;
      switch ((i + 1) % 4) {
        case 1:
          x2 = widthUnit * 100;
          break;
        case 3:
          x2 = widthUnit * 500;
          break;
        default:
          x2 = widthUnit * 300;
      }
      final start = Offset(x1 + halfW, baseY + spacing * i + halfH);
      final end = Offset(x2 + halfW, baseY + spacing * (i + 1) + halfH);
      
      // Green if completed, grey if pending
      final paint = (i < currentIndex) ? paintDone : paintPending;
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant BoxConnectorPainter old) {
    return old.currentIndex != currentIndex || old.itemCount != itemCount;
  }
}