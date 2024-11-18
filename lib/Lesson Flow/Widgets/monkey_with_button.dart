import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/banknote.dart';

import '../controller/controller.dart'; // Controller for progress

class MonkeyImageWithButton extends StatelessWidget {
  const MonkeyImageWithButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProgressController progressController =
        Get.find<ProgressController>();
    return Container(
      height: 190,
      width: double.maxFinite,
      margin: const EdgeInsets.only(left: 38, right: 36),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/monkeywithcap.png",
            height: 190,
            width: double.maxFinite,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.maxFinite,
              height: 36,
              margin: const EdgeInsets.only(bottom: 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0XFF87CEEB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  visualDensity: const VisualDensity(
                    vertical: -4,
                    horizontal: -4,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                ),
                onPressed: () {
                  progressController
                      .incrementProgress(); // Increment the progress
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BankNotePage(),
                    ),
                  );
                  // Get.toNamed('/bankPageRoute'); // Navigate to the next page
                },
                child: const Text(
                  "Done",
                  style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 19,
                    fontFamily: 'Baloo 2',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
