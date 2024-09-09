import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Widgets/chat_bubble.dart';

class GettingStartedPage4 extends StatelessWidget {
  const GettingStartedPage4({super.key});

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
              text: "Test1 ",
              childWidget: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Just ",
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                    TextSpan(
                        text: "7 quick questions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        )),
                    TextSpan(
                      text: " before we start your first Lesson!",
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
              ),
              trianglePosition: TrianglePosition.bottom,
              borderWidth: 1,
            ),
            Image.asset(
              "assets/money_monkey.png",
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
