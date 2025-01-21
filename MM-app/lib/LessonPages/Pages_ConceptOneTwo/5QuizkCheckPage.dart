import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';
import 'package:money_monkey/LessonPages/Widgets/ShadowedBoxContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class QuickCheckPage extends StatefulWidget {
  const QuickCheckPage({super.key});

  @override
  State<QuickCheckPage> createState() => _QuickCheckPageState();
}

class _QuickCheckPageState extends State<QuickCheckPage> {
    ComponentOneTwoController componentOneTwoController = Get.find();

  String title = "";
  String question1 = "";
  String question2 = "";
  String correctAns1 = "";
  String correctAns2 = "";
  String answer1 = "";
  String answer2 = "";
  List<String> options1 = [];
  List<String> options2 = [];
  String button = '';
  String oneCoreect = '';
  String bothCorrect = '';
  String wrong = '';
  bool loading = true;


  Future<void> setData(data) async {
  setState(() {
    title = data['title'] ?? '';
    button = data['button'] ?? '';
    wrong = data['wrong'] ?? '';
    oneCoreect = data['1Correct'] ?? '';
    bothCorrect = data['2Correct'] ?? '';
    options1 = List<String>.from(data["options1"]?.map((item) => item.toString()) ?? []);
    options2 = List<String>.from(data["options2"]?.map((item) => item.toString()) ?? []);
    correctAns1 = data['correctAnswer1'] ?? '';
    correctAns2 = data['correctAnswer2'] ?? '';
    loading = false;
  });
}


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).clearSnackBars();
    });
    ever(componentOneTwoController.isLoading, (_) {
      if (!componentOneTwoController.isLoading.value) {
        if (componentOneTwoController.pageData.isNotEmpty) {
          setData(componentOneTwoController.pageData[8]);
        }
      }
    });
    if (title == '') {
      setData(componentOneTwoController.pageData[8]);
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
          message: oneCoreect,
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
    return loading ? Center(child: CircularProgressIndicator(),):
    Center(
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
              FlextibleMCQ(screenWidth, screenHeight, question1, options1),
              SizedBox(width: screenWidth * 0.02),
              FlextibleMCQ(screenWidth, screenHeight, question2, options2),
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

  Widget FlextibleMCQ(
    double screenWidth, double screenHeight, String question, List<String> options) {
  return Expanded(
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
          ).toList(),
        ],
      ).paddingSymmetric(
        vertical: screenHeight * 0.03,
      ),
    ),
  );
}


  mobileDisplay() {}
}
