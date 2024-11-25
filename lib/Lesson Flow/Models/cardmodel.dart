// CardModel class
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class CardModel {
  final Color color;
  final String frontText;
  final String backText;
  bool isFlipped;
  GlobalKey<FlipCardState> cardKey;

  CardModel(
      {required this.color,
      required this.frontText,
      required this.backText,
      this.isFlipped = false,
      required this.cardKey});

  /// Factory method to create CardModel from a Firebase data map
  factory CardModel.fromMap(Map<String, dynamic> data, Color color) {
    return CardModel(
      color: color,
      frontText: data['front'] ?? 'Front Text',
      backText: data['back'] ?? 'Back Text',
      cardKey:
          GlobalKey<FlipCardState>(), // Create a new GlobalKey for each card
    );
  }
}

class DetailNote extends StatelessWidget {
  final Color color;
  final String title;
  final String details;
  final String imagePath;

  const DetailNote({
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
          ],
        ),
      ),
    );
  }
}
