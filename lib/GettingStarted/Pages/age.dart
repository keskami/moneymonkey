import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Widgets/chat_bubble.dart';

class GettingStartedAgePage extends StatelessWidget {
  const GettingStartedAgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 17,
            ),
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
                    "How old are you?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
