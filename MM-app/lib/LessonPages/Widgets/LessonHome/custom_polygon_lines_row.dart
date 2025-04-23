// custom_polygon_lines_row.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Pages/SampleZigZagPage.dart';

class CustomPolygonLinesRow extends StatelessWidget {
  const CustomPolygonLinesRow({
    super.key,
    required this.index,
    required this.isActivated,
    required this.width,
  });

  final double width;
  final int index;
  final bool isActivated;

  @override
  Widget build(BuildContext context) {
    if (index == 1 || index == 2 || index == 5 || index == 6) {}
    Widget lessonPolygonStack = Stack();
    switch (index) {
      case 0:
        lessonPolygonStack = middleRow(context, false);
        break;
      case 1:
        lessonPolygonStack = leftRow(context);
        break;
      case 2:
        lessonPolygonStack = middleRow(context, true);
        break;
      case 3:
        lessonPolygonStack = rightRow(context);
        break;
      case 4:
        lessonPolygonStack = middleRow(context, false);
        break;
      case 5:
        lessonPolygonStack = leftRow(context);
        break;
      case 6:
        return Container();
      default:
        lessonPolygonStack = middleRow(context, false);
    }

    return Stack(
      children: [
        lessonPolygonStack.marginSymmetric(
          horizontal: width * 0.5,
        ),
      ],
    );
  }

  Widget leftRow(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Transform.translate(
          offset: Offset(
            -width * 0.8,
            width * 0.5,
          ),
          child: Container(
            width: width,
            height: width,
            child: CustomPaint(
              painter: SlantLinePainter(
                RightToLeft: false,
                isActivated: isActivated,
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget middleRow(BuildContext context, bool isLeftToRight) {
    return Row(
      children: [
        const Spacer(),
        if (index != 6)
          Transform.translate(
            offset: isLeftToRight
                ? Offset(
                    width * 0.8,
                    width * 0.7,
                  )
                : Offset(
                    -width * 0.8,
                    width * 0.7,
                  ),
            child: Container(
              width: width,
              height: width,
              child: CustomPaint(
                painter: SlantLinePainter(
                  RightToLeft: !isLeftToRight,
                  isActivated: isActivated,
                ),
              ),
            ),
          ),
        if (index == 6)
          Transform.translate(
            offset: Offset(
              width * 0.5,
              width * 0.5,
            ),
            child: Container(
              width: width,
              height: width * 0.07,
              color: isActivated ? Colors.blue : Colors.grey.shade300,
            ),
          ),
        const Spacer(),
      ],
    );
  }

  Widget rightRow(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Transform.translate(
          offset: Offset(
            -width * 0.8,
            width * 0.7,
          ),
          child: Container(
            width: width,
            height: width,
            child: CustomPaint(
              painter: SlantLinePainter(
                RightToLeft: true,
                isActivated: isActivated,
              ),
            ),
          ),
        ),
      ],
    );
  }
}