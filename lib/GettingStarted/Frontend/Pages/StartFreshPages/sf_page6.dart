import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/chat_bubble.dart';

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
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                height: 250,
                child: Center(
                  child: Text('Unable to fetch Image.'),
                ),
              ),
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
