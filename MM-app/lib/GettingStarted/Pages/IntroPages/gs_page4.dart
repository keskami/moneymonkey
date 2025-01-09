import 'package:flutter/material.dart';
import 'package:money_monkey/GlobalWidgets/chat_bubble.dart';

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
              borderRadius: 12,
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
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
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
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
              height: 225,
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
