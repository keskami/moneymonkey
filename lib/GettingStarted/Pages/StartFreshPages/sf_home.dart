import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Widgets/next_button.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';
import 'package:money_monkey/themes/color_themes.dart';

class StartFreshHome extends StatelessWidget {
  StartFreshHome({super.key});
  final StartFreshController startFreshController =
      Get.put(StartFreshController());

  @override
  Widget build(BuildContext context) {
    void toPreviousPage() {
      int currentIndex = startFreshController.pageIndex.value;
      if (currentIndex == 0) {
        Navigator.pop(context);
      }
      if (currentIndex - 1 < 0) {
        return;
      }
      startFreshController.pageIndex.value -= 1;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightTheme().primaryGreen,
        leading: IconButton(
            onPressed: toPreviousPage,
            icon: Icon(
              Icons.arrow_back_ios,
              color: LightTheme().primaryBackgroundColor,
            )),
      ),
      backgroundColor: LightTheme().primaryBackgroundColor,
      body: Obx(() {
        // Ensure pageIndex is within bounds
        if (startFreshController.pageIndex.value <
            startFreshController.pages.length) {
          return startFreshController
              .pages[startFreshController.pageIndex.value];
        } else {
          return const Center(child: Text('Invalid page index'));
        }
      }),
      floatingActionButton: Obx(
        () => startFreshController.pageIndex.value >= 0 &&
                startFreshController.pageIndex.value <= 2
            ? Container(
                margin: const EdgeInsets.only(
                  bottom: 50,
                ),
                child: const NextButton(
                  pages: 1,
                ),
              )
            : const SizedBox.shrink(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
