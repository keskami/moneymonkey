// treasure_widget.dart
import 'package:flutter/material.dart';
import 'package:money_monkey/LessonPages/Widgets/PolygonAvatar.dart';

class TreasureWidget extends StatelessWidget {
  const TreasureWidget({
    super.key,
    required this.width,
    required this.isActivated,
  });

  final double width;
  final bool isActivated;

  @override
  Widget build(BuildContext context) {
    return PolygonAvatar(
      size: width,
      isActivated: false,
      backgroundColor: Colors.grey.shade400,
      icon: PolygonAvatar(
        size: width * 0.9,
        isActivated: isActivated,
        backgroundColor: Colors.yellow,
        icon: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.transparent,
          child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonFlowImages%2FgoldTreasure.png?alt=media&token=2299e888-e835-414e-ac4a-0e260fa44e2a",
          ),
        ),
      ),
    );
  }
}