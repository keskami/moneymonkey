import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/PortfolioPages/portfolio_screen.dart';
import 'package:money_monkey/Profile/profile_page.dart';
import 'package:money_monkey/home.dart';

class BaseTopOfScreen extends StatelessWidget {
  final double screenHeight;
  final double screenWidthUnit;
  final double screenHeightUnit;
  final String name;
  BaseTopOfScreen({
    required this.screenHeight,
    required this.screenWidthUnit,
    required this.screenHeightUnit,
    required this.name,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      height: screenHeightUnit * 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(screenWidthUnit * 15,
                  screenHeightUnit * 16, 0, screenWidthUnit * 8),
              child: Icon(
                Icons.arrow_back_ios,
                size: screenWidthUnit * 24,
                color: Colors.black,
              )),
          Padding(
              padding: EdgeInsets.only(top: screenWidthUnit * 4),
              child: Text(
                'Quit ${name}',
                style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(screenWidthUnit * 999,
                screenHeightUnit * 6, screenWidthUnit * 31, 0),
            child: Container(
              height: screenHeightUnit * 70,
              width: screenWidthUnit * 76,
              child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLogo2%20(1)%202.png?alt=media&token=a572c91c-6624-4e57-87d0-c1362cc6dd8e",
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, screenHeightUnit * 6, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/img_monkeymoney_50.png',
                  height: screenHeightUnit * 50,
                ),
                SizedBox(
                  width: screenWidthUnit * 5,
                ),
                Text(
                  "3",
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 27,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: screenWidthUnit * 39,
                ),
                Image.asset(
                  'assets/images/img_monkeymoney_51.png',
                  height: screenHeightUnit * 50,
                ),
                SizedBox(
                  width: screenWidthUnit * 5,
                ),
                Text(
                  "3",
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 27,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: screenWidthUnit * 39,
                ),
                Image.asset(
                  'assets/images/img_monkeymoney_52.png',
                  height: screenHeightUnit * 50,
                ),
                SizedBox(
                  width: screenWidthUnit * 5,
                ),
                Text(
                  "3",
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 27,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
