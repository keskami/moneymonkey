import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class ComponentProblemPage extends StatefulWidget {
  final String scenarioText;
  final String title;
  final String subtitle;
  final String problem;
  final String instructions;
  
  const ComponentProblemPage({
    super.key,
    required this.scenarioText,
    required this.title,
    required this.subtitle,
    required this.problem,
    required this.instructions,
  });
  
  @override
  State<ComponentProblemPage> createState() => _ComponentProblemPageState();
}

class _ComponentProblemPageState extends State<ComponentProblemPage> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  final BaseLessonController baseLessonController = Get.find();
  bool isEnabled = false; // Tracks whether the NextButton should be enabled.
  
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
        
        // Story title
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
          height: screenHeight * 0.5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.004,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      
                      SizedBox(width: screenWidth * 0.02),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.scenarioText,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            
                            SizedBox(height: 20),
                            
                            Container(
                              height: screenHeight * 0.2,
                              margin: EdgeInsets.only(bottom: 20),
                              child: TapToRevealContainer(
                                onTap: () async {
                                  // Wait 6 seconds before enabling Next
                                  await Future.delayed(Duration(seconds: 6));
                                  setState(() {
                                    isEnabled = true;
                                  });
                                },
                                contents: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: LightTheme().pastelRed.withOpacity(0.7),
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.problem,
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
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: LightTheme().pastelRed.withOpacity(0.7),
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.instructions,
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
                  ),
                ),
              ],
            ),
          ),
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
        
        SizedBox(height: 20),
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
          
          // Scenario content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200, // Fixed height for mobile
                width: 4,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
              SizedBox(width: 12),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.scenarioText,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    Container(
                      height: 150,
                      child: TapToRevealContainer(
                        onTap: () async {
                          // Wait 6 seconds before enabling Next
                          await Future.delayed(Duration(seconds: 6));
                          setState(() {
                            isEnabled = true;
                          });
                        },
                        contents: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: LightTheme().pastelRed.withOpacity(0.7),
                          ),
                          child: Center(
                            child: Text(
                              widget.problem,
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
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: LightTheme().pastelRed.withOpacity(0.7),
                          ),
                          child: Center(
                            child: Text(
                              widget.instructions,
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
          
          SizedBox(height: 20),
        ],
      ).paddingSymmetric(horizontal: 16), // Mobile padding
    );
  }
}