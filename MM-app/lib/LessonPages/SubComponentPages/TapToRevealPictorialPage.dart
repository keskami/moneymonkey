import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/TapToRevealContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class TapToRevealPictorialPage extends StatefulWidget {
  // Fields previously set in setData
  final String title;
  final String button;
  final List<String> items;
  final List<String> itemImgs;
  final String monkeyImg;
  final List<String> instructions;

  const TapToRevealPictorialPage({
    super.key,
    required this.title,
    required this.button,
    required this.items,
    required this.itemImgs,
    required this.monkeyImg,
    required this.instructions,
  });

  @override
  _TapToRevealPictorialPageState createState() =>
      _TapToRevealPictorialPageState();
}

class _TapToRevealPictorialPageState extends State<TapToRevealPictorialPage> {
  final BaseLessonController baseLessonController = Get.find();

  // Local state
  bool wait6 = false; // Controls enabling the button after 6 seconds
  bool c = false;
  bool s = false;
  bool a = false;

  @override
  void initState() {
    super.initState();
    // Kick off a 6-second delay at the start
    wait6sec();
  }

  Future<void> wait6sec() async {
    await Future.delayed(Duration(seconds: 6));
    setState(() {
      wait6 = true;
    });
  }

  Future<void> makeTrue(String name) async {
    if (name == widget.items[0]) {
      setState(() => s = true);
    } else if (name == widget.items[1]) {
      setState(() => c = true);
    } else {
      setState(() => a = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center, 
      mainAxisAlignment: MainAxisAlignment.center,
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
              Image.network(
                widget.monkeyImg,
                height: screenHeight * 0.2,
              ),
              Expanded(
                child: Text(
                  widget.title,
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

        // Choice containers
        Padding(
          padding: EdgeInsets.fromLTRB(0, screenHeight * .04, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First choice
              GestureDetector(
                onTap: () => setState(() => s = true),
                child: Container(
                  width: screenWidth * 0.13,
                  height: screenHeight * 0.17,
                  child: TapToRevealContainer(
                    contents: NewContentContainer(
                      image: widget.itemImgs[0],
                      texts: [widget.items[0]],
                      screenWidth: screenWidth,
                      onFlip: () => makeTrue(widget.items[0]),
                    ),
                    instructions: InstructionContainer(
                      text: widget.instructions[0],
                      screenWidth: screenWidth,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * .025),

              // Second choice
              GestureDetector(
                onTap: () => setState(() => c = true),
                child: Container(
                  width: screenWidth * 0.13,
                  height: screenHeight * 0.17,
                  child: TapToRevealContainer(
                    contents: NewContentContainer(
                      image: widget.itemImgs[1],
                      texts: [widget.items[1]],
                      screenWidth: screenWidth,
                      onFlip: () => makeTrue(widget.items[1]),
                    ),
                    instructions: InstructionContainer(
                      text: widget.instructions[1],
                      screenWidth: screenWidth,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * .025),

              // Third choice
              GestureDetector(
                onTap: () => setState(() => a = true),
                child: Container(
                  width: screenWidth * 0.13,
                  height: screenHeight * 0.17,
                  child: TapToRevealContainer(
                    contents: NewContentContainer(
                      image: widget.itemImgs[2],
                      texts: [widget.items[2]],
                      screenWidth: screenWidth,
                      onFlip: () => makeTrue(widget.items[2]),
                    ),
                    instructions: InstructionContainer(
                      text: widget.instructions[2],
                      screenWidth: screenWidth,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.1),

        // Button
        GestureDetector(
          onTap: wait6
              ? () {
                  baseLessonController.pageIndex.value += 1;
                }
              : null, // do nothing if wait6 == false
          child: Container(
            decoration: BoxDecoration(
              color: wait6
                  ? LightTheme().pastelGreen
                  : Color.fromRGBO(227, 227, 227, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            width: screenWidth * 0.18,
            height: screenHeight * 0.08,
            child: Center(
              child: Text(
                widget.button,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The content container displayed after tapping
class NewContentContainer extends StatelessWidget {
  final List<String> texts;
  final String image;
  final double screenWidth;
  final Function onFlip;

  const NewContentContainer({
    super.key,
    required this.texts,
    required this.screenWidth,
    required this.image,
    required this.onFlip,
  });

  @override
  Widget build(BuildContext context) {
    // onFlip is never called in build, so you might call it in TapToRevealContainer
    // or wherever you want to handle the "flip" logic. For now, we just show the text & image.
    return Container(
      width: screenWidth * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              image,
              height: screenWidth * 0.05,
            ),
          ],
        ).marginSymmetric(horizontal: screenWidth * 0.012),
      ),
    );
  }
}

/// The instructions container displayed before tapping
class InstructionContainer extends StatelessWidget {
  final String text;
  final double screenWidth;

  const InstructionContainer({
    super.key,
    required this.text,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            text,
            style: GoogleFonts.baloo2(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
