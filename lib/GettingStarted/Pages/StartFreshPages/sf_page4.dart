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
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Frework.png?alt=media&token=7988b569-33ea-461d-9030-a0e8b5d3cfb4",
                width: 100,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    // If loadingProgress is null, the image has fully loaded
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
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Master Financial Habits",
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "\nBudgeting tools, savings plans,\nand expense tracking.",
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 16,
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
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Fblue_icon.png?alt=media&token=8a2e6bb8-acaa-4d41-835a-9005a28fe3be",
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    // If loadingProgress is null, the image has fully loaded
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
                width: 100,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Build your Financial Blueprint",
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "\nFinancial planning guides, investment\nsimulations, and personalized advice.",
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 16,
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
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Fwatch.png?alt=media&token=e424e7dc-cdec-4174-bfcb-ad754d45c093",
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    // If loadingProgress is null, the image has fully loaded
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
                width: 100,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Develop a Learning Habit",
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "\nSmart reminders, fun challenges,\nand more.",
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 16,
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
