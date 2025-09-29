import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';

class ComponentSolutionsPage extends StatefulWidget {
  final List<String> bigTexts;
  final List<String> smallTexts;
  final String title;
  final String subtitle;
  final List<String> instructions;
  final String button; // If you want to customize the "Next" label, etc.
  
  const ComponentSolutionsPage({
    super.key,
    required this.bigTexts,
    required this.smallTexts,
    required this.title,
    required this.subtitle,
    required this.instructions,
    required this.button,
  });
  
  @override
  State<ComponentSolutionsPage> createState() => _ComponentSolutionsPageState();
}

class _ComponentSolutionsPageState extends State<ComponentSolutionsPage> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  final BaseLessonController baseLessonController = Get.find();
  bool isEnabled = false;
  
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    
    return screenWidth > screenHeight 
        ? webDisplay() 
        : mobileDisplay();
  }
  
  Widget webDisplay() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenWidth * 0.02),
        
        // Title
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        
        SizedBox(height: screenHeight * 0.02),
        
        // Subtitle
        Text(
          widget.subtitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        
        SizedBox(height: screenHeight * 0.07),
        
        // Main content
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
              
              SizedBox(width: screenWidth * 0.02),
              
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
                        // Card 1
                        Container(
                          width: screenWidth * 0.15,
                          height: screenHeight * 0.2,
                          child: TapToRevealContainer(
                            contents: ContentContainer(
                              texts: [
                                widget.bigTexts[0],
                                widget.smallTexts[0]
                              ],
                              screenWidth: screenWidth,
                            ),
                            instructions: InstructionContainer(
                              text: widget.instructions[0],
                              screenWidth: screenWidth,
                            ),
                          ),
                        ),
                        
                        // Card 2
                        Container(
                          width: screenWidth * 0.15,
                          height: screenHeight * 0.2,
                          child: TapToRevealContainer(
                            contents: ContentContainer(
                              texts: [
                                widget.bigTexts[1],
                                widget.smallTexts[1]
                              ],
                              screenWidth: screenWidth,
                            ),
                            instructions: InstructionContainer(
                              text: widget.instructions[1],
                              screenWidth: screenWidth,
                            ),
                          ),
                        ),
                        
                        // Card 3 (enables the "Next" button on tap)
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
                              texts: [
                                widget.bigTexts[2],
                                widget.smallTexts[2]
                              ],
                              screenWidth: screenWidth,
                            ),
                            instructions: InstructionContainer(
                              text: widget.instructions[2],
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
        
        SizedBox(height: 20),
        
        // Next button
        Row(
          children: [
            Spacer(),
            CustomNextButton(
              nextPage: () {
                baseLessonController.pageIndex.value += 1;
              },
              isEnabled: isEnabled,
            ),
          ],
        ),
      ],
    ).paddingSymmetric(horizontal: screenWidth * 0.25); // Key for proper alignment
  }
  
  Widget mobileDisplay() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          
          SizedBox(height: 10),
          
          // Subtitle
          Text(
            widget.subtitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          SizedBox(height: 20),
          
          // Main content - vertical layout for mobile
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 350, // Fixed height for mobile
                  width: 4,
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                
                SizedBox(width: 12),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "The Solution?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Stack cards vertically for mobile
                      Column(
                        children: [
                          // Card 1
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(bottom: 10),
                            child: TapToRevealContainer(
                              contents: ContentContainer(
                                texts: [
                                  widget.bigTexts[0],
                                  widget.smallTexts[0]
                                ],
                                screenWidth: screenWidth,
                              ),
                              instructions: InstructionContainer(
                                text: widget.instructions[0],
                                screenWidth: screenWidth,
                              ),
                            ),
                          ),
                          
                          // Card 2
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(bottom: 10),
                            child: TapToRevealContainer(
                              contents: ContentContainer(
                                texts: [
                                  widget.bigTexts[1],
                                  widget.smallTexts[1]
                                ],
                                screenWidth: screenWidth,
                              ),
                              instructions: InstructionContainer(
                                text: widget.instructions[1],
                                screenWidth: screenWidth,
                              ),
                            ),
                          ),
                          
                          // Card 3
                          Container(
                            height: 100,
                            child: TapToRevealContainer(
                              onTap: () async {
                                await Future.delayed(Duration(seconds: 6));
                                setState(() {
                                  isEnabled = true;
                                });
                              },
                              contents: ContentContainer(
                                texts: [
                                  widget.bigTexts[2],
                                  widget.smallTexts[2]
                                ],
                                screenWidth: screenWidth,
                              ),
                              instructions: InstructionContainer(
                                text: widget.instructions[2],
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
            ),
          ),
          
          SizedBox(height: 30),
          
          // Next button
          Row(
            children: [
              Spacer(),
              CustomNextButton(
                nextPage: () {
                  baseLessonController.pageIndex.value += 1;
                },
                isEnabled: isEnabled,
              ),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 16), // Mobile padding
    );
  }
}

// Helper widgets - keep these unchanged
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
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Text(
            texts[0], // "bigText"
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          Text(
            texts[1], // "smallText"
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
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
      width: screenWidth * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      padding: EdgeInsets.all(8),
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