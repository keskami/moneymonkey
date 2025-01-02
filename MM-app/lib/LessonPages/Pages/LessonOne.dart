import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/progress_bar.dart';
import 'package:money_monkey/LessonPages/Controllers/LessonOneController.dart';
import 'package:money_monkey/LessonPages/Models/Question_Model.dart';

class LessonOne extends StatefulWidget {
  const LessonOne({super.key});

  @override
  State<LessonOne> createState() => _LessonOneState();
}

class _LessonOneState extends State<LessonOne> {
  LessonOneController lessonOneController = Get.put(LessonOneController());
  final String lessonId = "Lesson1";
  Future<void> _preLoadImages() async {
    await precacheImage(
        NetworkImage(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FCheck%20circle.png?alt=media&token=52726418-7a0a-4b6c-9207-1efa735199af"),
        context);
    await precacheImage(
        NetworkImage(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FWrong%20X.png?alt=media&token=7502b819-8b30-4120-8222-305534358c8c"),
        context);
  }

  Future<void> fetchQuestions() async {
    await lessonOneController.fetchQuestions(lessonId);
    await lessonOneController.addQuestion(
      lessonId,
      "Question2",
      Question(
        type: QuestionType.iconReveal,
        data: IconReveal(
          iconLinks: [
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fcard.png?alt=media&token=d9ad44a7-c607-4a88-9c8b-64d49e47a245",
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fgraduation-cap.png?alt=media&token=53e1203d-816d-4512-b570-db886d53d904",
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fbriefcase-bag.png?alt=media&token=987a2538-9376-46ef-965e-502cf493d798",
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FLesson%201%2Fsunset.png?alt=media&token=2ebd97df-6903-4254-bd15-3a59c404825b",
          ],
          contents: [
            "Even small allowances or part-time earnings can be budgeted. Learning to save a portion of every dollar sets a foundation for bigger goals later.",
            "This might be your first real job or college experience. Start building credit responsibly and budget for regular bills—rent, utilities, groceries.",
            "You might buy a home or consider long-term investments. Having an emergency fund, managing debt wisely, and planning for retirement become crucial.",
            "You live off savings, pensions, or investments made earlier. Continued budgeting helps ensure your money lasts and you maintain your desired lifestyle.",
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    _preLoadImages();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  lessonOneController.pageIndex.value = 0;
                },
                icon: Icon(Icons.close),
              ),
              Container(
                width: screenWidth * 0.44,
                child: CustomProgressBar(
                  pageName: 'EducationPage',
                  width: screenWidth * 0.44,
                  key: ValueKey(lessonOneController
                      .pageIndex.value), // Add key to force rebuild
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Image.network(
                  width: 30,
                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FbananasWorth.png?alt=media&token=551b2c7b-08d9-4624-a077-31641e5bd003"),
              Text(
                "3",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Obx(
            () =>
                lessonOneController.pages[lessonOneController.pageIndex.value],
          ),
        ],
      ),
    );
  }
}
