import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Widgets/chat_bubble.dart';

class StartFreshPage6 extends StatelessWidget {
  const StartFreshPage6({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          children: [
            const Spacer(),
            const ChatBubbleContainer(
              borderRadius: 12,
              childWidget: Text(
                "It can be hard to\nstay motivated...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              trianglePosition: TrianglePosition.bottom,
              borderWidth: 1,
            ),
            Image.asset(
              "assets/images/money_monkey.png",
              height: 225,
            ),
            const SizedBox(
              height: 25,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
