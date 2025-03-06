import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
 
import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';
import 'package:money_monkey/LessonPages/Widgets/ShadowedBoxContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class LearningCheckPage extends StatefulWidget {
  final String componentId;
  const LearningCheckPage({super.key, required this.componentId});

  @override
  State<LearningCheckPage> createState() => _LearningCheckPageState();
}

class _LearningCheckPageState extends State<LearningCheckPage> {
  String title = "";
  String question1 = "";
  String question2 = "";
  String correctAns1 = "";
  String correctAns2 = "";
  String answer1 = "";
  String answer2 = "";
  List<String> options1 = <String>[
    ".",
    ".",
    ".",
  ];
  List<String> options2 = [
    ".",
    ".",
    ".",
  ];
  String button = "";
  String bothCorrect = '';
  String oneCorrect = '';
  String wrong = '';
  bool loading = false;

  ComponentOneTwoController componentOneTwoController =
      Get.find<ComponentOneTwoController>();

  Future<void> setData(SubComponent data) async {
    setState(() {
      title = data.data.title;
      question1 = data.data.question1;
      question2 = data.data.question2;
      correctAns1 = data.data.correctAns1;
      correctAns2 = data.data.correctAns2;

      options1 =
          List<String>.from(data.data.options1.map((item) => item.toString()));
      options2 =
          List<String>.from(data.data.options2.map((item) => item.toString()));
      button = "Check";
      oneCorrect = "One question is incorrect";
      bothCorrect = "Great job!";
      wrong = "Both questions are incorrect";

      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).clearSnackBars();
    });
    if (componentOneTwoController.pageData.isNotEmpty) {
      setData(componentOneTwoController.pageData[4]);
    }
    if (title == '') {
      setData(componentOneTwoController.pageData[4]);
    }
  }

  bool isNextEnabled = false;
  void showMessage() {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (answer1 == correctAns1 && answer2 == correctAns2) {
      ScaffoldMessenger.of(context).showSnackBar(
        CorrectAnswerSnackBar(
          message: bothCorrect,
        ),
      );
      Future.delayed(
        Duration(seconds: 2),
        () {
          componentOneTwoController.pageIndex.value += 1;
        },
      );
    } else if (answer1 == correctAns1 || answer2 == correctAns2) {
      ScaffoldMessenger.of(context).showSnackBar(
        WrongAnswerSnackBar(
          message: oneCorrect,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        WrongAnswerSnackBar(
          message: wrong,
        ),
      );
    }
  }

  void answerQuestion(int questionNumber, String ans) {
    switch (questionNumber) {
      case 1:
        setState(() {
          answer1 = ans;
        });
        break;
      case 2:
        setState(() {
          answer2 = ans;
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight
        ? webDisplay(screenWidth, screenHeight)
        : mobileDisplay();
  }

  webDisplay(double screenWidth, double screenHeight) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 27,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FlextibleMCQ(
                        screenWidth, screenHeight, question1, options1),
                    SizedBox(width: screenWidth * 0.02),
                    FlextibleMCQ(
                        screenWidth, screenHeight, question2, options2),
                  ],
                ).marginSymmetric(
                  vertical: screenHeight * 0.025,
                ),
                GestureDetector(
                  onTap: () {
                    showMessage();
                  },
                  child: Container(
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.08,
                    decoration: BoxDecoration(
                      color: LightTheme().pastelGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        button,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(
              horizontal: screenWidth * 0.25,
              vertical: screenHeight * 0.018,
            ),
          );
  }

  Flexible FlextibleMCQ(double screenWidth, double screenHeight,
      String question, List<String> options) {
    return Flexible(
      flex: 1,
      child: ShadowedBoxContainer(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenWidth * .014),
              child: Text(
                question,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
            ),
            ...options.map(
              (option) {
                return GestureDetector(
                  onTap: () {
                    answerQuestion(question == question1 ? 1 : 2, option);
                  },
                  child: OptionsTile(
                    isSelected: answer1 == option || answer2 == option,
                    childWidget: Container(
                      width: double.infinity,
                      height: screenHeight * 0.1,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.01,
                        vertical: screenHeight * 0.01,
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ).paddingSymmetric(
          vertical: screenHeight * 0.03,
        ),
      ),
    );
  }

  mobileDisplay() {}
}
