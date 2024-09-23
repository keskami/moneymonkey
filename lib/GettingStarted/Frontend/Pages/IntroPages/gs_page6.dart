import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/sf_home.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/knowledge_bar.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/option_tile.dart';

class GettingStartedPage6 extends StatelessWidget {
  const GettingStartedPage6({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> knowledgeOptions = [
      SizedBox(
        height: 60, // Match height with multi-line text
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StartFreshHome(),
                  ));
            },
            child: const Text(
              "I'm new",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      GestureDetector(
        child: const Text(
          "I have a basic\nunderstanding",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      GestureDetector(
        child: const Text(
          "I am moderately\nknowledgeable",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      GestureDetector(
        child: const Text(
          "I have a good\nunderstanding",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      GestureDetector(
        child: const Text(
          "I am very\nknowledgeable",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                    "How would you rate\nyour knowledge of\nfinancial literacy?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Flexible ListView
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: knowledgeOptions.length,
                itemBuilder: (context, index) => CustomOptionTile(
                  childWidget: Row(
                    children: [
                      KnowledgeBar(strength: index),
                      const SizedBox(width: 20),
                      knowledgeOptions[index],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
