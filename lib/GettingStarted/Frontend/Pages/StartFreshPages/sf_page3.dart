import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/start_fresh_controller.dart';

class StartFreshPage3 extends StatelessWidget {
  const StartFreshPage3({super.key});
  @override
  Widget build(BuildContext context) {
    StartFreshController startFreshController = Get.find();
    final List<Widget> learningGoals = [
      GestureDetector(
          onTap: () {
            startFreshController.learningGoal.value = 5;

            startFreshController.pageIndex += 1;
          },
          child: const Row(
            children: [
              Text(
                "5 min / day",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Spacer(),
              Text(
                "Casual",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          )),
      GestureDetector(
          onTap: () {
            startFreshController.learningGoal.value = 10;
            startFreshController.pageIndex += 1;
          },
          child: const Row(
            children: [
              Text(
                "10 min / day",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Spacer(),
              Text(
                "Regular",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          )),
      GestureDetector(
          onTap: () {
            startFreshController.learningGoal.value = 15;
            startFreshController.pageIndex += 1;
          },
          child: const Row(
            children: [
              Text(
                "15 min / day",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Spacer(),
              Text(
                "Serious",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          )),
      GestureDetector(
          onTap: () {
            startFreshController.learningGoal.value = 20;
            startFreshController.pageIndex += 1;
          },
          child: const Row(
            children: [
              Text(
                "20 min / day",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Spacer(),
              Text(
                "Intense",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          )),
    ];
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 17),
          Row(
            children: [
              Image.asset(
                "assets/images/money_monkey.png",
                height: 145,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 145,
                  width: 137,
                  child: Center(
                    child: Text('Unable to fetch Image.'),
                  ),
                ),
              ),
              const ChatBubbleContainer(
                trianglePosition: TrianglePosition.left,
                borderRadius: 12,
                borderWidth: 1,
                childWidget: Text(
                  "What's your daily\nlearning goal?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Wrapping the ListView.builder in Flexible to make it scrollable
          Flexible(
            child: ListView.builder(
              itemCount: learningGoals.length,
              itemBuilder: (context, index) => CustomOptionTile(
                childWidget: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: learningGoals[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
