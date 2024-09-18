import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Widgets/next_button.dart';
import 'package:money_monkey/GettingStarted/controller/intro_pages_controller.dart';
import 'package:money_monkey/themes/color_themes.dart';

class GettingStartedHome extends StatelessWidget {
  GettingStartedHome({super.key});
  final GettingStartedController gettingStartedController =
      Get.put(GettingStartedController());
  void toStartFresh() {}

  void toPreviousPage() {
    int currentIndex = gettingStartedController.pageIndex.value;
    if (currentIndex - 1 < 0) {
      return;
    }
    gettingStartedController.pageIndex.value -= 1;
  }

  @override
  Widget build(BuildContext context) {
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
        if (gettingStartedController.pageIndex.value <
            gettingStartedController.pages.length) {
          return gettingStartedController
              .pages[gettingStartedController.pageIndex.value];
        } else {
          return const Center(child: Text('Invalid page index'));
        }
      }),
      floatingActionButton: Obx(
        () => gettingStartedController.pageIndex.value >= 1 &&
                gettingStartedController.pageIndex.value <= 4 &&
                (gettingStartedController.pageIndex.value != 4 ||
                    gettingStartedController.age.value != 0)
            ? Container(
                margin: const EdgeInsets.only(
                  bottom: 50,
                ),
                child: const NextButton(
                  pages: 0,
                ),
              )
            : const SizedBox.shrink(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
