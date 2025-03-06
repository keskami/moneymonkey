import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';
 
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class ComponentProblemPage extends StatefulWidget {
  ComponentProblemPage({super.key});

  @override
  State<ComponentProblemPage> createState() => _ComponentProblemPageState();
}

class _ComponentProblemPageState extends State<ComponentProblemPage> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  final StoryController storyController = Get.find();
  bool isEnabled = false; // Tracks whether the NextButton should be enabled.
  String scenarioText = '';
  String title = '';
  String subtitle = '';
  bool isLoading = true;
  String problem = '';
  String instructions = '';

  Future<void> setData(SubComponent data) async {
    setState(() {
      scenarioText = data.data.scenarioText;
      title = data.data.title;
      subtitle = data.data.subtitle;
      problem = data.data.problem;
      instructions = data.data.instructions;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setData(storyController.pageData[1]);

    if (title == '') {
      if (storyController.pageData[3] != null) {
        setData(storyController.pageData[1]);
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
                  // Story title
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Subtitle
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.07), // Increased spacing here
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: screenHeight * 0.35, // Adjusted height to prevent overflow
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
                                scenarioText,
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 20), // Fixed spacing instead of Spacer
                              Container(
                                height: screenHeight * 0.2,
                                margin: EdgeInsets.only(bottom: 20), // Added margin to prevent overflow
                                child: TapToRevealContainer(
                                  onTap: () async {
                                    await Future.delayed(Duration(seconds: 6));
                                    setState(() {
                                      isEnabled = true;
                                    });
                                  },
                                  contents: Container(
                                    width: screenWidth * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            LightTheme().pastelRed.withOpacity(
                                                  0.7,
                                                )),
                                    child: Center(
                                      child: Text(
                                        problem,
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
                                        instructions,
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
                  SizedBox(height: 20), // Added space before the Next button
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
                  SizedBox(height: 20), // Added padding at the bottom
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
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Subtitle
                  Text(
                    subtitle,
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
                              scenarioText,
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
                                      problem,
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
                                      instructions,
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
                          storyController.pageIndex.value += 1;
                        },
                        isEnabled: isEnabled,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
  }
}

// Remove the unused extension
// extension on Color {
//   withValues({required double alpha}) {}
// }