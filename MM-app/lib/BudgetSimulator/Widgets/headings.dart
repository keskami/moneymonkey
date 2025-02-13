import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Headings {
  Widget crushTheCreditCardDebtHeading(
      {required double checkingAccountBalance,
      required double savingsAccountBalance,
      required double creditCardDebt,
      required double netCash,
      required double screenWidthUnit,
      required double screenHeightUnit,
      required double APY,
      required double savingsTransfer,
      required double checkingTransfer}) {
    return Container(
      color: Colors.white,
      height: screenHeightUnit * 110,
      width: screenWidthUnit * 1839,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidthUnit * 44,
          ),
          Icon(
            Icons.account_balance,
            size: screenHeightUnit * 48,
            color: Colors.black,
          ),
          SizedBox(
            width: screenWidthUnit * 30.8,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Checking Account",
                style: GoogleFonts.baloo2(
                  fontSize: screenHeightUnit * 36,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: screenHeightUnit * 0,
              ),
            ],
          ),
          SizedBox(
            width: screenWidthUnit * 25.8, // Increased by 10%
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "\$${checkingAccountBalance}",
                style: GoogleFonts.baloo2(
                  fontSize: screenHeightUnit * 34,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: screenHeightUnit * 32,
                child: (savingsTransfer == 0 && checkingTransfer == 0)
                    ? Container()
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: screenWidthUnit * 0),
                            child: Row(
                              children: [
                                Text(
                                  "Transfer",
                                  style: GoogleFonts.baloo2(
                                    fontSize: screenHeightUnit * 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidthUnit * 2,
                                ),
                                (checkingTransfer > 0)
                                    ? Text(
                                        "+",
                                        style: GoogleFonts.baloo2(
                                          fontSize: screenHeightUnit * 20,
                                          color: Color.fromRGBO(72, 209, 38, 1),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : Text(
                                        "-",
                                        style: GoogleFonts.baloo2(
                                          fontSize: screenHeightUnit * 20,
                                          color: Color.fromRGBO(243, 52, 52, 1),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                SizedBox(
                                  width: screenWidthUnit * 2,
                                ),
                                Text(
                                  "\$${checkingTransfer.abs()}",
                                  style: GoogleFonts.baloo2(
                                    fontSize: screenHeightUnit * 20,
                                    color: (checkingTransfer > 0)
                                        ? Color.fromRGBO(72, 209, 38, 1)
                                        : Color.fromRGBO(243, 52, 52, 1),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidthUnit * 2,
                                ),
                                Text(
                                  "->",
                                  style: GoogleFonts.baloo2(
                                    fontSize: screenHeightUnit * 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidthUnit * 2,
                                ),
                                Text(
                                  "(",
                                  style: GoogleFonts.baloo2(
                                    fontSize: screenHeightUnit * 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "\$${checkingAccountBalance + checkingTransfer}",
                                  style: GoogleFonts.baloo2(
                                    fontSize: screenHeightUnit * 20,
                                    color: (checkingTransfer > 0)
                                        ? Color.fromRGBO(72, 209, 38, 1)
                                        : Color.fromRGBO(243, 52, 52, 1),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  ")",
                                  style: GoogleFonts.baloo2(
                                    fontSize: screenHeightUnit * 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
              )
            ],
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
            width: screenWidthUnit * 14.8,
          ),
          SizedBox(
            width: screenWidthUnit * 135.8,
            child: (savingsTransfer == 0 && checkingTransfer == 0)
                ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "\$${savingsAccountBalance}",
                      style: GoogleFonts.baloo2(
                        fontSize: screenHeightUnit * 34,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ])
                : Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      "\$${savingsAccountBalance}",
                      style: GoogleFonts.baloo2(
                        fontSize: screenHeightUnit * 34,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Transfer",
                          style: GoogleFonts.baloo2(
                            fontSize: screenHeightUnit * 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: screenWidthUnit * 2,
                        ),
                        (savingsTransfer > 0)
                            ? Text(
                                "+",
                                style: GoogleFonts.baloo2(
                                  fontSize: screenHeightUnit * 20,
                                  color: Color.fromRGBO(72, 209, 38, 1),
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : Text(
                                "-",
                                style: GoogleFonts.baloo2(
                                  fontSize: screenHeightUnit * 20,
                                  color: Color.fromRGBO(243, 52, 52, 1),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        SizedBox(
                          width: screenWidthUnit * 2,
                        ),
                        Text(
                          "\$${savingsTransfer.abs()}",
                          style: GoogleFonts.baloo2(
                            fontSize: screenHeightUnit * 20,
                            color: (savingsTransfer > 0)
                                ? Color.fromRGBO(72, 209, 38, 1)
                                : Color.fromRGBO(243, 52, 52, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: screenWidthUnit * 2,
                        ),
                        Text(
                          "->",
                          style: GoogleFonts.baloo2(
                            fontSize: screenHeightUnit * 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: screenWidthUnit * 2,
                        ),
                        Text(
                          "(",
                          style: GoogleFonts.baloo2(
                            fontSize: screenHeightUnit * 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${savingsAccountBalance + savingsTransfer}",
                          style: GoogleFonts.baloo2(
                            fontSize: screenHeightUnit * 20,
                            color: (savingsTransfer > 0)
                                ? Color.fromRGBO(72, 209, 38, 1)
                                : Color.fromRGBO(243, 52, 52, 1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          ")",
                          style: GoogleFonts.baloo2(
                            fontSize: screenHeightUnit * 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeightUnit * 5,
                    )
                  ]),
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
