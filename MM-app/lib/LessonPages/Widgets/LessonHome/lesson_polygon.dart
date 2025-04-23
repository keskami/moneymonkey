// lesson_polygon.dart
import 'package:flutter/material.dart';
import 'package:money_monkey/LessonPages/Widgets/PolygonAvatar.dart';

class LessonPolygon extends StatelessWidget {
  final Color backgroundColor;
  final Widget icon;
  final bool isActivated;
  final double width;
  final int index;
  final List<String> imageLinks;

  const LessonPolygon({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.isActivated,
    required this.width,
    required this.index,
    required this.imageLinks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use appropriate icon or image from the imageLinks based on index
    Widget iconToShow = icon;
    
    if (isActivated && index < imageLinks.length) {
      iconToShow = CircleAvatar(
        radius: width * 0.3,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(imageLinks[index]),
      );
    }
    
    return PolygonAvatar(
      size: width,
      isActivated: isActivated,
      backgroundColor: backgroundColor,
      icon: iconToShow,
    );
  }
}