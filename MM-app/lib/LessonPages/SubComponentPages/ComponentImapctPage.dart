import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';

class ComponentImapctPage extends StatefulWidget {
  ComponentImapctPage({super.key});

  @override
  State<ComponentImapctPage> createState() => _ComponentImapctPageState();
}

class _ComponentImapctPageState extends State<ComponentImapctPage> {
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
  List<String> instructions = [];
  String button = '';

  Future<void> setData(Map<String, dynamic> data) async {
    setState(() {
      afterText =
          List<String>.from(data['after'].map((item) => item.toString()));
      beforeText =
          List<String>.from(data['before'].map((item) => item.toString()));
      title = data['title'];
      instructions = List<String>.from(
          data['instructions'].map((item) => item.toString()));
      ba = List<String>.from(
          data['before/after'].map((item) => item.toString()));
      button = data['button'];
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    ever(storyController.isLoading, (_) {
      if (!storyController.isLoading.value) {
        setData(storyController.pageData[5]);
      }
    });

    if (title == '') {
      if (storyController.pageData[5] != null) {
        setData(storyController.pageData[5]);
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
                      color: Colors.orange.shade300,
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
                            Icon(
                              Icons.arrow_forward,
                              size: screenHeight * 0.15,
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
  const ContentContainer(
      {super.key,
      required this.texts,
      required this.screenWidth,
      required this.isBefore,
      required this.ba});

  final List<String> texts;
  final bool isBefore;
  final double screenWidth;
  final List<String> ba;

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
              isBefore ? "Before" : "After",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: isBefore ? Colors.red : Colors.green,
              ),
              textAlign: TextAlign.start,
            ),
            ...texts.map(
              (text) {
                return Row(
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FStoryPages%2FDIamond.png?alt=media&token=98ad4d6e-dbda-4112-9e0c-d0429eef9d37",
                      height: 20,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ],
                );
              },
            ),
            const Spacer(),
          ],
        ).marginSymmetric(horizontal: screenWidth * 0.012),
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
