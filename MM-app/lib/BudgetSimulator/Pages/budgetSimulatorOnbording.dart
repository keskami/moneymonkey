import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetSimulatorOnboarding extends StatefulWidget {
  @override
  _BudgetSimulatorOnboardingState createState() =>
      _BudgetSimulatorOnboardingState();
}

class _BudgetSimulatorOnboardingState extends State<BudgetSimulatorOnboarding> {
  final List<TyperAnimatedText> animatedTexts = [
    TyperAnimatedText(
      'Great choice! In ‘Crush the Credit Card\nDebt, you’ll work on paying down a\n\$3,000 credit card balance at a 20%\ninterest rate.',
      speed: Duration(
          milliseconds: 5000 ~/
              'Great choice! In ‘Crush the Credit Card Debt,’ you’ll work on paying down a \$3,000 credit card balance at a 20% interest rate.'
                  .length),
    ),
    TyperAnimatedText(
      'Your goal is to reduce at least 50% of that\ndebt within three months while juggling\nrent, groceries, and other living expenses.\nLet’s show you around!',
      speed: Duration(
          milliseconds: 5000 ~/
              'Your goal is to reduce at least 50% of that debt within three months while juggling rent, groceries, and other living expenses. Let’s show you around!'
                  .length),
    ),
    TyperAnimatedText(
      'Each circle marks a special target\n—like paying \$300 above the\nminimum or staying under\n\$50/week for entertainment.',
      speed: Duration(
          milliseconds: 5000 ~/
              'Each circle marks a special target—like paying \$300 above the minimum or staying under \$50/week for entertainment.'
                  .length),
    ),
  ];

  bool isLoading = false;
  int? balance;
  int totalBanans = 0;
  bool firstTime = false;
  bool beginner = false;
  bool intermediate = false;
  bool advanced = false;
  bool eventFinished = false;
  bool showSecondText = false;
  int animatedTextIndex = 2;

