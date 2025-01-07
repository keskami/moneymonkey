import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';

class SolutionPage extends StatefulWidget {
  SolutionPage({super.key});

  @override
  State<SolutionPage> createState() => _SolutionPageState();
}

class _SolutionPageState extends State<SolutionPage> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  final StoryController storyController = Get.find();
  bool isEnabled = false;
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
              height: screenHeight * 0.56,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight * 0.6,
                    width: screenWidth * 0.004,
                    decoration: BoxDecoration(
                      color: Colors.lightGreenAccent,
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
                          "The Solution?",
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenWidth * 0.15,
                              height: screenHeight * 0.2,
                              child: TapToRevealContainer(
                                contents: ContentContainer(
                                  texts: [
                                    "Track Spending",
                                    "Record every expense"
                                  ],
                                  screenWidth: screenWidth,
                                ),
                                instructions: InstructionContainer(
                                  text: "Click to reveal solution 1",
                                  screenWidth: screenWidth,
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.15,
                              height: screenHeight * 0.2,
                              child: TapToRevealContainer(
                                contents: ContentContainer(
                                  texts: ["Plan Ahead", "Set monthly budget"],
                                  screenWidth: screenWidth,
                                ),
                                instructions: InstructionContainer(
                                  text: "Click to reveal solution 2",
                                  screenWidth: screenWidth,
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.15,
                              height: screenHeight * 0.2,
                              child: TapToRevealContainer(
                                onTap: () {
                                  setState(() {
                                    isEnabled = true;
                                  });
                                },
                                contents: ContentContainer(
                                  texts: [
                                    "Save First",
                                    "20% of income to savings"
                                  ],
                                  screenWidth: screenWidth,
                                ),
                                instructions: InstructionContainer(
                                  text: "Click to reveal solution 3",
                                  screenWidth: screenWidth,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
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

class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.texts,
    required this.screenWidth,
  });

  final List<String> texts;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              texts[0],
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Text(
              texts[1],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class InstructionContainer extends StatelessWidget {
  const InstructionContainer({
    super.key,
    required this.text,
    required this.screenWidth,
  });

  final String text;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
