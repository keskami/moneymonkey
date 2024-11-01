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
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
              height: 225,
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                height: 225,
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
