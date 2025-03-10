import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeekdayRow extends StatelessWidget {
  double screenWidthUnit;
  double screenHeightUnit;
  WeekdayRow(
      {super.key,
      required this.screenWidthUnit,
      required this.screenHeightUnit});

      Color dayColor = Color.fromRGBO(0, 127, 255, 1);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeightUnit * 6, bottom: screenHeightUnit * 14),
      child: Center(
        child: Container(
          width: screenWidthUnit * 1290,
          height: screenHeightUnit * 61,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(243, 249, 255, 1),
            border: Border.all(
              color: dayColor,
              width: 1,
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "MO",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: dayColor
                ),
              ),
              Text(
                "TUES",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: dayColor
                ),
              ),
              Text(
                "WED",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: dayColor
                ),
              ),
              Text(
                "THURS",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: dayColor
                ),
              ),
              Text(
                "FRI",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: dayColor
                ),
              ),
              Text(
                "SAT",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: dayColor
                ),
              ),
              Text(
                "SUN",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 18,
                  fontWeight: FontWeight.w600,
                  color: dayColor
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
