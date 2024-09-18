import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/controller/intro_pages_controller.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.pages,
  });
  final int pages;

  void onNextClick() {
    if (pages == 0) {
      final GettingStartedController gettingStartedController =
          Get.put(GettingStartedController());
      gettingStartedController.pageIndex.value += 1;
    } else if (pages == 1) {
      final StartFreshController startFreshController =
          Get.put(StartFreshController());
      startFreshController.pageIndex.value += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNextClick,
      child: Image.asset("assets/nextButton.png"),
    );
  }
}
