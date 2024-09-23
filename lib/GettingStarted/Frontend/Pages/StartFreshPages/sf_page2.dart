import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/chat_bubble.dart';

class StartFreshPage2 extends StatelessWidget {
  const StartFreshPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 17,
          ),
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
                  "Let's set up a\nlearning routine!",
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
    );
  }
}
