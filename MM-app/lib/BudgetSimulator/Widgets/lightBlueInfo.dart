import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightBlueInfo extends StatelessWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final String name;
  final String amount;
  final bool big;

  const LightBlueInfo({
    Key? key,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.name,
    required this.amount, required this.big,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeightUnit * 65,
      width: !big ? screenWidthUnit * 450 : screenWidthUnit * 600,
      decoration: BoxDecoration(
        color:  Color.fromRGBO(233, 244, 255, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(padding: EdgeInsets.symmetric(horizontal: screenWidthUnit * 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 25,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(0, 127, 255, 1)
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 30,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),),
     
    );
  }
}