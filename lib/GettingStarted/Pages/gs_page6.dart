import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Widgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/Widgets/knowledge_bar.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';

class GettingStartedPage6 extends StatelessWidget {
  GettingStartedPage6({
    super.key,
  });

  final List<Widget> knowledgeOptions = [
    const SizedBox(
      height: 50, // Match height with multi-line text
      child: Center(
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
    const Text(
      "I have a basic\nunderstanding",
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
    ),
    const Text(
      "I am moderately\nknowledgeable",
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
    ),
    const Text(
      "I have a good\nunderstanding",
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
    ),
    const Text(
      "I am very\nknowledgeable",
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                  "assets/money_monkey.png",
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
