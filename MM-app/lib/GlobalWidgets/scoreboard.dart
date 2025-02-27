import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Resources/Resources.dart';

class ScoreboardWidget extends StatelessWidget {
  const ScoreboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;

    return Container(
      // Same width you had before (30% of screen)
      width: screenWidth * 0.25,
      margin:
          EdgeInsets.symmetric(horizontal: screenWidth * 0.025, vertical: 0),
      // Some padding at the top to match your original scoreboard spacing
      child: Column(
        children: [
          SizedBox(
            height: screenHeightUnit * 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/LOGO.png',
                  height: screenHeightUnit * 80,
                ),
                SizedBox(
                  width: screenWidthUnit * 7,
                ),
                Image.asset(
                  'assets/images/img_monkeymoney_50.png',
                  height: screenHeightUnit * 53,
                ),
                SizedBox(
                  width: screenWidthUnit * 2,
                ),
                Text(
                  "3",
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 9,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: screenWidthUnit * 7,
                ),
                Image.asset(
                  'assets/images/img_monkeymoney_51.png',
                  height: screenHeightUnit * 49,
                ),
                SizedBox(
                  width: screenWidthUnit * 2,
                ),
                Text(
                  "3",
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 9,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: screenWidthUnit * 7,
                ),
                Image.asset(
                  'assets/images/img_monkeymoney_52.png',
                  height: screenHeightUnit * 49,
                ),
                SizedBox(
                  width: screenWidthUnit * 2,
                ),
                Text(
                  "3",
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 9,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeightUnit * 46,
          ),
          SizedBox(
            width: screenWidthUnit * 100,
            height: screenHeightUnit * 340,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: .5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeightUnit * 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: screenWidthUnit * 7),
                          child: Text("Daily Quests",
                              style: GoogleFonts.baloo2(
                                fontSize: screenWidthUnit * 5.5,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ))),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidthUnit * 7),
                        child: TextButton(
                            onPressed: () {},
                            child: Text("View All >",
                                style: GoogleFonts.baloo2(
                                  fontSize: screenWidthUnit * 4.75,
                                  color: Color.fromRGBO(79, 195, 247, 1),
                                  fontWeight: FontWeight.w500,
                                ))),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeightUnit * 10,
                  ),
                  dailyQuest(
                      title: "Complete 3 units",
                      outOf: 3,
                      completed: 1,
                      screenWidthUnit: screenWidthUnit,
                      screenHeightUnit: screenHeightUnit),
                  SizedBox(
                    height: screenHeightUnit * 20,
                  ),
                  dailyQuest(
                      title: "Score 80% or higher in 2\nlessons",
                      outOf: 2,
                      completed: 1,
                      screenWidthUnit: screenWidthUnit,
                      screenHeightUnit: screenHeightUnit)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dailyQuest({
    required String title,
    required int outOf,
    required int completed,
    required double screenWidthUnit,
    required double screenHeightUnit,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(screenWidthUnit * 7, 0, 0, 0),
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(height: screenHeightUnit * 10),
              Image.asset(
                "assets/images/img_monkeymoney_51.png",
                height: screenHeightUnit * 72,
              ),
            ],
          ),
          SizedBox(width: screenWidthUnit * 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 3.8,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeightUnit * 2),
                Container(
                  height: screenHeightUnit * 25,
                  width: screenWidthUnit * 62,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(135, 206, 235, 1),
                        Color.fromRGBO(213, 213, 213, 1),
                      ],
                      stops: [
                        completed / outOf,
                        completed / outOf,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "$completed/$outOf",
                      style: GoogleFonts.baloo2(
                        fontSize: screenWidthUnit * 3.5,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
