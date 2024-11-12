import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GettingStarted/Widgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';

class StartFreshPage5 extends StatefulWidget {
  StartFreshPage5({super.key});

  @override
  State<StartFreshPage5> createState() => _StartFreshPage5State();
}

class _StartFreshPage5State extends State<StartFreshPage5> {
  int sfOrFml = 3;
  StartFreshController startFreshController = Get.find();

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
          GestureDetector(
            onTap: () {
              startFreshController.startingFresh.value = 1;
              setState(() {
                sfOrFml = 1;
              });
            },
            child: CustomOptionTile(
              isSelected: sfOrFml == 1,
              childWidget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .start, // Distribute space between widgets
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Fone_banner.png?alt=media&token=9bf102b7-d285-413f-8fee-27c384fc9ed2",
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
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          children: [
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
                                  "\nTake the easiest lesson of our financial literacy course",
                              style: GoogleFonts.fredoka().copyWith(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              startFreshController.startingFresh.value = 2;
              setState(() {
                sfOrFml = 2;
              });
            },
            child: CustomOptionTile(
              isSelected: sfOrFml == 2,
              childWidget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .start, // Distribute space between widgets
                  children: [
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGetting%20Started%20Page-Images%2Fmagnifying_glass.png?alt=media&token=5efa79cc-9435-4b27-9cb0-75ea22b18bb5",
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
                      width: 95,
                    ),
                    Flexible(
                      child: RichText(
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
                                "\nLet Money Monkey recommend where you should start learning",
                            style: GoogleFonts.fredoka().copyWith(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
