import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Pages/QuizPages/result.dart';
import 'package:money_monkey/GettingStarted/Widgets/progress_bar.dart';
import 'package:money_monkey/GettingStarted/controller/intro_pages_controller.dart';
import 'package:money_monkey/GettingStarted/controller/quiz_controller.dart';
import '../../../Backend/Loading Widgets/shimmer_loading_container.dart';
import '../../Models and Questions/question_data.dart';
import '../../../GlobalWidgets/chat_bubble.dart';
import '../../Widgets/continue_button.dart';
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

  QuizController quizController = Get.put(QuizController());
  @override
  Widget build(context) {
    GettingStartedController gettingStartedController =
        Get.put(GettingStartedController());
    void showResultPage() {
      int score = quizController.calculateScore();
      if (score <= 3) {
        gettingStartedController.knowledgeLevel.value = 1;
      } else if (score <= 7) {
        gettingStartedController.knowledgeLevel.value = 2;
      } else {
        gettingStartedController.knowledgeLevel.value = 3;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResultPage(score: score),
        ),
      );
    }

    final List<int> multipleAnswerIndices = [2, 5];

    void answerQuestion(String selectedAnswer) {
      bool isMultipleAnswer =
          multipleAnswerIndices.contains(currentQuestionIndex);
      int maxSelections = isMultipleAnswer ? 2 : 1;

      if (currentAnswers.contains(selectedAnswer)) {
        quizController.answers[currentQuestionIndex].remove(selectedAnswer);
        setState(() {
          currentAnswers.remove(selectedAnswer);
        });
      } else {
        if (currentAnswers.length < maxSelections) {
          quizController.answers[currentQuestionIndex].add(selectedAnswer);
          setState(() {
            currentAnswers.add(selectedAnswer);
          });
        } else if (!isMultipleAnswer) {
          quizController.answers[currentQuestionIndex] = [selectedAnswer];
          setState(() {
            currentAnswers = [selectedAnswer];
          });
        } else {
          print(
              "You can only select up to $maxSelections answer(s) for this question.");
        }
      }
      print(currentAnswers);
    }

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight
        ? webDisplay(answerQuestion, showResultPage, screenWidth)
        : mobileDisplay(answerQuestion, showResultPage);
  }

  Scaffold webDisplay(void answerQuestion(String selectedAnswer),
      void showResultPage(), double screenWidth) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: screenWidth * 0.01,
            width: screenWidth * 0.6,
            child: CustomProgressBar(
              page: 2,
              width: screenWidth * 0.6,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
                height: screenWidth * 0.1,
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
                errorBuilder: (context, error, stackTrace) => ShimmerContainer(
                  height: 145,
                  width: 137,
                ),
              ),
              ChatBubbleContainer(
                trianglePosition: TrianglePosition.left,
                borderRadius: 12,
                borderWidth: 1,
                childWidget: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width *
                          0.4), // Set max width
                  child: Text(
                    currentQuizData.text,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.blueGrey.shade300))),
              margin: EdgeInsets.fromLTRB(
                screenWidth * 0.1,
                0,
                screenWidth * 0.1,
                screenWidth * 0.03,
              ),
              child: SingleChildScrollView(
                child: Column(children: [
                  ...options.map((answer) {
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
                ]),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(
          horizontal: screenWidth * 0.15, vertical: screenWidth * 0.05),
      floatingActionButton: NextButton(
        nextPage: () {
          quizController.pageIndex.value += 1;
          if (currentQuestionIndex == 8) {
            showResultPage();
            return;
          }
          setState(() {
            currentQuestionIndex += 1;
            currentQuizData = questions[currentQuestionIndex];
            currentAnswers = [];

            options = questions[currentQuestionIndex].shuffledAnswers;
          });
        },
        isEnabled: currentAnswers.length > 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Scaffold mobileDisplay(
      void answerQuestion(String selectedAnswer), void showResultPage()) {
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
                  if (currentQuestionIndex == 8) {
                    showResultPage();
                    return;
                  }
                  setState(() {
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
      ),
    );
  }
}
