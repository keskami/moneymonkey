import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GettingStarted/Widgets/chat_bubble.dart';

class StartFreshPage4 extends StatelessWidget {
  const StartFreshPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 17,
          ),
          Row(
            children: [
              Image.asset(
                "assets/images/money_monkey.png",
                height: 145,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 145,
                  width: 137,
                  child: Center(
                    child: Text('Unable to fetch Image.'),
                  ),
                ),
              ),
              const ChatBubbleContainer(
                trianglePosition: TrianglePosition.left,
                borderRadius: 12,
                borderWidth: 1,
                childWidget: Text(
                  "Here's what you can\nachieve in 3 months!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ), //First Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Distribute space between widgets
            children: [
              Image.asset(
                "assets/images/rework.png",
                width: 100,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Master Financial Habits",
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "\nBudgeting tools, savings plans,\nand expense tracking.",
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ]),
              )
            ],
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Distribute space between widgets
            children: [
              Image.asset(
                "assets/images/blue_icon.png",
                width: 100,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Build your Financial Blueprint",
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "\nFinancial planning guides, investment\nsimulations, and personalized advice.",
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ]),
              )
            ],
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Distribute space between widgets
            children: [
              Image.asset(
                "assets/images/watch.png",
                width: 100,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Develop a Learning Habit",
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "\nSmart reminders, fun challenges,\nand more.",
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ]),
              )
            ],
          ),
        ],
      ),
    );
  }
}
