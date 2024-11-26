import 'package:flutter/material.dart';

class GettingStartedPage3 extends StatelessWidget {
  const GettingStartedPage3({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: screenWidth > screenHeight
            ? webDisplay(screenWidth)
            : mobileDisplay(),
      ),
    );
  }

  Widget mobileDisplay() {
    return Column(
      children: [
        const SizedBox(
          height: 45,
        ),
        const Text(
          "Money Monkey gives\nyou friendly feedback.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 35,
        ),
        const Text(
          "Learn to manage your money wisely,\navoid common pitfalls, and build a\nbrighter financial future.",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Image.network(
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgs_blackboard.png?alt=media&token=08191299-2a7a-41e3-8965-3e6ee3e52eeb",
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
      ],
    );
  }

  Widget webDisplay(double screenWidth) {
    return Row(
      children: [
        Container(
          width: screenWidth * 0.5,
          child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgs_blackboard.png?alt=media&token=08191299-2a7a-41e3-8965-3e6ee3e52eeb",
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
        ),
        Container(
          width: screenWidth * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Money Monkey gives\nyou friendly feedback.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                "Learn to manage your money wisely,\navoid common pitfalls, and build a\nbrighter financial future.",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
