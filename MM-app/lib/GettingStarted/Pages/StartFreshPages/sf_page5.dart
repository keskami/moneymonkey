import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';

class StartFreshPage5 extends GetView<StartFreshController> {
  const StartFreshPage5({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Center(
      child: screenWidth > screenHeight
          ? webDisplay(screenWidth)
          : mobileDisplay(),
    );
  }

  Widget webDisplay(double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Image.network(
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
          height: screenWidth * 0.2,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
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
          errorBuilder: (context, error, stackTrace) => SizedBox(
            height: screenWidth * 0.2,
            width: screenWidth * 0.2,
            child: const Center(
              child: Text('Unable to fetch Image.'),
            ),
          ),
        ),
        const SizedBox(width: 16),
        const ChatBubbleContainer(
          borderRadius: 12,
          childWidget: Text(
            "...so Money Monkey is designed\nto be fun like a game!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          trianglePosition: TrianglePosition.left,
          borderWidth: 1,
        ),
        const Spacer(),
      ],
    );
  }

  Widget mobileDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(height: 16),
          Image.network(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
            height: 225,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
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
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              height: 225,
              width: 225,
              child: Center(
                child: Text('Unable to fetch Image.'),
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Spacer(),
        ],
      ),
    );
  }
}