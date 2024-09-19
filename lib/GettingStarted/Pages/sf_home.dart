import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemChrome
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Widgets/next_button.dart';
import 'package:money_monkey/GettingStarted/Widgets/progress_bar.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';
import 'package:money_monkey/themes/color_themes.dart';

class StartFreshHome extends StatelessWidget {
  StartFreshHome({super.key});
  final StartFreshController startFreshController =
      Get.put(StartFreshController());

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: LightTheme().primaryGreen,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    void toPreviousPage() {
      int currentIndex = startFreshController.pageIndex.value;
      if (currentIndex > 0) {
        startFreshController.pageIndex.value -= 1;
      } else {
        Navigator.pop(context);
      }
    }

    return Scaffold(
      backgroundColor: LightTheme().primaryBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 21),
            // Row for header
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Distribute space between widgets
              children: [
                IconButton(
                  onPressed: toPreviousPage,
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 37,
                  ),
                ),
                const Expanded(
                    child: CustomProgressBar(
                        progress:
                            10)), // Make progress bar expand to fit available space
              ],
            ),
            Expanded(
              child: Obx(() {
                int pageIndex = startFreshController.pageIndex.value;
                if (pageIndex < startFreshController.pages.length) {
                  return startFreshController.pages[pageIndex];
                } else {
                  return const Center(child: Text('Invalid page index'));
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => startFreshController.pageIndex.value >= 0 &&
                startFreshController.pageIndex.value <
                    startFreshController.pages.length
            ? Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: NextButton(pages: 1),
              )
            : const SizedBox.shrink(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
