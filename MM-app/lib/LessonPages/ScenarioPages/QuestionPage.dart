import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/chat_bubble.dart';
import 'package:money_monkey/LessonPages/Controllers/ScenarioController.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';
import 'package:money_monkey/themes/color_themes.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({
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
  bool shouldIncrease = true;
  @override
  void initState() {
    super.initState();
  }

  void answerQuestion(String ans) {
    if (ans == widget.correctAns && shouldIncrease) {
      showMessage = true;
      checkAns();
    } else {
      showMessage = false;
    }

    setState(() {
      selectedAns = ans;
    });
  }

  void checkAns() {
    if (shouldIncrease) {
      scenarioController.responsibilityScore.value += 33.33;
      if (scenarioController.responsibilityScore.value == 99.99) {
        scenarioController.responsibilityScore.value = 100;
      }
      shouldIncrease = false; // Prevent multiple increments
    }
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                text: "Financial Responsibility Score: ",
                style: GoogleFonts.baloo2().copyWith(
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text:
                        scenarioController.responsibilityScore.value.toString(),
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
            ChatBubbleContainer(
              trianglePosition: TrianglePosition.left,
              childWidget: Text(
                widget.question,
                style: TextStyle(
                  fontSize: 17,
                ),
              ).marginSymmetric(
                horizontal: screenWidth * 0.01,
                vertical: screenHeight * 0.02,
              ),
            ),
          ],
        ),
        ...widget.options.map(
          (option) => GestureDetector(
            onTap: () {
              answerQuestion(option[0]);
            },
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
        //NExt Button
        Row(
          children: [
            Spacer(),
            CustomNextButton(
              nextPage: () {
                selectedAns = "";
                showMessage = false;
                shouldIncrease = true;
                scenarioController.pageIndex.value += 1;
              },
              isEnabled: selectedAns.isNotEmpty,
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
                  color: LightTheme().primaryBlue,
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
