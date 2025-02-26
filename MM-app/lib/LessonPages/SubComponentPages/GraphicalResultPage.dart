import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/ScenarioController.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/themes/color_themes.dart';

class GraphicalResultPage extends StatefulWidget {
  const GraphicalResultPage({super.key});

  @override
  _GraphicalResultPageState createState() => _GraphicalResultPageState();
}

class _GraphicalResultPageState extends State<GraphicalResultPage> {
  late ScenarioController scenarioController;
  late String message;
  String subTitle = '';
  String title = '';
  String button = '';

  Future<void> setData(Question data) async {
    setState(() {
      title = "Your Financial Summary";
      subTitle = "Financial Responsibility Score";
      button = "Finish";
    });
  }

  @override
  void initState() {
    super.initState();
    scenarioController = Get.find();
    message = initializeMessage(scenarioController);
    if (scenarioController.pageData.isNotEmpty &&
        scenarioController.pageData[2] != null) {
      setData(scenarioController.pageData[2]);
    }
  }

  String initializeMessage(ScenarioController scenarioController) {
    int score = scenarioController.responsibilityScore.value;
    if (score == 100) {
      return "Amazing! You're in an incredible spot for financial growth, continue being financially responsible!";
    } else if (score < 50.0) {
      return "You got quite a lot to learn!";
    } else {
      return "There's still room for improvement in your abilities to be financially responsible!";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Spacer(),
            const Spacer(),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Image.network(
              width: screenWidth * 0.1,
              height: screenHeight * 0.2,
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
            )
          ],
        ),
        if (scenarioController.responsibilityScore.value == 100.00)
          Image.network(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Ftemporary_financial_pieChart.png?alt=media&token=61efde2c-62c6-4889-bec8-3e3cde837463",
            width: screenWidth * 0.3,
            height: screenHeight * 0.35,
          ),
        Container(
          width: screenWidth * 0.4,
          height: screenHeight * 0.15,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02,
            vertical: screenHeight * 0.02,
          ),
          decoration: BoxDecoration(
            color: LightTheme().primaryBlue.withAlpha(70),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$subTitle ${scenarioController.responsibilityScore.value.toStringAsFixed(2)}%",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            CustomNextButton(
              nextPage: () {
                setState(() {
                  scenarioController.pageIndex.value = 0;
                  scenarioController.responsibilityScore.value = 0;
                  scenarioController.dispose();
                });
                Navigator.pop(context);
              },
              isEnabled: true,
              text: button,
            )
          ],
        ).marginOnly(top: 10),
      ],
    );
  }
}
