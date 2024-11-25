import 'package:flutter/material.dart';
import 'package:money_monkey/Lesson Flow/widgets/monkey_with_button.dart';
// Import your widget

class LessonCard extends StatelessWidget {
  const LessonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0XFFFFFFFF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0X3F000000),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(height: 26),
          Text(
            "Join “Minty the Money Monkey” on\na one-time fun-filled journey to\nlearn about the exciting world of \nmoney! Minty will help you uncover\nthe basics of what money is, how\nit’s used, and why it’s such a\nvaluable tool in our everyday lives.",
            maxLines: 7,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0XFF000000),
              fontSize: 17,
              fontFamily: 'Baloo 2',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          MonkeyImageWithButton(),
        ],
      ),
    );
  }
}
