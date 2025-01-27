import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/ScenarioController.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';
import 'package:money_monkey/themes/color_themes.dart';

class QuestionPage extends StatefulWidget {
   QuestionPage({
    super.key,
    required this.question,
    required this.correctAns,
    required this.options,
    required this.correctMessage,
  });
  final String question;
  final String correctAns;
  final List<List<String>> options;
  final String correctMessage;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final ScenarioController scenarioController = Get.find();
  String selectedAns = "";
  bool showMessage = false;
  bool hasAnsweredCorrectly = false;
  double score = 0.0;
  double questionValue = 0.0;

  bool wait4 = false;

  Future<void> wait4sec() async{
    await Future.delayed(Duration(seconds: 6));
    setState(() {
      wait4 = true;
    });
  }

  @override
  void initState() {
    super.initState();
    score = scenarioController.responsibilityScore.value;
    questionValue = (1 / scenarioController.questions.length) * 100;
  }

  void answerQuestion(String ans) {
    setState(() {
      if (ans == widget.correctAns) {
        showMessage = true;
        score = scenarioController.responsibilityScore.value + questionValue;
      } else {
        showMessage = false;
        score = scenarioController.responsibilityScore.value;
      }
      selectedAns = ans;
      wait4sec();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Financial Responsibility Score: ",
                style: GoogleFonts.baloo2().copyWith(
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: "${score.toStringAsFixed(2)}",
                    style: GoogleFonts.baloo2().copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "%",
                    style: GoogleFonts.baloo2().copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Image.network(
              height: screenHeight * 0.2,
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
            ),
            ChatBubble(
              clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
              backGroundColor: Colors.grey.shade200,
              margin: EdgeInsets.only(top: 20),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Text(
                  widget.question,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ).marginSymmetric(
                  horizontal: screenWidth * 0.01,
                  vertical: screenHeight * 0.01,
                ),
              ),
            ),
          ],
        ),
        ...widget.options.map(
          (option) => GestureDetector(
            onTap: () => answerQuestion(option[0]),
            child: OptionsTile(
              isSelected: selectedAns == option[0],
              childWidget: Container(
                width: screenWidth * 0.36,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.01,
                  vertical: screenHeight * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option[0],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      option[1],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Spacer(),
            CustomNextButton(
              nextPage: () {
                // Update the controller's score before moving to next question
                scenarioController.responsibilityScore.value = score;
                setState(() {
                  selectedAns = "";
                  showMessage = false;
                  hasAnsweredCorrectly = false;
                  wait4 = false;
                });
                scenarioController.pageIndex.value += 1;
              },
              isEnabled:wait4,
            ),
            SizedBox(width: screenWidth * 0.01),
          ],
        ),
        if (showMessage)
          Row(
            children: [
              Spacer(),
              Container(
                width: screenWidth * 0.25,
                height: screenHeight * 0.1,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: LightTheme().primaryBlue.withAlpha(70),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    widget.correctMessage,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.01),
            ],
          ).marginOnly(top: 10),
      ],
    );
  }
}
