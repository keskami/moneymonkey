import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/functions.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/circlePainter.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/creditCardManagmentPaymentTracker.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/creditUtilizationManagmentPopUp.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/undsertandingPayment.dart';

class CreditCardManagementScreen extends StatefulWidget {
  final double screenWidthUnit;
  final double screenHeightUnit;
  final String name;
  final String level;
  final List<Expense> expenses;
  final double credidCardDebt;
  final double creditScore;
  final int creditLimit;
  final int totalPayemntsSeen;
  final int totalPaymentsPaid;
  final List<int> due;
  final List<int> paid;
  final List<bool> done;
  final int monthsOccurd;

  CreditCardManagementScreen({
    required this.screenWidthUnit,
    required this.screenHeightUnit,
    required this.name,
    required this.level,
    required this.expenses,
    this.credidCardDebt = 0,
    this.creditScore = 0,
    this.creditLimit = 0,
    required this.totalPayemntsSeen,
    required this.totalPaymentsPaid,
    required this.due,
    required this.paid,
    required this.done,
    required this.monthsOccurd,
  });

  @override
  _CreditCardManagementScreenState createState() =>
      _CreditCardManagementScreenState();
}

class _CreditCardManagementScreenState
    extends State<CreditCardManagementScreen> {
  BudgetSimulatorFunctions functions = BudgetSimulatorFunctions();
  late Expense ccDebt;
  late int creditUtilization;
  late String paymentPercentage;
  late int paymentPercentageNum;
  late String paymentHistoryWord;
  late Color paymentHistoryColor;
  late Color paymentHistoryBackgroud;
  late String utilizationWord;
  late Color utilizationColor;
  late Color utilizationBackgroud;

  late String creditWord;
  late Color creditColor;

  @override
  void initState() {
    super.initState();
    ccDebt = functions.getCCDebt(widget.expenses);
    creditUtilization = widget.creditLimit > 0
        ? ((widget.credidCardDebt / widget.creditLimit) * 100).toInt()
        : 0;
    paymentPercentage = widget.totalPayemntsSeen > 0
        ? ((widget.totalPaymentsPaid / widget.totalPayemntsSeen) * 100)
            .toStringAsFixed(0)
        : "NA";
    paymentPercentageNum = widget.totalPayemntsSeen > 0
        ? ((widget.totalPaymentsPaid / widget.totalPayemntsSeen) * 100).toInt()
        : 0;
    setState(() {
      paymentHistoryWord = functions.getPaymentHistoryWord(
          paymentPercentageNum as double, widget.totalPayemntsSeen);
      paymentHistoryColor = functions.getPaymentHistoryTextColor(
          paymentPercentageNum as double, widget.totalPayemntsSeen);
      paymentHistoryBackgroud = functions.getPaymentHistoryBackgroudColor(
          paymentPercentageNum as double, widget.totalPayemntsSeen);
      utilizationWord = functions.getUtilizationWord(
          widget.credidCardDebt, widget.creditLimit as double);
      utilizationColor = functions.getUtilizationTextColor(
          widget.credidCardDebt, widget.creditLimit as double);
      utilizationBackgroud = functions.getUtilizationBackgroudColor(
          widget.credidCardDebt, widget.creditLimit as double);
      creditColor = functions.getCreditTextColor(widget.creditScore as int);
      creditWord = functions.getCreditnWord(widget.creditScore as int);
    });
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
                                ((2 *
                                        ((ccDebt.originalTotal -
                                                widget.credidCardDebt) /
                                            ccDebt.originalTotal)))
                                    .clamp(0.0, 1.0),
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
                    height: widget.screenHeightUnit * 10,
                  ),
                  Center(
                      child: Container(
                    height: widget.screenHeightUnit * 840,
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
                          height: widget.screenHeightUnit * 10,
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
                                  Text(
                                    creditWord,
                                    style: GoogleFonts.baloo2(
                                      fontWeight: FontWeight.w600,
                                      color: creditColor,
                                      fontSize: widget.screenHeightUnit * 35,
                                    ),
                                  )
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
                          height: widget.screenHeightUnit * 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: UnderstandingPayment(),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                  width: widget.screenWidthUnit * 475,
                                  height: widget.screenHeightUnit * 105,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 1,
                                        color: Color.fromRGBO(0, 127, 255, 1)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: widget.screenHeightUnit * 5,
                                        bottom: widget.screenHeightUnit * 5,
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
                                                color: Color.fromRGBO(
                                                    55, 65, 81, 1),
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        33,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(
                                              width:
                                                  widget.screenWidthUnit * 65,
                                            ),
                                            Container(
                                              height:
                                                  widget.screenHeightUnit * 40,
                                              width:
                                                  widget.screenWidthUnit * 155,
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
                                                    fontSize: widget
                                                            .screenHeightUnit *
                                                        20,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${paymentPercentage}%",
                                              style: GoogleFonts.baloo2(
                                                fontWeight: FontWeight.w600,
                                                color: paymentHistoryColor,
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        30,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  widget.screenWidthUnit * 10,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: widget
                                                            .screenHeightUnit *
                                                        2),
                                                child: Text(
                                                  "Percentage of payments you’ve made on time",
                                                  style: GoogleFonts.baloo2(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        106, 114, 128, 1),
                                                    fontSize: widget
                                                            .screenHeightUnit *
                                                        22,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Container(
                                width: widget.screenWidthUnit * 475,
                                height: widget.screenHeightUnit * 105,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: Color.fromRGBO(0, 127, 255, 1)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: widget.screenHeightUnit * 5,
                                      bottom: widget.screenHeightUnit * 5,
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
                                          GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: UtilizationPopUp(),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                height:
                                                    widget.screenHeightUnit *
                                                        40,
                                                width: widget.screenWidthUnit *
                                                    155,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        233, 244, 255, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                      color: Color.fromRGBO(
                                                          0, 127, 255, 1),
                                                      width: 1,
                                                    )),
                                                child: Center(
                                                  child: Text(
                                                    "High impact",
                                                    style: GoogleFonts.baloo2(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromRGBO(
                                                          0, 127, 255, 1),
                                                      fontSize: widget
                                                              .screenHeightUnit *
                                                          20,
                                                    ),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${creditUtilization}%",
                                            style: GoogleFonts.baloo2(
                                              fontWeight: FontWeight.w600,
                                              color: utilizationColor,
                                              fontSize:
                                                  widget.screenHeightUnit * 30,
                                            ),
                                          ),
                                          SizedBox(
                                            width: widget.screenWidthUnit * 10,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: widget.screenHeightUnit *
                                                    2),
                                            child: Text(
                                              "Credit you’re using compared to total limit",
                                              style: GoogleFonts.baloo2(
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    106, 114, 128, 1),
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        22,
                                              ),
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
                          height: widget.screenHeightUnit * 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: widget.screenWidthUnit * 475,
                              height: widget.screenHeightUnit * 400,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color.fromRGBO(0, 127, 255, 1))),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: widget.screenWidthUnit * 30,
                                    top: widget.screenHeightUnit * 18),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: widget.screenHeightUnit * 65,
                                      width: widget.screenWidthUnit * 260,
                                      decoration: BoxDecoration(
                                          color: paymentHistoryBackgroud,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: paymentHistoryColor,
                                            width: 1,
                                          )),
                                      child: Center(
                                        child: Text(
                                          "$paymentHistoryWord Payment History",
                                          style: GoogleFonts.baloo2(
                                            fontWeight: FontWeight.w600,
                                            color: paymentHistoryColor,
                                            fontSize:
                                                widget.screenHeightUnit * 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: widget.screenHeightUnit * 5,
                                    ),
                                    CreditCardManagementPaymentTracker(
                                      screenHeightUnit: widget.screenHeightUnit,
                                      screenWidthUnit: widget.screenWidthUnit,
                                      due: widget.due,
                                      paid: widget.paid,
                                      done: widget.done,
                                      monthsOccurd: widget.monthsOccurd,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: widget.screenWidthUnit * 475,
                              height: widget.screenHeightUnit * 420,
                              child: Column(
                                children: [
                                  Container(
                                      width: widget.screenWidthUnit * 475,
                                      height: widget.screenHeightUnit * 340,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  0, 127, 255, 1))),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: widget.screenWidthUnit * 30,
                                              top:
                                                  widget.screenHeightUnit * 18),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height:
                                                    widget.screenHeightUnit *
                                                        65,
                                                width: widget.screenWidthUnit *
                                                    200,
                                                decoration: BoxDecoration(
                                                    color: utilizationBackgroud,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                      color: utilizationColor,
                                                      width: 1,
                                                    )),
                                                child: Center(
                                                  child: Text(
                                                    "$utilizationWord Utilization",
                                                    style: GoogleFonts.baloo2(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: utilizationColor,
                                                      fontSize: widget
                                                              .screenHeightUnit *
                                                          30,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    widget.screenHeightUnit *
                                                        45,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: widget
                                                                .screenWidthUnit *
                                                            160,
                                                        height: widget
                                                                .screenHeightUnit *
                                                            160,
                                                        child: CustomPaint(
                                                          painter: CirclePainter(
                                                              creditUtilization /
                                                                  100,
                                                              utilizationColor,
                                                              utilizationBackgroud),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${(creditUtilization).toInt()}%",
                                                            style: TextStyle(
                                                                fontSize: widget
                                                                        .screenHeightUnit *
                                                                    35,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                              "\$${widget.credidCardDebt} out of\n\$${widget.creditLimit}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      widget.screenHeightUnit *
                                                                          22)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "Check in regularly\nto keep your balances\nlow!",
                                                    style: GoogleFonts.baloo2(
                                                        fontSize: widget
                                                                .screenHeightUnit *
                                                            28,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromRGBO(
                                                            106, 114, 128, 1)),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ))),
                                  SizedBox(
                                    height: widget.screenHeightUnit * 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: widget.screenHeightUnit * 60,
                                        width: widget.screenWidthUnit * 240,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 127, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "Simulate Payments",
                                          style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenWidthUnit * 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ))
                ],
              )
            : Container());
  }
}
