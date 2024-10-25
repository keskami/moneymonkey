// CardModel class
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CardModel {
  final Color color;
  final String frontText;
  final Widget backWidget;
  bool isFlipped;
  GlobalKey<FlipCardState> cardKey;

  CardModel({
    required this.color,
    required this.frontText,
    required this.backWidget,
   this.isFlipped= false
  }) : cardKey = GlobalKey<FlipCardState>();
}

class _DetailNote extends StatelessWidget {
  final Color color;
  final String title;
  final String details;
  final String imagePath;

  const _DetailNote({
    Key? key,
    required this.color,
    required this.title,
    required this.details,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 605,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF000000),
                fontSize: 35,
                fontFamily: 'Baloo 2',
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                details,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontFamily: 'Baloo 2',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 40),
            if (imagePath.isNotEmpty)
              Image.asset(
                imagePath,
                height: 200,
              ),
            const SizedBox(height: 20),
            

            // GestureDetector(
            //   onTap: () {
            //     Get.toNamed("/questionPageRoute");
            //   },
            //   child: Image.asset(
            //     'assets/images/button.png', 
            //     height: 60,
            //     width: 200,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

List <CardModel> getCards(){
  return [
     CardModel(
        color: const Color(0xFF89DC8E), // Green card
        frontText: "Banknote",
        backWidget: _DetailNote(
          color: const Color(0xFF89DC8E), // Green background
          title: "Banknote",
          details: "Introduced in 7th century\nChina, banknotes today\nfacilitate everyday purchases.",
          imagePath: "assets/images/monkeywithnote.png",
        ),
      ),
      CardModel(
        color: const Color(0xFF87CEEB), // Blue card
        frontText: "Coin",
        backWidget: _DetailNote(
          color: const Color(0xFF87CEEB), // Blue background
          title: "Coin",
          details: "First used in ancient Lydia,\ncoins have been a staple of currency systems.",
          imagePath: "assets/images/monkeywithnote.png",
        ),
      ),
      CardModel(
        color: const Color(0xFFFFE792), // Yellow card
        frontText: "Credit Card",
        backWidget: _DetailNote(
          color: const Color(0xFFFFE792), // Yellow background
          title: "Credit Card",
          details: "First issued in 1950, credit cards revolutionized the way we handle money.",
          imagePath: "assets/images/monkeywithnote.png",
        ),
      ),
  ];
}