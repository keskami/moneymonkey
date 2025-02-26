import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
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
  String title = '';
  bool isLoading = true;
  String problem = '';
  String instructions = '';

  Future<void> setData(Question data) async {
    setState(() {
      title = data.data.title;
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
                                title,
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

extension on Color {
  withValues({required double alpha}) {}
}
