import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  List<String> instructions = [];
  String button = '';

  Future<void> setData(Map<String, dynamic> data) async {
    setState(() {
      bigTexts =
          List<String>.from(data['bigTexts'].map((item) => item.toString()));
      smallTexts =
          List<String>.from(data['smallTexts'].map((item) => item.toString()));
      title = data['title'];
      instructions = List<String>.from(
          data['instructions'].map((item) => item.toString()));
     
      button = data['button'];

      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    ever(storyController.isLoading, (_) {
      if (!storyController.isLoading.value) {
        setData(storyController.pageData[4]);
      }
    });

    if (title == '') {
      if (storyController.pageData[4] != null) {
        setData(storyController.pageData[4]);
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
                          title,
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
                                    bigTexts[0],
                                    smallTexts[0]
                                  ],
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
                                  texts: [bigTexts[1],
                                    smallTexts[1]],
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
                                onTap: () async{
                                  await Future.delayed(Duration(seconds: 6));
                                  setState(() {
                                    isEnabled = true;
                                  });
                                },
                                contents: ContentContainer(
                                  texts: [
                                    bigTexts[2],
                                    smallTexts[2]
                                  ],
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