  String? selectedScenario = '';
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double webScreenWidthUnit = screenWidth / 1717;
    double webScreenHeightUnit = screenHeight / 2078;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: webScreenWidthUnit * 450,
                  width: webScreenWidthUnit * 550,
                  child: Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                  ),
                ),
                animatedTextIndex < 2
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: webScreenWidthUnit * 160,
                              height: webScreenHeightUnit * 100,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Color.fromRGBO(79, 195, 247, 1),
                              ),
                              child: Center(
                                child: Text("Minty",
                                    style: GoogleFonts.baloo2(
                                      fontSize: webScreenWidthUnit * 22,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    )),
                              )),
                          SizedBox(
                            height: webScreenHeightUnit * 20,
                          ),
                          Container(
                              width: webScreenWidthUnit * 856,
                              padding: EdgeInsets.fromLTRB(
                                  webScreenWidthUnit * 67,
                                  webScreenHeightUnit * 50,
                                  0,
                                  webScreenWidthUnit * 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DefaultTextStyle(
                                      style: GoogleFonts.baloo2(
                                        fontSize: webScreenWidthUnit * 36,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AnimatedTextKit(
                                            key: ValueKey<int>(
                                                animatedTextIndex), // Ensures the widget rebuilds
                                            animatedTexts: [
                                              animatedTexts[animatedTextIndex]
                                            ],
                                            isRepeatingAnimation: false,
                                            onFinished: () {
                                              setState(() {
                                                eventFinished = true;
                                              });
                                              print("Animation Finished");
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (eventFinished) {
                                          animatedTextIndex++;
                                          eventFinished = false;
                                          if (animatedTextIndex >=
                                              animatedTexts.length) {
                                            firstTime = false;
                                          }
                                        }
                                      });
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 0, webScreenWidthUnit * 38, 0),
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          size: webScreenWidthUnit * 57,
                                          color:
                                              Color.fromRGBO(79, 197, 247, 1),
                                        )),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: webScreenHeightUnit * 77,
                          ),
                        ],
                      )
                    : animatedTextIndex == 2
                        ?
                    
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(
                                  webScreenWidthUnit * 40, webScreenHeightUnit * 109, 0, 0),
                              child: speechBubbleArrowRight(
                                text:
                                    "Each circle marks a special target\n—like paying \$300 above \nthe minimum or staying under \$50/\nweek for entertainment",
                                webScreenWidthUnit: webScreenWidthUnit,
                                webScreenHeightUnit: webScreenHeightUnit,
                                header: "Milestone Circles",
                                height: 673,
                                width: 462,
                                onTap: () {
                                  setState(() {
                                    animatedTextIndex++;
                                  });
                                },
                                animatedTextIndex: animatedTextIndex,
                              )),
                        ],
                      ) :  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(
                                  webScreenWidthUnit * 40, webScreenHeightUnit * 109, 0, 0),
                              child: speechBubbleArrowRight(
                                text:
                                    "Each circle marks a special target\n—like paying \$300 above \nthe minimum or staying under \$50/\nweek for entertainment",
                                webScreenWidthUnit: webScreenWidthUnit,
                                webScreenHeightUnit: webScreenHeightUnit,
                                header: "New",
                                height: 673,
                                width: 462,
                                onTap: () {
                                  setState(() {
                                    animatedTextIndex++;
                                  });
                                },
                                animatedTextIndex: animatedTextIndex,
                              )),
                        ],
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget speechBubbleArrowRight({
  required String text,
  required double webScreenHeightUnit,
  required double webScreenWidthUnit,
  required String header,
  required Function() onTap,
  required int animatedTextIndex,
  bool eventFinished = false,
  required double height,
  required double width,
}) {
  return Center(
    child: CustomPaint(
      painter: _SpeechBubblePainter(),
      child: SizedBox(
        width: width * webScreenWidthUnit, // Set the bubble width
        height: height * webScreenHeightUnit, // Set the bubble height
        child: Padding(
            padding: EdgeInsets.fromLTRB(webScreenWidthUnit * 49,
                webScreenHeightUnit * 40, 0, webScreenWidthUnit * 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: GoogleFonts.baloo2(
                    fontSize: webScreenWidthUnit * 23,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(79, 195, 247, 1),
                  ),
                ),
                SizedBox(
                  height: webScreenHeightUnit * 15,
                ),
                AnimatedTextKit(
                  key: ValueKey<int>(animatedTextIndex),
                  animatedTexts: [
                    TyperAnimatedText(
                      text,
                      textStyle: GoogleFonts.baloo2(
                        fontSize: webScreenWidthUnit * 23,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      speed: Duration(milliseconds: 5000 ~/ text.length),
                    )
                  ],
                  isRepeatingAnimation: false,
                  onFinished: () {
                    eventFinished = true;
                  },
                ),
                Spacer(),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, webScreenWidthUnit * 40,
                        webScreenHeightUnit * 35),
                    child: GestureDetector(
                        onTap: () {
                          if (eventFinished) {
                            onTap();
                          }
                        },
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                height: webScreenHeightUnit * 85,
                                width: webScreenWidthUnit * 137,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(79, 195, 247, 1),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Center(
                                  child: Text(
                                    "Next",
                                    style: GoogleFonts.baloo2(
                                      fontSize: webScreenWidthUnit * 23,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                )))))
              ],
            )),
      ),
    ),
  );
}

class _SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(10, 0) // Top-left corner
      ..lineTo(size.width - 20, 0) // Top-right corner
      ..quadraticBezierTo(
          size.width - 10, 0, size.width - 10, 10) // Top-right curve
      ..lineTo(
          size.width - 10, size.height / 2 - 10) // Right side, before triangle
      ..lineTo(size.width, size.height / 2) // Triangle tip
      ..lineTo(
          size.width - 10, size.height / 2 + 10) // Right side, after triangle
      ..lineTo(size.width - 10, size.height - 10) // Continue bottom-right
      ..quadraticBezierTo(size.width - 10, size.height, size.width - 20,
          size.height) // Bottom-right curve
      ..lineTo(10, size.height) // Bottom-left corner
      ..quadraticBezierTo(
          0, size.height, 0, size.height - 10) // Bottom-left curve
      ..lineTo(0, 10) // Left side
      ..quadraticBezierTo(0, 0, 10, 0); // Top-left curve

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
