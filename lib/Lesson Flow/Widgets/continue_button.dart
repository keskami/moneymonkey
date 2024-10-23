import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/lessoncomplete.dart';
import 'package:money_monkey/controller/controller.dart';

class ContinueButtonSection extends StatelessWidget {
  const ContinueButtonSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch the ProgressController
    final ProgressController progressController =
        Get.find<ProgressController>();

    return Obx(() {
      return Container(
        height: 50,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.maxFinite,
              height: 38,
              margin: const EdgeInsets.only(bottom: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: progressController.isCorrectSelected.value
                      ? const Color(0XFF87CEEB) // Light blue when enabled
                      : Colors.grey, // Grey when disabled
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  visualDensity:
                      const VisualDensity(vertical: -4, horizontal: -4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
                ),
                // Only allow the button to be pressed if the correct answer is selected
                onPressed: progressController.isCorrectSelected.value
                    ? () {
                        // Get.toNamed(AppRoutes.lessonCompletePageRoute)
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LessonCompleteScreen(),
                          ),
                        );
                      }
                    : null, // Disable the button if the correct answer is not selected
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 20,
                    fontFamily: 'Baloo 2',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
