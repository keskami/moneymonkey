import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controller/controller.dart';

class MonkeyProgressWidget extends StatelessWidget {
  final ProgressController progressController;

  const MonkeyProgressWidget({Key? key, required this.progressController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      double progress = progressController.progress.value;
      double screenWidth = MediaQuery.of(context).size.width;

      return Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: screenWidth,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            left: (screenWidth - 60) *
                progress, // Make the monkey move according to progress
            child: Lottie.asset(
              'assets/images/swinging_monkey.json', // Replace with your animation path
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    });
  }
}
