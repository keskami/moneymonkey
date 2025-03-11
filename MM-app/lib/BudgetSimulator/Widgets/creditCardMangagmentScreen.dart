import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/functions.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';

class CreditCardManagementScreen extends StatefulWidget {
  final double screenWidthUnit;
  final double screenHeightUnit;
  final String name;
  final String level;
  final List<Expense> expenses;
  final double credidCardDebt;
  final double creditScore;
  final int creditLimit;

  CreditCardManagementScreen({
    required this.screenWidthUnit,
    required this.screenHeightUnit,
    required this.name,
    required this.level,
    required this.expenses,
    this.credidCardDebt = 0,
    this.creditScore = 0,
    this.creditLimit = 0,
  });

  @override
  _CreditCardManagementScreenState createState() =>
      _CreditCardManagementScreenState();
}

class _CreditCardManagementScreenState
    extends State<CreditCardManagementScreen> {
  BudgetSimulatorFunctions functions = BudgetSimulatorFunctions();
  final List<Color> colors = [
    Colors.red,
    Color.fromRGBO(251, 176, 59, 1),
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
  ];

  late Expense ccDebt;
  late int creditUtilization;
  @override
  void initState() {
    setState(() {
      ccDebt = functions.getCCDebt(widget.expenses);
      creditUtilization = ((widget.credidCardDebt / widget.creditLimit) * 100) as int;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: widget.screenWidthUnit * 81,
            right: widget.screenWidthUnit * 81,
            top: widget.screenHeightUnit * 20,
            bottom: widget.screenHeightUnit * 15),
        child: widget.name == "Crush the Credit Card Debt"
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Goal: Reduce debt by 50% (to \$${ccDebt.originalTotal / 2})",
                    style: GoogleFonts.baloo2(
                        fontSize: widget.screenHeightUnit * 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: widget.screenWidthUnit * 500,
                            height: widget.screenHeightUnit * 45,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(216, 216, 216, .3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            width: widget.screenWidthUnit *
                                500 *
                                (1 -
                                    (widget.credidCardDebt /
                                        ccDebt.originalTotal)),
                            height: widget.screenHeightUnit * 45,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 127, 255, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: widget.screenHeightUnit * 60,
                        width: widget.screenWidthUnit * 200,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(233, 244, 255, 1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Color.fromRGBO(0, 127, 255, 1),
                              width: 1,
                            )),
                        child: Center(
                          child: Text(
                            "Credit Score: ${widget.creditScore}",
                            style: GoogleFonts.baloo2(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(0, 127, 255, 1),
                              fontSize: widget.screenHeightUnit * 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: widget.screenHeightUnit * 20,
                  ),
                  Center(
                      child: Container(
                    height: widget.screenHeightUnit * 830,
                    width: widget.screenWidthUnit * 1100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: widget.screenHeightUnit * 15,
                        ),
                        Center(
                            child: Container(
                          height: widget.screenHeightUnit * 225,
                          width: widget.screenWidthUnit * 225,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(233, 244, 255, 1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Container(
                            height: widget.screenHeightUnit * 190,
                            width: widget.screenWidthUnit * 190,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${widget.creditScore}",
                                    style: GoogleFonts.baloo2(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: widget.screenHeightUnit * 60,
                                    ),
                                  ),
                                  SizedBox(
                                    height: widget.screenHeightUnit * 2,
                                  ),
                                  widget.creditScore > 670
                                      ? Text(
                                          "Great",
                                          style: GoogleFonts.baloo2(
                                            fontWeight: FontWeight.w600,
                                            color: colors[4],
                                            fontSize:
                                                widget.screenHeightUnit * 35,
                                          ),
                                        )
                                      : widget.creditScore > 640
                                          ? Text(
                                              "Good",
                                              style: GoogleFonts.baloo2(
                                                fontWeight: FontWeight.w600,
                                                color: colors[3],
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        35,
                                              ),
                                            )
                                          : widget.creditScore > 610
                                              ? Text(
                                                  "Fair",
                                                  style: GoogleFonts.baloo2(
                                                    fontWeight: FontWeight.w600,
                                                    color: colors[2],
                                                    fontSize: widget
                                                            .screenHeightUnit *
                                                        35,
                                                  ),
                                                )
                                              : widget.creditScore > 580
                                                  ? Text(
                                                      "Poor",
                                                      style: GoogleFonts.baloo2(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: colors[1],
                                                        fontSize: widget
                                                                .screenHeightUnit *
                                                            35,
                                                      ),
                                                    )
                                                  : Text(
                                                      "Bad",
                                                      style: GoogleFonts.baloo2(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: colors[0],
                                                        fontSize: widget
                                                                .screenHeightUnit *
                                                            35,
                                                      ),
                                                    ),
                                ],
                              ),
                            ),
                          )),
                        )),
                        SizedBox(
                          height: widget.screenHeightUnit * 0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: widget.screenWidthUnit * 60),
                              child: Text(
                                'Main contributors to score:',
                                style: GoogleFonts.baloo2(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(106, 114, 128, 1),
                                  fontSize: widget.screenHeightUnit * 30,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: widget.screenHeightUnit * 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                width: widget.screenWidthUnit * 475,
                                height: widget.screenHeightUnit * 125,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: Color.fromRGBO(0, 127, 255, 1)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: widget.screenHeightUnit * 10,
                                      bottom: widget.screenHeightUnit * 10,
                                      left: widget.screenWidthUnit * 30),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Payment History",
                                            style: GoogleFonts.baloo2(
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color.fromRGBO(55, 65, 81, 1),
                                              fontSize:
                                                  widget.screenHeightUnit * 33,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(
                                            width: widget.screenWidthUnit * 65,
                                          ),
                                          Container(
                                            height:
                                                widget.screenHeightUnit * 50,
                                            width: widget.screenWidthUnit * 155,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    233, 244, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      0, 127, 255, 1),
                                                  width: 1,
                                                )),
                                            child: Center(
                                              child: Text(
                                                "High impact",
                                                style: GoogleFonts.baloo2(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      0, 127, 255, 1),
                                                  fontSize:
                                                      widget.screenHeightUnit *
                                                          25,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          widget.creditScore > 670
                                              ? Text(
                                                  "65%",
                                                  style: GoogleFonts.baloo2(
                                                    fontWeight: FontWeight.w600,
                                                    color: colors[4],
                                                    fontSize: widget
                                                            .screenHeightUnit *
                                                        35,
                                                  ),
                                                )
                                              : widget.creditScore > 610
                                                  ? Text(
                                                      "65%",
                                                      style: GoogleFonts.baloo2(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: colors[2],
                                                        fontSize: widget
                                                                .screenHeightUnit *
                                                            35,
                                                      ),
                                                    )
                                                  : Text(
                                                      "65%",
                                                      style: GoogleFonts.baloo2(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: colors[0],
                                                        fontSize: widget
                                                                .screenHeightUnit *
                                                            35,
                                                      ),
                                                    ),
                                          SizedBox(
                                            width: widget.screenWidthUnit * 10,
                                          ),
                                          Text(
                                            "Percentage of payments you’ve made on time",
                                            style: GoogleFonts.baloo2(
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  106, 114, 128, 1),
                                              fontSize:
                                                  widget.screenHeightUnit * 22,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            Container(
                                width: widget.screenWidthUnit * 475,
                                height: widget.screenHeightUnit * 125,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: Color.fromRGBO(0, 127, 255, 1)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: widget.screenHeightUnit * 10,
                                      bottom: widget.screenHeightUnit * 10,
                                      left: widget.screenWidthUnit * 30),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Utilization",
                                            style: GoogleFonts.baloo2(
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color.fromRGBO(55, 65, 81, 1),
                                              fontSize:
                                                  widget.screenHeightUnit * 33,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(
                                            width: widget.screenWidthUnit * 125,
                                          ),
                                          Container(
                                            height:
                                                widget.screenHeightUnit * 50,
                                            width: widget.screenWidthUnit * 155,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    233, 244, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      0, 127, 255, 1),
                                                  width: 1,
                                                )),
                                            child: Center(
                                              child: Text(
                                                "High impact",
                                                style: GoogleFonts.baloo2(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      0, 127, 255, 1),
                                                  fontSize:
                                                      widget.screenHeightUnit *
                                                          25,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          creditUtilization < 25
                                              ? Text(
                                                  "${creditUtilization}%",
                                                  style: GoogleFonts.baloo2(
                                                    fontWeight: FontWeight.w600,
                                                    color: colors[4],
                                                    fontSize: widget
                                                            .screenHeightUnit *
                                                        35,
                                                  ),
                                                ):creditUtilization < 50
                                              ? Text(
                                                  "${creditUtilization}%",
                                                  style: GoogleFonts.baloo2(
                                                    fontWeight: FontWeight.w600,
                                                    color: colors[3],
                                                    fontSize: widget
                                                            .screenHeightUnit *
                                                        35,
                                                  ),
                                                )
                                              : creditUtilization < 75
                                                  ? Text(
                                                      "${creditUtilization}%",
                                                      style: GoogleFonts.baloo2(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: colors[1],
                                                        fontSize: widget
                                                                .screenHeightUnit *
                                                            35,
                                                      ),
                                                    )
                                                  : Text(
                                                      "${creditUtilization}%",
                                                      style: GoogleFonts.baloo2(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: colors[0],
                                                        fontSize: widget
                                                                .screenHeightUnit *
                                                            35,
                                                      ),
                                                    ),
                                          SizedBox(
                                            width: widget.screenWidthUnit * 10,
                                          ),
                                          Text(
                                            "Credit you’re using compared to total limit",
                                            style: GoogleFonts.baloo2(
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  106, 114, 128, 1),
                                              fontSize:
                                                  widget.screenHeightUnit * 22,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: widget.screenHeightUnit * 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: widget.screenWidthUnit * 475,
                              height: widget.screenHeightUnit * 368,
                              color: Colors.green,
                            ),
                            Container(
                              width: widget.screenWidthUnit * 475,
                              height: widget.screenHeightUnit * 368,
                              color: Colors.green,
                            )
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              )
            : Container());
  }
}
