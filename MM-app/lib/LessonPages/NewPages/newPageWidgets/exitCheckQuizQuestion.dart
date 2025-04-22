import 'package:flutter/material.dart';

class ExitCheckQuizQuestion extends StatefulWidget {
  final double heightUnit;
  final double widthUnit;

  const ExitCheckQuizQuestion({
    Key? key,
    required this.heightUnit,
    required this.widthUnit,
  }) : super(key: key);

  @override
  _ExitCheckQuizQuestionState createState() => _ExitCheckQuizQuestionState();
}

class _ExitCheckQuizQuestionState extends State<ExitCheckQuizQuestion> {
  int chosen = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.heightUnit * 600,
      width: widget.widthUnit * 1100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: .25,
            offset: Offset(2, 2),
          ),
        ],
      ),
    );
  }
}
