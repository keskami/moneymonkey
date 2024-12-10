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
  bool showBananaPopup = true; // State to control the visibility of BananaPopUp

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double dimension = widget.neighbors.length < 2
        ? screenWidth * 0.25
        : widget.neighbors.length == 2
            ? screenWidth * 0.3
            : screenWidth * 0.4;

    return Container(
      width: dimension,
      height: widget.neighbors.length < 2
          ? screenWidth * 0.2
          : widget.neighbors.length == 2
              ? screenWidth * 0.30
              : screenWidth * 0.4,
      child: Stack(
        children: [
          ..._buildPositionedImages(),
          if (showBananaPopup)
            Positioned(
              right: 0, // Position at the top-right of the cluster
              top: -10, // Adjust for visual placement
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showBananaPopup = false; // Hide BananaPopUp on tap
                  });
                },
                child: BananaPopUp(),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildPositionedImages() {
    List<Widget> positionedImages = [];

    for (int i = 0; i < widget.neighbors.length && i < 4; i++) {
      positionedImages.add(Positioned(
        left: _getLeftPosition(i),
        top: _getTopPosition(i),
        child: GestureDetector(
          onTap: () {
            print("Tapped on image at index $i");
            setState(() {
              showBananaPopup = false; // Hide BananaPopUp on avatar tap
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
      ));
    }

    return positionedImages;
  }

  double _getLeftPosition(int index) {
    double baseOffset = widget.isLeft || widget.neighbors.length <= 2
        ? 0.0
        : 20.0; // Adjust for more right alignment
    double extraOffset =
        widget.isLeft || widget.neighbors.length <= 2 ? 0.0 : -20.0;

    switch (widget.neighbors.length) {
      case 1:
        return baseOffset + 20;
      case 2:
        return index == 0 ? -10 : baseOffset + index * 50.0 + extraOffset;
      case 3:
        return baseOffset +
            (index == 2
                ? 20.0 - extraOffset
                : index == 0
                    ? extraOffset
                    : index * 80.0 + extraOffset);
      case 4:
        return baseOffset + (index % 2 == 0 ? 0.0 : 40.0 + extraOffset);
      default:
        return baseOffset;
    }
  }

  double _getTopPosition(int index) {
    double baseOffset = widget.isLeft ? 0.0 : -20.0; // Move up when not left
    double extraOffset = widget.isLeft
        ? 0.0
        : 10.0; // Fine-tuned adjustment for top-right alignment

    switch (widget.neighbors.length) {
      case 1:
        return baseOffset + 0;
      case 2:
        return index == 0 ? 0 : baseOffset + index * 50.0;
      case 3:
        return baseOffset +
            (index == 2
                ? 80.0 + extraOffset
                : index == 0
                    ? 10 + extraOffset
                    : index * 15.0 + extraOffset); // Adjust top for third image
      case 4:
        return baseOffset + (index < 2 ? 0.0 : 40.0 + extraOffset);
      default:
        return baseOffset + 20;
    }
  }
}
