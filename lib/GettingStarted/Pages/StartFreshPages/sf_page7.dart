import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Widgets/chat_bubble.dart';

class StartFreshPage7 extends StatelessWidget {
  const StartFreshPage7({super.key});

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
                "...so Money Monkey is designed\nto be fun like a game!",
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
