import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/progress_bar.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
import 'package:money_monkey/home.dart';

class LessonOne extends StatefulWidget {
  const LessonOne({super.key});

  @override
  State<LessonOne> createState() => _LessonOneState();
}

class _LessonOneState extends State<LessonOne> {
  ComponentOneTwoController componentOneTwoController = Get.find<ComponentOneTwoController>();
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

  // Future<void> fetchQuestions() async {
  //   await componentOneTwoController.fetchQuestions(lessonId);
  //   print("fetched");
  // }

  @override
  void initState() {
    super.initState();
   // fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    _preLoadImages();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * .06,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            if (componentOneTwoController.pageIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else {
              componentOneTwoController.pageIndex -= 1;
            }
          },
          icon: Icon(
            Icons.arrow_back,
            size: screenHeight * .0375,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: screenHeight * 0.0,
          ),
          //Progress Bar Row
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
              Container(
                width: screenWidth * 0.44,
                child: CustomProgressBar(
                  pageName: 'ConceptOne',
                  width: screenWidth * 0.44,
                  key: ValueKey(componentOneTwoController.pageIndex.value),
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
            () => componentOneTwoController
                .pages[componentOneTwoController.pageIndex.value],
          ),
        ],
      ),
    );
  }
}
