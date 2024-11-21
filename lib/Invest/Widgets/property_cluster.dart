import 'package:flutter/material.dart';
import 'package:money_monkey/Invest/Widgets/banana_pop_up.dart';

class PropertyCluster extends StatefulWidget {
  final List<String> neighbors;
  final bool isLeft;

  const PropertyCluster({
    Key? key,
    required this.neighbors,
    this.isLeft = true,
  }) : super(key: key);

  @override
  State<PropertyCluster> createState() => _PropertyClusterState();
}

class _PropertyClusterState extends State<PropertyCluster> {
  bool showBananaPopup = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double width = widget.neighbors.length == 1
        ? screenWidth * 0.3
        : widget.neighbors.length == 2
            ? screenWidth * 0.35
            : widget.neighbors.length == 3
                ? screenWidth * 0.42
                : widget.neighbors.length == 4
                    ? screenWidth * 0.5
                    : screenWidth * 0.5;
    double height = widget.neighbors.length == 1
        ? screenWidth * 0.25
        : widget.neighbors.length == 2
            ? screenWidth * 0.35
            : widget.neighbors.length == 3
                ? screenWidth * 0.42
                : widget.neighbors.length == 4
                    ? screenWidth * 0.5
                    : screenWidth * 0.5;

    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          ..._buildPositionedImages(height, width),
          if (showBananaPopup)
            Positioned(
              right: 0,
              top: 0,
              child: BananaPopUp(),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildPositionedImages(double height, double width) {
    List<Widget> positionedImages = [];

    for (int i = 0; i < widget.neighbors.length && i < 4; i++) {
      positionedImages.add(
        Positioned(
          left: _getLeftPosition(i, height, width),
          top: _getTopPosition(i, height, width),
          child: GestureDetector(
            onTap: () {
              print("Tapped on image at index $i");
              setState(() {
                showBananaPopup = false;
              });
            },
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.transparent,
              child: Image.asset(
                widget.neighbors[i],
                width: 100,
              ),
            ),
          ),
        ),
      );
    }

    return positionedImages;
  }

  double _getLeftPosition(int index, double height, double width) {
    switch (widget.neighbors.length) {
      case 1:
        return 0 + width * 0.15;
      case 2:
        if (widget.isLeft)
          return index == 0 ? width * 0.35 : 0;
        else
          return index == 0 ? width * 0.35 : 0;
      case 3:
        if (widget.isLeft)
          return index == 0
              ? 0 //For 0
              : index == 1
                  ? width * 0.47 //For 1
                  : width * 0.05; //For 2
        else
          return index == 0
              ? 0 //For 0
              : index == 1
                  ? width * 0.47 //For 1
                  : width * 0.45; //For 2
      case 4:
        if (widget.isLeft)
          return index == 0
              ? 0 //For 0
              : index == 1
                  ? width * 0.5 //For 1
                  : index == 2
                      ? width * 0.12
                      : -width * 0.02; //For 2
        else
          return index == 0
              ? 0 //For 0
              : index == 1
                  ? width * 0.6 //For 1
                  : index == 2
                      ? width * 0.4
                      : width * 0.55; //For 2
      default:
        return 0;
    }
  }

  double _getTopPosition(int index, double height, double width) {
    switch (widget.neighbors.length) {
      case 1:
        return 0 + height * 0.15;
      case 2:
        if (widget.isLeft)
          return index == 0 ? 0 : height * 0.4;
        else
          return index == 0 ? height * 0.4 : 0;
      case 3:
        if (widget.isLeft)
          return index == 0
              ? height * 0.05 //For 0
              : index == 1
                  ? 0 //For 1
                  : height * 0.5; //For 2
        else
          return index == 0
              ? 0 //For 0
              : index == 1
                  ? height * 0.05 //For 1
                  : height * 0.5; //For 2
      case 4:
        if (widget.isLeft)
          return index == 0
              ? -height * 0.02 //For 0
              : index == 1
                  ? height * 0.05 //For 1
                  : index == 2
                      ? height * 0.25 //For 1
                      : height * 0.6; //For 2
        else
          return index == 0
              ? height * 0.03 //For 0
              : index == 1
                  ? -height * 0.02 //For 1
                  : index == 2
                      ? height * 0.25 //For 1
                      : height * 0.6; //For 2
      default:
        return 0 + 20;
    }
  }
}
