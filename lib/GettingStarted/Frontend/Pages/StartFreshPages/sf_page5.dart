import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/option_tile.dart';

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
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
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
                    "assets/images/one_banner.png",
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
