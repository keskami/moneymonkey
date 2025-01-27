import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';

class ScenarioPage extends StatefulWidget {
  const ScenarioPage({super.key});

  @override
  State<ScenarioPage> createState() => _ScenarioPageState();
}

class _ScenarioPageState extends State<ScenarioPage> {
  String currentQuestion = "";
  List<String> currentAnswers = [];
  List<String> correctAnswers = [];
  List<String> options = [];
  String containerHeading = '';
  String containerSubHeading = '';

  ComponentOneTwoController componentOneTwoController = Get.find();

  String title = '';
  String subTitle = '';
  String wrong = '';
  String correct = '';
  bool loading = true;
  Future<void> setData(data) async {
    setState(() {
      title = data['title'];
      subTitle = data['subTitle'];
      wrong = data['wrong'];
      correct = data['correct'];
      containerHeading = data['containerHeading'];
      containerSubHeading = data['containerSubHeading'];
      options =
          List<String>.from(data["options"].map((item) => item.toString()));
      correctAnswers.add(data['correctAnswer']);

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
          setData(componentOneTwoController.pageData[4]);
        }
      }
    });
    if (title == '') {
      setData(componentOneTwoController.pageData[4]);
    }
  }

  void answerQuestion(String ans) {
    currentAnswers.clear();
    if (correctAnswers.contains(ans)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(CorrectAnswerSnackBar(message: correct));
      setState(() {
        currentAnswers.add(ans);
      });
      Future.delayed(
        Duration(seconds: 2),
        () {
          componentOneTwoController.pageIndex.value += 1;
        },
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(WrongAnswerSnackBar(message: wrong));
      setState(() {
        currentAnswers.add(ans);
      });
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
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: screenWidth * 0.02),
          //Heading
          Text(
            title,
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
            ),
          ).marginSymmetric(
              vertical: screenHeight * 0.025, horizontal: screenWidth * 0.015),
          //SubHeading
          Text(
            subTitle,
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 19,
            ),
          ).marginSymmetric(
            vertical: screenHeight * 0.01,
            horizontal: screenWidth * 0.015,
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Container(
            height: screenHeight * 0.4,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.015,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(0, 3),
                ),
              ],
              color: Colors.white,
            ),
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      containerHeading,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ).marginSymmetric(horizontal: screenWidth * 0.015),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      containerSubHeading,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ).marginSymmetric(horizontal: screenWidth * 0.015),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    ...options.map((answer) {
                      return GestureDetector(
                        onTap: () {
                          answerQuestion(answer);
                        },
                        child: OptionsTile(
                          isSelected: currentAnswers.contains(answer),
                          childWidget: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            child: Text(
                              answer,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: screenWidth * 0.25),
    );
  }

  mobileDisplay() {}
}
