import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Headings {
  Widget crushTheCreditCardDebtHeading({
    required double checkingAccountBalance,
    required double savingsAccountBalance,
    required double creditCardDebt,
    required double netCash,
    required double screenWidthUnit,
    required double screenHeightUnit,
    required double APY,
  }) {
    return Container(
      color: Colors.white,
      height: screenHeightUnit * 120,
      width: screenWidthUnit * 1839,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidthUnit * 44, // Increased by 10%
          ),
          Icon(
            Icons.account_balance,
            size: screenHeightUnit * 48,
            color: Colors.black,
          ),
          SizedBox(
            width: screenWidthUnit * 30.8, // Increased by 10%
          ),
          Text(
            "Checking Account",
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 36,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: screenWidthUnit * 85.8, // Increased by 10%
          ),
          Text(
            "\$${checkingAccountBalance}",
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 34,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: screenWidthUnit * 38.5, // Increased by 10%
          ),
          Container(
            width: screenWidthUnit * 1,
            height: screenHeightUnit * 130,
            color: Colors.black,
          ),
          SizedBox(
            width: screenWidthUnit * 38.5, // Increased by 10%
          ),
          Icon(
            Icons.account_balance,
            size: screenHeightUnit * 48,
            color: Colors.black,
          ),
          SizedBox(
            width: screenWidthUnit * 30.8, // Increased by 10%
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Savings Account",
                style: GoogleFonts.baloo2(
                  fontSize: screenHeightUnit * 36,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenHeightUnit * 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "APY",
                    style: GoogleFonts.baloo2(
                      fontSize: screenHeightUnit * 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: screenWidthUnit * 3.3, // Increased by 10%
                  ),
                  Text(
                    "$APY%",
                    style: GoogleFonts.baloo2(
                      fontSize: screenHeightUnit * 22,
                      color: Color.fromRGBO(72, 209, 38, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            width: screenWidthUnit * 85.8, // Increased by 10%
          ),
          Text(
            "\$${savingsAccountBalance}",
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 34,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: screenWidthUnit * 38.5, // Increased by 10%
          ),
          Container(
            width: screenWidthUnit * 1,
            height: screenHeightUnit * 130,
            color: Colors.black,
          ),
          SizedBox(
            width: screenWidthUnit * 44, // Increased by 10%
          ),
          Icon(
            Icons.account_balance,
            size: screenHeightUnit * 48,
            color: Colors.black,
          ),
          SizedBox(
            width: screenWidthUnit * 24.2, // Increased by 10%
          ),
          Text(
            "Net Cash",
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 36,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: screenWidthUnit * 85.8, // Increased by 10%
          ),
          Text(
            "\$${netCash}",
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 34,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: screenWidthUnit * 38.5, // Increased by 10%
          ),
          Container(
            width: screenWidthUnit * 1,
            height: screenHeightUnit * 130,
            color: Colors.black,
          ),
          Container(
            width: screenWidthUnit * 1,
            height: screenHeightUnit * 130,
            color: Colors.black,
          ),
          SizedBox(
            width: screenWidthUnit * 44, // Increased by 10%
          ),
          Icon(
            Icons.credit_card,
            size: screenHeightUnit * 58,
            color: Colors.black,
          ),
          SizedBox(
            width: screenWidthUnit * 24.2, // Increased by 10%
          ),
          Text(
            "Credit Card Debt ",
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 36,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: screenWidthUnit * 85.8, // Increased by 10%
          ),
          Text(
            "-\$${creditCardDebt}",
            style: GoogleFonts.baloo2(
              fontSize: screenHeightUnit * 34,
              color: Color.fromRGBO(243, 52, 52, 1),
              fontWeight: FontWeight.w600,
            ),
          ),
          
          
        ],
      ),
    );
  }
}
