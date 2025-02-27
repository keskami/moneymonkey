import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';

class ComponentImpactPage extends StatefulWidget {
  ComponentImpactPage({super.key});

  @override
  State<ComponentImpactPage> createState() => _ComponentImpactPageState();
}

class _ComponentImpactPageState extends State<ComponentImpactPage> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  List<String> beforeText = [];
  List<String> afterText = [];
  List<String> ba = [];
  final StoryController storyController = Get.find();
  bool isEnabled = false;

  bool isLoading = true;
  String problem = '';
  String title = '';
  String subtitle = '';
  List<String> instructions = [];
  String button = '';

  Future<void> setData(Question data) async {
    setState(() {
      afterText = List<String>.from(
          data.data.afterContent.map((item) => item.toString()));
      beforeText = List<String>.from(
          data.data.beforeContent.map((item) => item.toString()));
      title = data.data.title;
      subtitle = data.data.subtitle;
      instructions = ["Click for the before...", "Click for the after..."];
      ba = ["before", "after"];
      button = "next";
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setData(storyController.pageData[3]);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight ? webDisplay() : mobileDisplay();
  }

  Widget webDisplay() {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
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
                  SizedBox(height: screenHeight * 0.07), // Increased spacing here
                  // Main content area
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Orange bar on the left - using a Container with constraints
                      Container(
                        width: screenWidth * 0.004,
                        height: 300, // Fixed reasonable height
                        decoration: BoxDecoration(
                          color: Colors.orange.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      // Main content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "The Impact",
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 30),
                            // Before/After containers with centered arrow
                            Container(
                              height: 200, // Fixed container height
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center, // Center items vertically
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Before container with fixed width
                                  Container(
                                    width: screenWidth * 0.15,
                                    child: TapToRevealContainer(
                                      contents: ContentContainer(
                                        isBefore: true,
                                        texts: beforeText,
                                        screenWidth: screenWidth,
                                        ba: ba,
                                      ),
                                      instructions: InstructionContainer(
                                        text: instructions[0],
                                        screenWidth: screenWidth,
                                      ),
                                    ),
                                  ),
                                  // Arrow - now centered vertically
                                  Icon(
                                    Icons.arrow_forward,
                                    size: screenWidth * 0.05,
                                  ),
                                  // After container with fixed width
                                  Container(
                                    width: screenWidth * 0.15,
                                    child: TapToRevealContainer(
                                      onTap: () async {
                                        await Future.delayed(Duration(seconds: 6));
                                        setState(() {
                                          isEnabled = true;
                                        });
                                      },
                                      contents: ContentContainer(
                                        isBefore: false,
                                        texts: afterText,
                                        screenWidth: screenWidth,
                                        ba: ba,
                                      ),
                                      instructions: InstructionContainer(
                                        text: instructions[1],
                                        screenWidth: screenWidth,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  // Finish button
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
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
  }

  Widget mobileDisplay() {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title.isEmpty ? "Financial Responsibility Story" : title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Subtitle
                  Text(
                    subtitle.isEmpty ? "Taking control of your money to build a secure future" : subtitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30), // Increased spacing here
                  // Impact section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Orange bar with fixed height
                      Container(
                        width: 4,
                        height: 400, // Fixed height for mobile
                        decoration: BoxDecoration(
                          color: Colors.orange.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "The Impact",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 25), // Increased spacing
                            // Before container with constraints
                            Container(
                              height: 180, // Fixed height
                              child: TapToRevealContainer(
                                contents: ContentContainer(
                                  isBefore: true,
                                  texts: beforeText,
                                  screenWidth: screenWidth,
                                  ba: ba,
                                ),
                                instructions: InstructionContainer(
                                  text: instructions[0],
                                  screenWidth: screenWidth,
                                ),
                              ),
                            ),
                            // Center arrow between boxes
                            Container(
                              height: 60,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_downward,
                                  size: 40,
                                ),
                              ),
                            ),
                            // After container with constraints
                            Container(
                              height: 180, // Fixed height
                              child: TapToRevealContainer(
                                onTap: () async {
                                  await Future.delayed(Duration(seconds: 6));
                                  setState(() {
                                    isEnabled = true;
                                  });
                                },
                                contents: ContentContainer(
                                  isBefore: false,
                                  texts: afterText,
                                  screenWidth: screenWidth,
                                  ba: ba,
                                ),
                                instructions: InstructionContainer(
                                  text: instructions[1],
                                  screenWidth: screenWidth,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  // Finish button
                  Center(
                    child: CustomNextButton(
                      nextPage: () {
                        storyController.pageIndex.value = 0;
                        storyController.toImpact.value = false;
                        storyController.toSolution.value = false;
                        Navigator.pop(context);
                      },
                      isEnabled: isEnabled,
                      text: 'Finish',
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.texts,
    required this.screenWidth,
    required this.isBefore,
    required this.ba,
  });

  final List<String> texts;
  final bool isBefore;
  final double screenWidth;
  final List<String> ba;

  @override
  Widget build(BuildContext context) {
    // Create a more compact layout without excess space
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Important - use minimum space needed
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBefore ? "Before" : "After",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: isBefore ? Colors.red : Colors.green,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 8),
          // Limited height for the content
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 120, // Limit the height of content
            ),
            child: ListView(
              shrinkWrap: true, // Important for proper sizing
              padding: EdgeInsets.zero, // Remove padding
              physics: NeverScrollableScrollPhysics(), // Disable scrolling
              children: texts.map(
                (text) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Keep the exact diamond image
                        Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FStoryPages%2FDIamond.png?alt=media&token=98ad4d6e-dbda-4112-9e0c-d0429eef9d37",
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            text,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
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
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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