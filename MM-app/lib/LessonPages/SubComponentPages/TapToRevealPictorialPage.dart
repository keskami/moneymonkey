import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/ScenarioController.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ComponentImapctPage.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class TapToRevealPictorialPage extends StatefulWidget {
  const TapToRevealPictorialPage({super.key});
  @override
  _TapToRevealPictorialPageState createState() =>
      _TapToRevealPictorialPageState();
}

class _TapToRevealPictorialPageState extends State<TapToRevealPictorialPage> {
  final ScenarioController scenarioController = Get.find();
  bool wait6 = false;
  bool c = false;
  bool s = false;
  bool a = false;
  String title = '';
  List<String> items = [];
  List<String> itemImgs = [];
  List<String> instructions = [];
  String monkeyImg = "";
  bool loading = false;
  String button = '';

  Future<void> setData(Question data) async {
    setState(() {
      IntroductionPage introData = data.data as IntroductionPage;
      title = introData.scenario;
      button = "Start Managing Your Money";
      items = List<String>.from(introData.options.map((item) => item.title));
      itemImgs =
          List<String>.from(introData.options.map((item) => item.iconUrl));
      monkeyImg = introData.mintyImage;
      instructions = [
        "Click for choice 1...",
        "Click for choice 2...",
        "Click for choice 3..."
      ];
      wait6sec();
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (scenarioController.pageData.isNotEmpty &&
        scenarioController.pageData[0] != null) {
      setData(scenarioController.pageData[0]);
    }
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

    return loading
        ? Center(child: CircularProgressIndicator())
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: [
              // Scenario container
              Container(
                width: screenWidth * 0.5,
                height: screenHeight * 0.3,
                decoration: BoxDecoration(
                  color: LightTheme().primaryBlue.withAlpha(70),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      monkeyImg,
                      height: screenHeight * 0.2,
                    ),
                    Expanded(
                      child: Text(
                        title,
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
              
              // Choice containers - FIX: Use Row with center alignment
              Padding(
                padding: EdgeInsets.fromLTRB(0, screenHeight * .04, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the choices
                  children: [
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
                            image: itemImgs[0],
                            texts: [items[0]],
                            screenWidth: screenWidth,
                            onFlip: () => makeTrue(items[0]),
                          ),
                          instructions: InstructionContainer(
                            text: instructions[0],
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
                      child: Container(
                        width: screenWidth * 0.13,
                        height: screenHeight * 0.17,
                        child: TapToRevealContainer(
                          contents: NewContentContainer(
                            image: itemImgs[1],
                            texts: [items[1]],
                            screenWidth: screenWidth,
                            onFlip: () => makeTrue(items[1]),
                          ),
                          instructions: InstructionContainer(
                            text: instructions[1],
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
                        print("CLikced");
                        setState(() {
                          a = true;
                        });
                      },
                      child: Container(
                        width: screenWidth * 0.13,
                        height: screenHeight * 0.17,
                        child: TapToRevealContainer(
                          contents: NewContentContainer(
                            image: itemImgs[2],
                            texts: [items[2]],
                            screenWidth: screenWidth,
                            onFlip: () => makeTrue(items[2]),
                          ),
                          instructions: InstructionContainer(
                            text: instructions[2],
                            screenWidth: screenWidth,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(
                height: screenHeight * 0.1,
              ),
              
              // Button
              GestureDetector(
                onTap: (wait6)
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
                      button,
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
              textAlign: TextAlign.center,
              style: GoogleFonts.baloo2(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Image.network(
              '$image',
              height: screenWidth * 0.05,
            ),
          ],
        ).marginSymmetric(horizontal: screenWidth * 0.012),
      ),
    );
  }
}