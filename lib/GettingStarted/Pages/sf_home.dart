import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Pages/su_home.dart';
import 'package:money_monkey/GettingStarted/Widgets/next_button.dart';
import 'package:money_monkey/GettingStarted/Widgets/progress_bar.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';
import 'package:money_monkey/themes/color_themes.dart';

class StartFreshHome extends StatefulWidget {
  StartFreshHome({super.key});

  @override
  State<StartFreshHome> createState() => _StartFreshHomeState();
}

class _StartFreshHomeState extends State<StartFreshHome> {
  final StartFreshController startFreshController =
      Get.put(StartFreshController());

  bool _isNextButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: LightTheme().primaryGreen,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    void toNextPage() {
      int currentIndex = startFreshController.pageIndex.value;
      print(_isNextButtonEnabled);
      print(currentIndex);
      if (currentIndex + 1 == 2 &&
          startFreshController.learningGoal.value == 0) {
        setState(() {
          _isNextButtonEnabled = false;
        });
      } else {
        _isNextButtonEnabled = true;
      }
      if (currentIndex == 2 && startFreshController.learningGoal.value == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Pick a learning goal."),
          ),
        );
        return;
      }
      if (currentIndex + 1 > 6) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUpDetailsHome(),
            ));
        return;
      }
      startFreshController.pageIndex.value += 1;
    }

    void toPreviousPage() {
      int currentIndex = startFreshController.pageIndex.value;
      if (currentIndex > 0) {
        startFreshController.pageIndex.value -= 1;
      } else {
        Navigator.pop(context);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevent layout shift when keyboard opens
      backgroundColor: LightTheme().primaryBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Obx(
              () {
                if (startFreshController.pageIndex < 5) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          page: 0,
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
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
        () {
          if (startFreshController.pageIndex.value == 2 &&
              startFreshController.learningGoal.value > 20) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: NextButton(
                  isEnabled: false,
                  nextPage: toNextPage,
                ),
              ),
            );
          } else if (startFreshController.pageIndex.value == 4 &&
              startFreshController.startingFresh.value == 0) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: NextButton(
                  isEnabled: false,
                  nextPage: toNextPage,
                ),
              ),
            );
          } else if (startFreshController.pageIndex.value >= 0 &&
              startFreshController.pageIndex.value <
                  startFreshController.pages.length) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: NextButton(
                  isEnabled: true,
                  nextPage: toNextPage,
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
