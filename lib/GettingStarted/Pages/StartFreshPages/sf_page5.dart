import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GettingStarted/Widgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';

class StartFreshPage5 extends StatelessWidget {
  const StartFreshPage5({super.key});

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
                  "Where would you\nlike to start?",
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
          ),
          CustomOptionTile(
            childWidget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Distribute space between widgets
                children: [
                  Image.asset(
                    "assets/images/one.png",
                    width: 100,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Start from scratch",
                        style: GoogleFonts.fredoka().copyWith(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            "\nTake the easiest lesson of our\nfinancial literacy course",
                        style: GoogleFonts.fredoka().copyWith(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
          CustomOptionTile(
            childWidget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Distribute space between widgets
                children: [
                  Image.asset(
                    "assets/images/magnifying_glass.png",
                    width: 95,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Find my level",
                        style: GoogleFonts.fredoka().copyWith(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            "\nLet Money Monkey recommend\nwhere you should start learning",
                        style: GoogleFonts.fredoka().copyWith(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
