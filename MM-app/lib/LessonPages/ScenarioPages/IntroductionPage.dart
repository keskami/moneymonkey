import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/ScenarioController.dart';
import 'package:money_monkey/LessonPages/Pages_Story/ImpactPage.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final ScenarioController scenarioController = Get.find();
  bool wait6 = false;
  bool c = false;
  bool s = false;
  bool a = false;

  @override
  void initState() {
    super.initState();
    wait6sec();
  }

  Future<void> wait6sec() async {
    await Future.delayed(Duration(seconds: 6));
    setState(() {
      wait6 = true;
    });
  }

  Future<void> makeTrue(String name) async {
    print(name);
    if (name == "College") {
      setState(() {
        c = true;
      });
    } else if (name == "Sneakers") {
      setState(() {
        s = true;
      });
    } else {
      setState(() {
        a = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: screenWidth * 0.5,
          height: screenHeight * 0.3,
          decoration: BoxDecoration(
            color: LightTheme().primaryBlue.withAlpha(70),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                height: screenHeight * 0.2,
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
              ),
              Expanded(
                child: Text(
                  "Congratulations! You've just started your first part-time job and earned your first paycheck of \$500. You have several things you want to do with the money: buy new sneakers, save for college, and plan for weekend activities.",
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ).paddingSymmetric(
            horizontal: screenWidth * 0.02,
            vertical: screenHeight * 0.05,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, screenHeight * .04, 0, 0),
          child: Row(children: [
            SizedBox(
              width: screenWidth * .025,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  s = true;
                });
              },
              child: Container(
                width: screenWidth * 0.13,
                height: screenHeight * 0.17,
                child: TapToRevealContainer(
                  contents: NewContentContainer(
                    image:
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Fsneakers%201.png?alt=media&token=625bdbab-4e8d-42cd-82b4-8f79a1bedf3f",
                    texts: ['Sneakers'],
                    screenWidth: screenWidth,
                    onFlip: () => makeTrue("Sneakers"),
                  ),
                  instructions: InstructionContainer(
                    text: "Click for choice 1...",
                    screenWidth: screenWidth,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * .025,
            ),
             GestureDetector(
              onTap: () {
                setState(() {
                  c = true;
                });
              },
              child:
            Container(
              width: screenWidth * 0.13,
              height: screenHeight * 0.17,
              child: TapToRevealContainer(
                contents: NewContentContainer(
                  image:
                      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Fcollege%201.png?alt=media&token=cd5510da-9563-41a8-a2eb-bd13594312a3",
                  texts: ['College'],
                  screenWidth: screenWidth,
                  onFlip: () => makeTrue("College"),
                ),
                instructions: InstructionContainer(
                  text: "Click for choice 2...",
                  screenWidth: screenWidth,
                ),
              ),
            ),),
            SizedBox(
              width: screenWidth * .025,
            ),
            GestureDetector(
              onTap: () {
                print("CLikced");
                setState(() {
                  a = true;
                });
              },
            child:
            Container(
              width: screenWidth * 0.13,
              height: screenHeight * 0.17,
              child: TapToRevealContainer(
                contents: NewContentContainer(
                  image:
                      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Factivities%201.png?alt=media&token=8a2aa7b5-e154-4aa9-ae20-44cfc38e01a7",
                  texts: ['Activities'],
                  screenWidth: screenWidth,
                  onFlip: () => makeTrue("Activities"),
                ),
                instructions: InstructionContainer(
                  text: "Click for choice 3...",
                  screenWidth: screenWidth,
                ),
              ),
            ),),
          ]),
        ),
        SizedBox(
          height: screenHeight * 0.1,
        ),
        GestureDetector(
            onTap: (wait6 )
                ? () {
                    scenarioController.pageIndex.value += 1;
                  }
                : () {},
            child: Container(
              decoration: BoxDecoration(
                color: (wait6)
                    ? LightTheme().pastelGreen
                    : Color.fromRGBO(227, 227, 227, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              width: screenWidth * 0.18,
              height: screenHeight * 0.08,
              child: Center(
                child: Text(
                  "Start Managing Your Money",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}

class NewContentContainer extends StatelessWidget {
  NewContentContainer(
      {super.key,
      required this.texts,
      required this.screenWidth,
      required this.image,
      required this.onFlip});

  final List<String> texts;
  final String image;
  final double screenWidth;
  final Function onFlip;

  @override
  Widget build(BuildContext context) {
    onFlip;
    return Container(
      width: screenWidth * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              texts[0],
              style: GoogleFonts.baloo2(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Image.network(
              '$image',
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              height: screenWidth * 0.05,
            ),
          ],
        ).marginSymmetric(horizontal: screenWidth * 0.012),
      ),
    );
  }
}
