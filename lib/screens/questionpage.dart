import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymonkey/controller/controller.dart';
import 'package:moneymonkey/widgets/custom_app_bar.dart';
import 'package:moneymonkey/widgets/continue_button.dart';
import "../widgets/optionsList.dart";

class QuestionPage extends StatelessWidget {
  final ProgressController progressController = Get.put(ProgressController());

  QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: CustomAppBar(progressController: progressController),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Monkey Image with Question
        Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    SizedBox(
      width: screenWidth * 0.3,
      child: Image.asset(
        'assets/images/quizMonkey.png',
        height: screenHeight * 0.2,
        fit: BoxFit.contain,
      ),
    ),
    const SizedBox(width: 3),
    Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/speech_bubble.png', // Replace with your speech bubble image path
            width: screenWidth * 0.6,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "What is the main purpose of money?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Baloo 2",
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  ],
),

           // const SizedBox(height: 20),
            // Options List
            OptionsList(),
          ],
        ),
        bottomNavigationBar: const ContinueButtonSection(),
      ),
    );
  }
}

class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(20, 0)
      ..lineTo(size.width - 20, 0)
      ..arcToPoint(Offset(size.width, 20), radius: const Radius.circular(20))
      ..lineTo(size.width, size.height - 20)
      ..arcToPoint(Offset(size.width - 20, size.height), radius: const Radius.circular(20))
      ..lineTo(size.width / 2 + 10, size.height) // Position arrow near the center
      ..lineTo(size.width / 2, size.height + 10) // Arrow tip
      ..lineTo(size.width / 2 - 10, size.height) // Arrow base
      ..lineTo(20, size.height)
      ..arcToPoint(Offset(0, size.height - 20), radius: const Radius.circular(20))
      ..lineTo(0, 20)
      ..arcToPoint(Offset(20, 0), radius: const Radius.circular(20))
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

