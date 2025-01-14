import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/progress_bar.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionQuizController.dart';
import 'package:money_monkey/LessonPages/Controllers/ToolkitController.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page1.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page2.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page3.dart';

class Toolkit extends StatefulWidget {
  const Toolkit({super.key});

  @override
  State<Toolkit> createState() => _ToolkitState();
}

class _ToolkitState extends State<Toolkit> {
  Toolkitcontroller toolkitcontroller = Get.put(Toolkitcontroller());
  final String lessonId = "PeerReflectionQuiz";
  

  @override
  void initState() {
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {

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
                  toolkitcontroller.pageIndex.value = 0;
                },
                icon: Icon(Icons.close),
              ),
              Container(
                width: screenWidth * 0.44,
                child: CustomProgressBar(
                  pageName: 'Toolkit',
                  width: screenWidth * 0.44,
                  key: ValueKey(toolkitcontroller
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
                toolkitcontroller.pages[toolkitcontroller.pageIndex.value],
          ),
        ],
      ),
    );
  }
}
