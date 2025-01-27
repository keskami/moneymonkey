import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Widgets/continue_button.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';

class MCQPage extends StatefulWidget {
  const MCQPage({
    super.key,
  });

  @override
  State<MCQPage> createState() {
    return _MCQPageState();
  }
}

class _MCQPageState extends State<MCQPage> {
  ComponentOneTwoController componentOneTwoController = Get.find();

  String currentQuestion = "";
  List<String> currentAnswers = [];
  List<String> correctAnswers = [];
  List<String> options = [];
  // String correctAnswer = '';

  // List<String> options = [];
  String wrong = '';
  String correct = '';
  String title = '';
  String question = '';
  bool loading = true;

  Future<void> setData(data) async {
    setState(() {
      correct = data['correct'];
      wrong = data['wrong'];
      title = data['title'];
      question = data['question'];
      options =
          List<String>.from(data["options"].map((item) => item.toString()));
      correctAnswers.add(data['correctAnswer']);
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    ever(componentOneTwoController.isLoading, (_) {
      if (!componentOneTwoController.isLoading.value) {
        if (componentOneTwoController.pageData.isNotEmpty) {
          setData(componentOneTwoController.pageData[1]);
        }
      }
    });
    if (title == '') {
     
      setData(componentOneTwoController.pageData[1]);
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
  Widget build(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight
        ? webDisplay(screenWidth, screenHeight)
        : mobileDisplay();
  }

  Widget webDisplay(double screenWidth, double screenHeight) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenWidth * 0.02),
              Text(
                question,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ).marginSymmetric(
                vertical: screenHeight * 0.025,
                horizontal: screenWidth * 0.015,
              ),
              Text(
                title,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                ),
              ).marginSymmetric(
                vertical: screenHeight * 0.01,
                horizontal: screenWidth * 0.015,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: screenHeight * 0.5,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: options.map((answer) {
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
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
            ],
          ).paddingSymmetric(horizontal: screenWidth * 0.25);
  }

  Scaffold mobileDisplay() {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "",
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: options.map((answer) {
                    return GestureDetector(
                      onTap: () {},
                      child: CustomOptionTile(
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
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            NextButton(
              nextPage: () {},
              isEnabled: currentAnswers.length > 0,
            ),
          ],
        )),
      ),
    );
  }
}
