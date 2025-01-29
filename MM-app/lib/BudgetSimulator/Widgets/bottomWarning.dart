import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Bottomwarning extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final Color color;
  final String text;
  final Color textColor;

  Bottomwarning({
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.color,
    required this.text,
    required this.textColor,
  });
  @override
  _BottomwarningtState createState() => _BottomwarningtState();
}

class _BottomwarningState {}

class _BottomwarningtState extends State<Bottomwarning> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90 * widget.screenHeightUnit,
      width: 1290 * widget.screenWidthUnit,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.color,
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: 30 * widget.screenWidthUnit,
            top: 21 * widget.screenHeightUnit),
        child: Text(
          widget.text,
          style: GoogleFonts.baloo2(
            fontSize: 34 * widget.screenHeightUnit,
            color: widget.textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
