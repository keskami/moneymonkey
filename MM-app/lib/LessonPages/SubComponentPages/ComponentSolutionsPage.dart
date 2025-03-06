import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';
 
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';

class ComponentSolutionsPage extends StatefulWidget {
  ComponentSolutionsPage({super.key});

  @override
  State<ComponentSolutionsPage> createState() => _ComponentSolutionsPageState();
}

class _ComponentSolutionsPageState extends State<ComponentSolutionsPage> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  final StoryController storyController = Get.find();
  List<String> bigTexts = [];
  List<String> smallTexts = [];
  bool isEnabled = false;

  bool isLoading = true;
  String title = '';
  String subtitle = '';
  List<String> instructions = [];
  String button = '';

  Future<void> setData(SubComponent data) async {
    setState(() {
      bigTexts = [data.data.Card1[0], data.data.Card2[0], data.data.Card3[0]];
      smallTexts = [data.data.Card1[1], data.data.Card2[1], data.data.Card3[1]];
      title = data.data.title;
      subtitle = data.data.subtitle;
      instructions = [
        "Click for solution 1...",
        "Click for solution 2...",
        "Click for solution 3..."
      ];
      button = "Next";
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setData(storyController.pageData[2]);

    if (title == '') {
      if (storyController.pageData[4] != null) {
        setData(storyController.pageData[2]);
      } else {
        debugPrint("Page data for index 1 is null");
      }
    }
  }

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
            // Added title
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Added subtitle
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenHeight * 0.07),
            Container(
              height: screenHeight * 0.4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight * 0.4,
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
                                  texts: [bigTexts[0], smallTexts[0]],
                                  screenWidth: screenWidth,
                                ),
                                instructions: InstructionContainer(
                                  text: instructions[0],
                                  screenWidth: screenWidth,
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.15,
                              height: screenHeight * 0.2,
                              child: TapToRevealContainer(
                                contents: ContentContainer(
                                  texts: [bigTexts[1], smallTexts[1]],
                                  screenWidth: screenWidth,
                                ),
                                instructions: InstructionContainer(
                                  text: instructions[1],
                                  screenWidth: screenWidth,
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.15,
                              height: screenHeight * 0.2,
                              child: TapToRevealContainer(
                                onTap: () async {
                                  await Future.delayed(Duration(seconds: 6));
                                  setState(() {
                                    isEnabled = true;
                                  });
                                },
                                contents: ContentContainer(
                                  texts: [bigTexts[2], smallTexts[2]],
                                  screenWidth: screenWidth,
                                ),
                                instructions: InstructionContainer(
                                  text: instructions[2],
                                  screenWidth: screenWidth,
                                ),
                              ),
                            ),
                          ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add the title and subtitle for mobile display as well
        Text(
          "Financial Responsibility Story",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Taking control of your money to build a secure future",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        // Add the rest of your mobile layout here
      ],
    );
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
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start, // Left align all content
        children: [
          Text(
            texts[0],
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left, // Left align heading
          ),
          SizedBox(height: 10), // Add consistent spacing
          Text(
            texts[1],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left, // Left align body text
          ),
        ],
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