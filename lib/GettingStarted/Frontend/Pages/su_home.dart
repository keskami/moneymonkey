import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemChrome
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/next_button.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/progress_bar.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/sign_up_controller.dart';
import 'package:money_monkey/themes/color_themes.dart';

class SignUpDetailsHome extends StatelessWidget {
  SignUpDetailsHome({super.key});

  final SignUpController signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: LightTheme().primaryGreen,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    void toNextPage() {
      int currentIndex = signUpController.pageIndex.value;
      if (currentIndex + 1 > 3) {
        return;
      }
      signUpController.pageIndex.value += 1;
    }

    void toPreviousPage() {
      int currentIndex = signUpController.pageIndex.value;
      if (currentIndex > 0) {
        signUpController.pageIndex.value -= 1;
      } else {
        Navigator.pop(context);
      }
    }

    return Scaffold(
      backgroundColor: LightTheme().primaryBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
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
                    page: 1,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                int pageIndex = signUpController.pageIndex.value;
                if (pageIndex < signUpController.pages.length) {
                  return signUpController.pages[pageIndex];
                } else {
                  return const Center(child: Text('Invalid page index'));
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => signUpController.pageIndex.value >= 0 &&
                signUpController.pageIndex.value < signUpController.pages.length
            ? Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: NextButton(
                  pages: 2,
                  nextPage: toNextPage,
                ),
              )
            : const SizedBox.shrink(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
