import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class ProblemPage extends StatefulWidget {
  ProblemPage({super.key});

  @override
  State<ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  final StoryController storyController = Get.find();
  bool isEnabled = false; // Tracks whether the NextButton should be enabled.

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight ? webDisplay() : mobileDisplay();
  }

  Widget webDisplay() {
    return Container(
      width: screenWidth * 0.5,
      height: screenHeight * 0.65,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight * 0.6,
                    width: screenWidth * 0.004,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.02,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alex earns \$4,000 monthly but often runs out of money by month-end.",
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: screenHeight * 0.2,
                          child: TapToRevealContainer(
                            onTap: () {
                              setState(() {
                                isEnabled = true;
                              });
                            },
                            contents: Container(
                              width: screenWidth * 0.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: LightTheme().pastelRed.withOpacity(
                                         0.7,
                                      )),
                              child: Center(
                                child: Text(
                                  "Problem: No control over spending",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            instructions: Container(
                              width: screenWidth * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightTheme().pastelRed.withOpacity(
                                       0.7,
                                    ),
                              ),
                              child: Center(
                                child: Text(
                                  "Click to reveal the problem...",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).marginSymmetric(vertical: screenHeight * 0.05),
            ),
            Row(
              children: [
                Spacer(),
                CustomNextButton(
                  nextPage: () {
                    storyController.pageIndex.value += 1;
                  },
                  isEnabled: isEnabled,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget mobileDisplay() {
    return Column();
  }
}
