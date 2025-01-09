import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';

class ImpactPage extends StatefulWidget {
  ImpactPage({super.key});

  @override
  State<ImpactPage> createState() => _ImpactPageState();
}

class _ImpactPageState extends State<ImpactPage> {
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
                                    "Before",
                                    "- No savings\n- Constant stress\n- Emergency = crisis"
                                  ],
                                  screenWidth: screenWidth,
                                ),
                                instructions: InstructionContainer(
                                  text: "Click for the before...",
                                  screenWidth: screenWidth,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: screenHeight * 0.2,
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
                                    "After",
                                    "- \$800 saved/month\n- Peace of mind\n- Ready for emergencies"
                                  ],
                                  screenWidth: screenWidth,
                                ),
                                instructions: InstructionContainer(
                                  text: "Click for the after...",
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
                    storyController.pageIndex.value = 0;
                    storyController.toImpact.value = false;
                    storyController.toSolution.value = false;
                    Navigator.pop(context);
                  },
                  isEnabled: isEnabled,
                  text: 'Finish',
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
                color: texts[0] == 'Before' ? Colors.red : Colors.green,
              ),
              textAlign: TextAlign.start,
            ),
            const Spacer(),
            Text(
              texts[1],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
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
