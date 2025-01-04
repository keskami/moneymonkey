import 'dart:math';

import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';

import '../Accessory Pages/property_details.dart';
import 'chat_dialog.dart';
import 'continue_btn.dart';

class RealEstateItem extends StatefulWidget {
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

  @override
  State<RealEstateItem> createState() => _RealEstateItemState();
}

class _RealEstateItemState extends State<RealEstateItem> {
  bool show = true;
  List<bool> showPopUpList = [true, true, true, true];

  @override
  void initState() {
    super.initState();
  }

  Offset getClusterOffset() {
    if (!widget.start) {
      return Offset(-50, -70);
    } else {
      return widget.neighbours.length >= 3 ? Offset(50, -60) : Offset(20, -60);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAlignedDialog(
          context: context,
          builder: _localDialogBuilder,
          followerAnchor: Alignment.topCenter,
          targetAnchor: Alignment.bottomCenter,
          barrierColor: Colors.grey.withOpacity(0.5),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Path between Milestones
          if (!widget.isFin)
            Transform.translate(
              offset: widget.start ? Offset(30, 80) : Offset(-20, 80),
              child: !widget.start
                  ? Image.asset("assets/real_estate/path3.png")
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Image.asset("assets/real_estate/path3.png"),
                    ),
            ),
          // Center Milestone
          Container(
            height: 100,
            width: 100,
            child: CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage(widget.center),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
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
          height: MediaQuery.of(context).size.height * 0.27,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "House",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "Real Estate 1/4",
                style: TextStyle(fontWeight: FontWeight.bold),
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
