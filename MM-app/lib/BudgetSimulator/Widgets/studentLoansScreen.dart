import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/lightBlueInfo.dart';

class StudentLoansScreen extends StatefulWidget {
  final double screenWidthUnit;
  final double screenHeightUnit;

  const StudentLoansScreen({
    Key? key,
    required this.screenWidthUnit,
    required this.screenHeightUnit,
  }) : super(key: key);

  @override
  _StudentLoansScreenState createState() => _StudentLoansScreenState();
}

class _StudentLoansScreenState extends State<StudentLoansScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.screenHeightUnit * 50,
          horizontal: widget.screenWidthUnit * 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: widget.screenHeightUnit * 400,
                  width: widget.screenWidthUnit * 600,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.screenWidthUnit * 20,
                        vertical: widget.screenHeightUnit * 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widget.screenWidthUnit * 60,
                              height: widget.screenHeightUnit * 60,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(216, 216, 216, .4),
                                backgroundBlendMode: BlendMode.darken,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.monetization_on,
                                  color: Colors.black,
                                  size: widget.screenWidthUnit * 26,
                                ),
                              ),
                            ),
                            SizedBox(width: widget.screenWidthUnit * 40),
                            Text(
                              "Loan Summary",
                              style: GoogleFonts.baloo2(
                                fontSize: widget.screenHeightUnit * 35,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: widget.screenHeightUnit * 15,
                        ),
                        LightBlueInfo(
                            screenHeightUnit: widget.screenHeightUnit,
                            screenWidthUnit: widget.screenWidthUnit,
                            name: "Debt",
                            amount: "\$28,000",
                            big: true),
                        SizedBox(
                          height: widget.screenHeightUnit * 15,
                        ),
                        LightBlueInfo(
                            screenHeightUnit: widget.screenHeightUnit,
                            screenWidthUnit: widget.screenWidthUnit,
                            name: "Interest Rate",
                            amount: "5%",
                            big: true),
                        SizedBox(
                          height: widget.screenHeightUnit * 15,
                        ),
                        LightBlueInfo(
                            screenHeightUnit: widget.screenHeightUnit,
                            screenWidthUnit: widget.screenWidthUnit,
                            name: "Monthly Payment",
                            amount: "\$297",
                            big: true),
                        SizedBox(
                          height: widget.screenHeightUnit * 15,
                        ),
                        LightBlueInfo(
                            screenHeightUnit: widget.screenHeightUnit,
                            screenWidthUnit: widget.screenWidthUnit,
                            name: "Term",
                            amount: "10 Years",
                            big: true)
                      ],
                    ),
                  )),
              SizedBox(width: widget.screenWidthUnit * 60),
              Container(
                  height: widget.screenHeightUnit * 400,
                  width: widget.screenWidthUnit * 600,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.screenWidthUnit * 00,
                        vertical: widget.screenHeightUnit * 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: widget.screenWidthUnit * 20,
                            ),
                            Container(
                              width: widget.screenWidthUnit * 60,
                              height: widget.screenHeightUnit * 60,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(216, 216, 216, .4),
                                backgroundBlendMode: BlendMode.darken,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.speed,
                                  color: Colors.black,
                                  size: widget.screenWidthUnit * 26,
                                ),
                              ),
                            ),
                            SizedBox(width: widget.screenWidthUnit * 40),
                            Text(
                              "Budget Impact",
                              style: GoogleFonts.baloo2(
                                fontSize: widget.screenHeightUnit * 35,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: widget.screenHeightUnit * 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: widget.screenWidthUnit * 20),
                                child: Text(
                                  "Monthly Income:",
                                  style: GoogleFonts.baloo2(
                                      fontSize: widget.screenHeightUnit * 27,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(106, 114, 128, 1)),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: widget.screenWidthUnit * 20),
                              child: Container(
                                width: widget.screenWidthUnit * 120,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "\$4,200",
                                      style: GoogleFonts.baloo2(
                                          fontSize:
                                              widget.screenHeightUnit * 32,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: widget.screenHeightUnit * 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: widget.screenWidthUnit * 20),
                                child: Text(
                                  "Student Loan:",
                                  style: GoogleFonts.baloo2(
                                      fontSize: widget.screenHeightUnit * 27,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(106, 114, 128, 1)),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: widget.screenWidthUnit * 20),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "\$297",
                                    style: GoogleFonts.baloo2(
                                        fontSize: widget.screenHeightUnit * 32,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(243, 52, 52, 1)),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: widget.screenHeightUnit * 15,
                        ),
                        Container(
                          height: widget.screenHeightUnit * 1,
                          width: widget.screenWidthUnit * 700,
                          color: Color.fromRGBO(127, 127, 127, 1),
                        ),
                         SizedBox(
                          height: widget.screenHeightUnit * 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: widget.screenWidthUnit * 20),
                                child: Text(
                                  "Remaining:",
                                  style: GoogleFonts.baloo2(
                                      fontSize: widget.screenHeightUnit * 27,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(106, 114, 128, 1)),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: widget.screenWidthUnit * 20),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "\$3,903",
                                    style: GoogleFonts.baloo2(
                                        fontSize: widget.screenHeightUnit * 32,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(0,199,129, 1)),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
