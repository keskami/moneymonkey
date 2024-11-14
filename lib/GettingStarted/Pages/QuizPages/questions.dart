import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Pages/QuizPages/result.dart';
import 'package:money_monkey/GettingStarted/controller/quiz_controller.dart';

import '../../../Backend/Loading Widgets/shimmer_loading_container.dart';
import '../../Models and Questions/question_data.dart';
import '../../Widgets/chat_bubble.dart';
import '../../Widgets/next_button.dart';
import '../../Widgets/option_tile.dart';

class QuizHome extends StatefulWidget {
  const QuizHome({
    super.key,
  });

  @override
  State<QuizHome> createState() {
    return _QuizHomeState();
  }
}

class _QuizHomeState extends State<QuizHome> {
  var currentQuestionIndex = 0;
  var currentQuizData = questions[0];
  String currentQuestion = "";
  List<String> currentAnswers = [];
  List<String> options = [];
  @override
  void initState() {
    super.initState();
    currentQuestion = currentQuizData.text;
    options = currentQuizData.shuffledAnswers;
  }

  @override
  Widget build(context) {
    QuizController quizController = Get.put(QuizController());
    void showResultPage() {
      int score = quizController.calculateScore();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResultPage(score: score),
        ),
      );
    }

    void answerQuestion(String selectedAnswer) {
      if (currentAnswers.contains(selectedAnswer)) {
        quizController.answers[currentQuestionIndex].remove(selectedAnswer);
        setState(() {
          currentAnswers.remove(selectedAnswer);
        });
      } else {
        quizController.answers[currentQuestionIndex].add(selectedAnswer);
        setState(() {
          currentAnswers.add(selectedAnswer);
        });
      }
      print(currentAnswers);
    }

    return SizedBox(
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
                Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
                  height: 145,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return ShimmerContainer(
                      height: 145,
                      width: 137,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      ShimmerContainer(
                    height: 145,
                    width: 137,
                  ),
                ),
                Expanded(
                  child: ChatBubbleContainer(
                    trianglePosition: TrianglePosition.left,
                    borderRadius: 12,
                    borderWidth: 1,
                    childWidget: SingleChildScrollView(
                      child: Text(
                        currentQuizData.text,
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: options.map((answer) {
                    return GestureDetector(
                      onTap: () {
                        answerQuestion(answer);
                      },
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
              nextPage: () {
                setState(() {
                  if (currentQuestionIndex == 8) {
                    showResultPage();
                  }
                  currentQuestionIndex += 1;
                  currentQuizData = questions[currentQuestionIndex];
                  currentAnswers = [];
                  options = questions[currentQuestionIndex].shuffledAnswers;
                });
              },
              isEnabled: currentAnswers.length > 0,
            ),
          ],
        ),
      ),
    );
  }
}
