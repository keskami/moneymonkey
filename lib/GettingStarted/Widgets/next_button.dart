import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/controller/gs_controller.dart';

class NextButton extends StatelessWidget {
  NextButton({
    super.key,
  });
  final GettingStartedController gettingStartedController =
      Get.put(GettingStartedController());
  void onNextClick() {
    gettingStartedController.pageIndex.value += 1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNextClick,
      child: Image.asset("assets/nextButton.png"),
    );
  }
}
