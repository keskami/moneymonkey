import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Widgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';

class StartFreshPage1 extends StatefulWidget {
  const StartFreshPage1({super.key});

  @override
  State<StartFreshPage1> createState() => _StartFreshPage1State();
}

class _StartFreshPage1State extends State<StartFreshPage1> {
  int selectedIndex = 5;
  @override
  Widget build(BuildContext context) {
    StartFreshController startFreshController = Get.find();
    void onTapGoal(int val) {
      print('Value: ${val * 5}');
      startFreshController.learningGoal.value = val * 5;
    }

    final List<Widget> learningGoals = [
      const Row(
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
      ),
      const Row(
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
      ),
      const Row(
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
      ),
      const Row(
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
      ),
    ];
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 17),
          Row(
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
                height: 145,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    // If loadingProgress is null, the image has fully loaded
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
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
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  onTapGoal(index + 1);
                  print(index);
                  print(startFreshController.learningGoal.value);
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: CustomOptionTile(
                  isSelected: selectedIndex == index ||
                      (startFreshController.learningGoal.value / 5) - 1 ==
                          index,
                  childWidget: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: learningGoals[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
