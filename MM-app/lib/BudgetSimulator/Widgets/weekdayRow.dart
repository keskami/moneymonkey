import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeekdayRow extends StatelessWidget {
  double screenWidthUnit;
  double screenHeightUnit;
  WeekdayRow(
      {super.key,
      required this.screenWidthUnit,
      required this.screenHeightUnit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeightUnit * 8, bottom: screenHeightUnit * 18),
      child: Center(
        child: Container(
          width: screenWidthUnit * 1290,
          height: screenHeightUnit * 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromRGBO(79, 195, 247, 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "MO",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                "TUES",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                "WED",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                "THURS",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                "FRI",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                "SAT",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                "SUN",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
