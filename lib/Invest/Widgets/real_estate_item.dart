import 'dart:math';

import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/Invest/Pages/Real%20Estate%20Pages/property_details.dart';
import 'package:money_monkey/Invest/Widgets/chat_dialog.dart';
import 'package:money_monkey/Invest/Widgets/continue_btn.dart';

class RealEstateItem extends StatelessWidget {
  const RealEstateItem({
    super.key,
    required this.center,
    required this.neighbours,
    required this.start,
    required this.isFin,
  });
  final bool isFin;
  final bool start;
  final String center;
  final List<String> neighbours;

  Offset getClusterOffset() {
    if (!start) {
      return Offset(-80, -80);
    } else {
      if (neighbours.length >= 3) {
        return Offset(90, -60);
      }
      return Offset(70, -70);
    }
  }

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
              radius: 45,
              backgroundImage: AssetImage(center),
              backgroundColor: Colors.transparent,
            ),
          ),
          //Cluster
          Transform.translate(
            offset: getClusterOffset(),
            child: Stack(
              children: [
                for (int i = 0; i < neighbours.length; i++)
                  Transform.translate(
                    offset: _calculateCircularOffset(i),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage(neighbours[i]),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
              ],
            ),
          ),
          //Path
          if (!isFin)
            Transform.translate(
              offset: start ? Offset(45, 80) : Offset(-35, 85),
              child: !start
                  ? Image.asset(
                      "assets/real_estate/path3.png",
                    )
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Image.asset(
                        "assets/real_estate/path3.png",
                      ),
                    ),
            ),
        ],
      ),
    );
  }

  Offset _calculateCircularOffset(int index) {
    double radius = 55;
    double angleStep = (2 * pi) / neighbours.length;
    double angleOffset = (start && neighbours.length >= 3)
        ? -pi / 4
        : (start && neighbours.length >= 2)
            ? pi / 6
            : (!start && neighbours.length >= 2)
                ? -pi / 7
                : 0;
    double angle = angleStep * index + angleOffset;
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
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.25,
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
                child: Image.asset(
                  "assets/real_estate/house.png",
                  height: MediaQuery.of(context).size.width * 0.3,
                  fit: BoxFit.contain,
                ),
              ),
              ContinueButton(
                pages: 0,
                nextPage: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertyDetails(
                        property: "Modern Loft",
                        address:
                            "1234 Martin Luther King Jr Blvd, Detroit, MI 48208",
                      ),
                    ),
                  );
                },
                isEnabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  };
}
