import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPage extends StatefulWidget {
  IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight ? webDisplay() : mobileDisplay();
  }

  Widget webDisplay() {
    return Container(
      width: screenWidth * 0.5,
      height: screenHeight * 0.65,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.56,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight * 0.6,
                    width: screenWidth * 0.004,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty_Monkey.png?alt=media&token=03208304-90b4-4326-a9ca-f66abbd75e70",
                  ),
                ],
              ).marginSymmetric(vertical: screenHeight * 0.05),
            )
          ],
        ),
      ),
    );
  }

  Widget mobileDisplay() {
    return Column();
  }
}
