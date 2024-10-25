import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/next_button.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/intro_pages_controller.dart';
import 'package:money_monkey/themes/color_themes.dart';

class GettingStartedHome extends StatefulWidget {
  GettingStartedHome({super.key});

  @override
  State<GettingStartedHome> createState() => _GettingStartedHomeState();
}

class _GettingStartedHomeState extends State<GettingStartedHome> {
  final GettingStartedController gettingStartedController =
      Get.put(GettingStartedController());

  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });
  }

  void toNextPage() {
    int currentIndex = gettingStartedController.pageIndex.value;
    if (currentIndex + 1 > 6) {
      return;
    }
    gettingStartedController.pageIndex.value += 1;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: LightTheme().primaryGreen,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: LightTheme().primaryBackgroundColor,
      body: SafeArea(
        child: Obx(() {
          if (gettingStartedController.pageIndex.value <
              gettingStartedController.pages.length) {
            return gettingStartedController
                .pages[gettingStartedController.pageIndex.value];
          } else {
            return const Center(child: Text('Invalid page index'));
          }
        }),
      ),
      floatingActionButton: Obx(
        () => !_isKeyboardVisible &&
                gettingStartedController.pageIndex.value >= 1 &&
                gettingStartedController.pageIndex.value <= 4 &&
                (gettingStartedController.pageIndex.value != 4 ||
                    gettingStartedController.age.value != 0)
            ? Container(
                margin: const EdgeInsets.only(
                  bottom: 50,
                ),
                child: NextButton(
                  nextPage: toNextPage,
                  pages: 0,
                ),
              )
            : const SizedBox.shrink(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
