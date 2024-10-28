import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/sf_home.dart';
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
    if (currentIndex + 1 == 6) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StartFreshHome(),
          ));
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
      floatingActionButton: Obx(() {
        if (!_isKeyboardVisible &&
            gettingStartedController.pageIndex.value == 5 &&
            gettingStartedController.knowledgeLevel.value > 4) {
          return Container(
            margin: const EdgeInsets.only(
              bottom: 50,
            ),
            child: NextButton(
              nextPage: toNextPage,
              isEnabled: false,
              pages: 0,
            ),
          );
        } else if (!_isKeyboardVisible &&
            gettingStartedController.pageIndex.value >= 1 &&
            gettingStartedController.pageIndex.value <= 5 &&
            (gettingStartedController.pageIndex.value != 5 ||
                gettingStartedController.age.value != 0)) {
          return Container(
            margin: const EdgeInsets.only(
              bottom: 50,
            ),
            child: NextButton(
              nextPage: toNextPage,
              isEnabled: true,
              pages: 0,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
