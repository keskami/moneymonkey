import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';

class ComponentImpactPage extends StatefulWidget {
  // 1) Declare all the data your page needs
  final List<String> beforeText;
  final List<String> afterText;
  final String title;
  final String subtitle;
  final List<String> instructions;
  final List<String> ba;      // [ "before", "after" ], if desired
  final String button;        // "next", if desired

  const ComponentImpactPage({
    super.key,
    required this.beforeText,
    required this.afterText,
    required this.title,
    required this.subtitle,
    required this.instructions,
    required this.ba,
    required this.button,
  });

  @override
  State<ComponentImpactPage> createState() => _ComponentImpactPageState();
}

class _ComponentImpactPageState extends State<ComponentImpactPage> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  final BaseLessonController baseLessonController = Get.find();
  bool isEnabled = false; // For enabling the 'Finish' button after tapping

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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left orange bar
            Container(
              width: screenWidth * 0.004,
              height: 300,
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
                children: [
                  Text(
                    "The Impact",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Before/After containers
                  Container(
                    height: 200, // Fixed container height
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Before
                        Container(
                          width: screenWidth * 0.15,
                          child: TapToRevealContainer(
                            contents: ContentContainer(
                              isBefore: true,
                              texts: widget.beforeText,
                              screenWidth: screenWidth,
                              ba: widget.ba,
                            ),
                            instructions: InstructionContainer(
                              text: widget.instructions[0],
                              screenWidth: screenWidth,
                            ),
                          ),
                        ),
                        
                        // Arrow
                        Icon(
                          Icons.arrow_forward,
                          size: screenWidth * 0.05,
                        ),
                        
                        // After
                        Container(
                          width: screenWidth * 0.15,
                          child: TapToRevealContainer(
                            onTap: () async {
                              // Let user see 'after' for 6 seconds
                              await Future.delayed(Duration(seconds: 6));
                              setState(() {
                                isEnabled = true;
                              });
                            },
                            contents: ContentContainer(
                              isBefore: false,
                              texts: widget.afterText,
                              screenWidth: screenWidth,
                              ba: widget.ba,
                            ),
                            instructions: InstructionContainer(
                              text: widget.instructions[1],
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
        
        // "Finish" or Next button
        Row(
          children: [
            Spacer(),
            CustomNextButton(
              nextPage: () {
                // or whichever final logic you want
                baseLessonController.pageIndex.value += 1;
              },
              isEnabled: isEnabled,
              text: 'Next',
            ),
          ],
        ),
        
        SizedBox(height: 10),
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
            widget.title.isEmpty ? "Financial Responsibility Story" : widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          
          SizedBox(height: 10),
          
          // Subtitle
          Text(
            widget.subtitle.isEmpty
                ? "Taking control of your money to build a secure future"
                : widget.subtitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          SizedBox(height: 30),
          
          // Impact row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Orange bar
              Container(
                width: 4,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.orange.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
              SizedBox(width: 12),
              
              // Main content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "The Impact",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    
                    SizedBox(height: 25),
                    
                    // "Before" container
                    Container(
                      height: 180,
                      child: TapToRevealContainer(
                        contents: ContentContainer(
                          isBefore: true,
                          texts: widget.beforeText,
                          screenWidth: screenWidth,
                          ba: widget.ba,
                        ),
                        instructions: InstructionContainer(
                          text: widget.instructions[0],
                          screenWidth: screenWidth,
                        ),
                      ),
                    ),
                    
                    // Arrow in between
                    Container(
                      height: 60,
                      child: Center(
                        child: Icon(
                          Icons.arrow_downward,
                          size: 40,
                        ),
                      ),
                    ),
                    
                    // "After" container
                    Container(
                      height: 180,
                      child: TapToRevealContainer(
                        onTap: () async {
                          await Future.delayed(Duration(seconds: 6));
                          setState(() {
                            isEnabled = true;
                          });
                        },
                        contents: ContentContainer(
                          isBefore: false,
                          texts: widget.afterText,
                          screenWidth: screenWidth,
                          ba: widget.ba,
                        ),
                        instructions: InstructionContainer(
                          text: widget.instructions[1],
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
          
          Center(
            child: CustomNextButton(
              nextPage: () {
                baseLessonController.pageIndex.value += 1;
              },
              isEnabled: isEnabled,
              text: 'Finish',
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 16), // Mobile padding
    );
  }
}

/// The container for showing the "before" or "after" text.
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBefore ? "Before" : "After",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: isBefore ? Colors.red : Colors.green,
            ),
          ),
          SizedBox(height: 8),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 120),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: texts.map((text) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Example diamond image
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
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/// The instructions container for each TapToReveal.
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
      padding: EdgeInsets.all(12),
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