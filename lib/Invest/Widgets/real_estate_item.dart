import 'dart:math';

import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/Invest/Widgets/chat_dialog.dart';
import 'package:money_monkey/Invest/Widgets/continue_btn.dart';

class RealEstateItem extends StatelessWidget {
  const RealEstateItem({
    super.key,
    required this.center,
    required this.neighbours,
    required this.start,
  });

  final bool start;
  final String center;
  final List<String> neighbours;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () {
              showAlignedDialog(
                context: context,
                builder: _localDialogBuilder,
                followerAnchor: Alignment.topCenter,
                targetAnchor: Alignment.bottomCenter,
                barrierColor: Colors.grey.withOpacity(0.5),
              );
            },
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(center),
              backgroundColor: Colors.transparent,
            ),
          ),
          for (int i = 0; i < neighbours.length; i++)
            Transform.translate(
              offset: _calculateOffset(i),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(neighbours[i]),
                backgroundColor: Colors.transparent,
              ),
            ),
        ],
      ),
    );
  }

  Offset _calculateOffset(int index) {
    double baseRadius = 95;
    double radius = baseRadius + (neighbours.length - 2) * 20;

    double angleStep = pi / neighbours.length;
    double angle =
        start ? (angleStep * index) + 5.5 : (pi - angleStep * index) - 5.5;

    return Offset(radius * cos(angle), radius * sin(angle));
  }
}

WidgetBuilder get _localDialogBuilder {
  return (BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: ChatDialogContainer(
        borderWidth: 0,
        trianglePosition: TrianglePosition.top,
        childWidget: Container(
          width: MediaQuery.of(context).size.width * 0.69,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "House",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                "Real Estate 1/4",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset("assets/real_estate/house.png"),
              ),
              ContinueButton(
                pages: 0,
                nextPage: () {},
                isEnabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  };
}
