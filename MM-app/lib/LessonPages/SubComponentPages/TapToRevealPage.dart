import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';

import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';

class TapToRevealPage extends StatefulWidget {
  final String title;
  final String bigTop;
  final String bigBottom;
  final String little;
  final String before;
  const TapToRevealPage(
      {super.key,
      required this.title,
      required this.bigTop,
      required this.bigBottom,
      required this.little,
      required this.before});

  @override
  State<TapToRevealPage> createState() {
    return _TapToRevealPageState();
  }
}

class _TapToRevealPageState extends State<TapToRevealPage> {
  BaseLessonController baseLessonController = Get.find<BaseLessonController>();
  bool showContent = false;
  bool enableNext = false;
  late Column contents;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).clearSnackBars();
    });
  }

  @override
  Widget build(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    initializeContents(screenWidth, screenHeight);
    if (showContent) {
      Future.delayed(
        Duration(seconds: 6),
        () {
          setState(() {
            enableNext = true;
          });
        },
      );
    }
    return screenWidth > screenHeight
        ? webDisplay(screenWidth, screenHeight)
        : mobileDisplay();
  }

  Widget webDisplay(double screenWidth, double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenWidth * 0.02),
        Text(
          widget.title,
          softWrap: true,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ).marginSymmetric(
          vertical: screenHeight * 0.025,
          horizontal: screenWidth * 0.015,
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: Container(
            key: ValueKey<bool>(
                showContent), // Important for AnimatedSwitcher to detect changes
            width: double.infinity,
            height: screenHeight * 0.55,
            child: showContent ? contents : TapToShowContainer(),
          ),
        ),

        SizedBox(
          height: screenHeight * 0.05,
        ),
        //Next Button Row
        Row(
          children: [
            const Spacer(),
            CustomNextButton(
              nextPage: () {
                baseLessonController.pageIndex.value += 1;
              },
              isEnabled: enableNext,
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
          ],
        )
      ],
    ).paddingSymmetric(horizontal: screenWidth * 0.25);
  }

  Scaffold mobileDisplay() {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "",
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(),
          ],
        )),
      ),
    );
  }

  Column initializeContents(double screenWidth, double screenHeight) {
    return contents = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 4,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.05,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(0, 3),
                ),
              ],
              color: Color.fromARGB(255, 226, 247, 255),
            ),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: widget.bigTop,
                  style: GoogleFonts.baloo2(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: widget.bigBottom,
                      style: GoogleFonts.baloo2(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Flexible(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.04,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            child: Text(
              widget.little,
              style: GoogleFonts.baloo2(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector TapToShowContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showContent = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.before,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
