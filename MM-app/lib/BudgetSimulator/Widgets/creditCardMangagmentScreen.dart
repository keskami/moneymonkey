import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/functions.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/circlePainter.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/creditCardManagmentPaymentTracker.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/creditUtilizationManagmentPopUp.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/lightBlueInfo.dart';
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
  final double APR;
  final int creditCardMin;

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
    required this.APR,
    required this.creditCardMin,
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
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(
                left: widget.screenWidthUnit * 81,
                right: widget.screenWidthUnit * 81,
                top: widget.screenHeightUnit * 20,
                bottom: widget.screenHeightUnit * 15),
            child: widget.name == "Crush the Credit Card Debt"
                ? SingleChildScrollView(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: widget.screenHeightUnit * 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: widget.screenHeightUnit * 450,
                              width: widget.screenWidthUnit * 590,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: widget.screenWidthUnit * 16,
                                          bottom: widget.screenHeightUnit * 6,
                                          top: widget.screenHeightUnit * 10),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height:
                                                  widget.screenHeightUnit * 80,
                                              width:
                                                  widget.screenWidthUnit * 80,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color.fromRGBO(
                                                      216, 216, 216, .4)),
                                              child: Icon(Icons.speed,
                                                  color: Colors.black,
                                                  size: widget.screenWidthUnit *
                                                      32),
                                            ),
                                            SizedBox(
                                              width:
                                                  widget.screenWidthUnit * 15,
                                            ),
                                            Text(
                                              'Credit Summary',
                                              style: GoogleFonts.baloo2(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        35,
                                              ),
                                            ),
                                          ])),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: widget.screenWidthUnit * 30,
                                          top: widget.screenHeightUnit * 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height:
                                                widget.screenHeightUnit * 20,
                                          ),
                                          LightBlueInfo(
                                              screenHeightUnit:
                                                  widget.screenHeightUnit,
                                              screenWidthUnit:
                                                  widget.screenWidthUnit,
                                              name: "Debt",
                                              amount:
                                                  "\$${widget.credidCardDebt.abs()}",
                                              big: false),
                                          SizedBox(
                                            height:
                                                widget.screenHeightUnit * 20,
                                          ),
                                          LightBlueInfo(
                                              screenHeightUnit:
                                                  widget.screenHeightUnit,
                                              screenWidthUnit:
                                                  widget.screenWidthUnit,
                                              name: "Interest Rate",
                                              amount: "${widget.APR}% APR",
                                              big: false),
                                          SizedBox(
                                            height:
                                                widget.screenHeightUnit * 20,
                                          ),
                                          LightBlueInfo(
                                              screenHeightUnit:
                                                  widget.screenHeightUnit,
                                              screenWidthUnit:
                                                  widget.screenWidthUnit,
                                              name: "Minimum Monthly Payments",
                                              amount:
                                                  "\$${widget.creditCardMin}",
                                              big: false),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: widget.screenWidthUnit * 10,
                            ),
                            Container(
                              height: widget.screenHeightUnit * 450,
                              width: widget.screenWidthUnit * 590,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: widget.screenWidthUnit * 16,
                                          bottom: widget.screenHeightUnit * 20,
                                          top: widget.screenHeightUnit * 10),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height:
                                                  widget.screenHeightUnit * 80,
                                              width:
                                                  widget.screenWidthUnit * 80,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color.fromRGBO(
                                                      216, 216, 216, .4)),
                                              child: Icon(Icons.speed,
                                                  color: Colors.black,
                                                  size: widget.screenWidthUnit *
                                                      32),
                                            ),
                                            SizedBox(
                                              width:
                                                  widget.screenWidthUnit * 15,
                                            ),
                                            Text(
                                              'Credit Score',
                                              style: GoogleFonts.baloo2(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        35,
                                              ),
                                            ),
                                          ])),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(233, 244, 255, 1),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: creditColor.withOpacity(.7),
                                        width: widget.screenWidthUnit * 12,
                                      ),
                                    ),
                                    child: Center(
                                        child: Container(
                                      height: widget.screenHeightUnit * 250,
                                      width: widget.screenWidthUnit * 250,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${widget.creditScore}",
                                              style: GoogleFonts.baloo2(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        72,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  widget.screenHeightUnit * 2,
                                            ),
                                            Text(
                                              creditWord,
                                              style: GoogleFonts.baloo2(
                                                fontWeight: FontWeight.w600,
                                                color: creditColor,
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        43,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: widget.screenHeightUnit * 20,
                      ),
                      Center(
                          child: Container(
                        height: widget.screenHeightUnit * 700,
                        width: widget.screenWidthUnit * 1300,
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
                            Center(child: Container()),
                            SizedBox(
                              height: widget.screenHeightUnit * 0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: widget.screenWidthUnit * 30),
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
                              height: widget.screenHeightUnit * 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: widget.screenWidthUnit * 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: UnderstandingPayment(),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                      width: widget.screenWidthUnit * 560,
                                      height: widget.screenHeightUnit * 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border: Border.all(
                                            width: .5,
                                            color:
                                                Color.fromRGBO(0, 127, 255, 1)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: widget.screenHeightUnit * 10,
                                            bottom:
                                                widget.screenHeightUnit * 10,
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
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: widget
                                                              .screenHeightUnit *
                                                          0),
                                                  child: Text(
                                                    "Payment History",
                                                    style: GoogleFonts.baloo2(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromRGBO(
                                                          55, 65, 81, 1),
                                                      fontSize: widget
                                                              .screenHeightUnit *
                                                          33,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      widget.screenWidthUnit *
                                                          135,
                                                ),
                                                Container(
                                                  height:
                                                      widget.screenHeightUnit *
                                                          40,
                                                  width:
                                                      widget.screenWidthUnit *
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
                                                            18,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  widget.screenHeightUnit * 7,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${paymentPercentage}%",
                                                  style: GoogleFonts.baloo2(
                                                    fontWeight: FontWeight.w600,
                                                    color: paymentHistoryColor,
                                                    fontSize: widget
                                                            .screenHeightUnit *
                                                        30,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      widget.screenWidthUnit *
                                                          10,
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: widget
                                                                .screenHeightUnit *
                                                            2),
                                                    child: Text(
                                                      "Percentage of payments you’ve made on time",
                                                      style: GoogleFonts.baloo2(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color.fromRGBO(
                                                            106, 114, 128, 1),
                                                        fontSize: widget
                                                                .screenHeightUnit *
                                                            20,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: widget.screenWidthUnit * 20,
                                ),
                                Container(
                                    width: widget.screenWidthUnit * 560,
                                    height: widget.screenHeightUnit * 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          width: .5,
                                          color:
                                              Color.fromRGBO(0, 127, 255, 1)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: widget.screenHeightUnit * 3,
                                          bottom: widget.screenHeightUnit * 3,
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
                                                  color: Color.fromRGBO(
                                                      55, 65, 81, 1),
                                                  fontSize:
                                                      widget.screenHeightUnit *
                                                          33,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                              SizedBox(
                                                width: widget.screenWidthUnit *
                                                    210,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Dialog(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child:
                                                              UtilizationPopUp(),
                                                        );
                                                      },
                                                    );
                                                  },

                                                  child: Container(
                                                    height: widget
                                                            .screenHeightUnit *
                                                        40,
                                                    width:
                                                        widget.screenWidthUnit *
                                                            155,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            233, 244, 255, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        border: Border.all(
                                                          color: Color.fromRGBO(
                                                              0, 127, 255, 1),
                                                          width: 1,
                                                        )),
                                                    child: Center(
                                                      child: Text(
                                                        "High impact",
                                                        style:
                                                            GoogleFonts.baloo2(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color.fromRGBO(
                                                              0, 127, 255, 1),
                                                          fontSize: widget
                                                                  .screenHeightUnit *
                                                              18,
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
                                                      widget.screenHeightUnit *
                                                          32,
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
                                                  "Credit you’re using compared to total limit",
                                                  style: GoogleFonts.baloo2(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        106, 114, 128, 1),
                                                    fontSize: widget
                                                            .screenHeightUnit *
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
                              height: widget.screenHeightUnit * 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: widget.screenWidthUnit * 30,
                                ),
                                Container(
                                  width: widget.screenWidthUnit * 560,
                                  height: widget.screenHeightUnit * 430,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                          width: .5,
                                          color:
                                              Color.fromRGBO(0, 127, 255, 1))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: widget.screenWidthUnit * 30,
                                        top: widget.screenHeightUnit * 14),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [

                                        SizedBox(height: widget.screenHeightUnit * 10,),
                                        Container(
                                          height: widget.screenHeightUnit * 55,
                                          width: widget.screenWidthUnit * 260,
                                          decoration: BoxDecoration(
                                              color: paymentHistoryBackgroud,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: paymentHistoryColor,
                                                width: .5,
                                              )),
                                          child: Center(
                                            child: Text(
                                              "$paymentHistoryWord Payment History",
                                              style: GoogleFonts.baloo2(
                                                fontWeight: FontWeight.w600,
                                                color: paymentHistoryColor,
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        25,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: widget.screenHeightUnit * 15,
                                        ),
                                        CreditCardManagementPaymentTracker(
                                          screenHeightUnit:
                                              widget.screenHeightUnit,
                                          screenWidthUnit:
                                              widget.screenWidthUnit,
                                          due: widget.due,
                                          paid: widget.paid,
                                          done: widget.done,
                                          monthsOccurd: widget.monthsOccurd,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: widget.screenWidthUnit * 20,
                                ),
                                Container(
                                  width: widget.screenWidthUnit * 560,
                                  height: widget.screenHeightUnit * 360,
                                  child: Column(
                                    children: [
                                      Container(
                                          width: widget.screenWidthUnit * 560,
                                          height: widget.screenHeightUnit * 340,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              border: Border.all(
                                                  width: .5,
                                                  color: Color.fromRGBO(
                                                      0, 127, 255, 1))),
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: widget.screenWidthUnit *
                                                      30,
                                                  top: widget.screenHeightUnit *
                                                      14),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: widget
                                                                .screenHeightUnit *
                                                            10),
                                                    child: Container(
                                                      height: widget
                                                              .screenHeightUnit *
                                                          55,
                                                      width: widget
                                                              .screenWidthUnit *
                                                          200,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              utilizationBackgroud,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            color:
                                                                utilizationColor,
                                                            width: .5,
                                                          )),
                                                      child: Center(
                                                          child: Padding(
                                                        padding: EdgeInsets.only(
                                                            top: widget
                                                                    .screenHeightUnit *
                                                                0),
                                                        child: Text(
                                                          "$utilizationWord Utilization",
                                                          style: GoogleFonts
                                                              .baloo2(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                utilizationColor,
                                                            fontSize: widget
                                                                    .screenHeightUnit *
                                                                26,
                                                          ),
                                                        ),
                                                      )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: widget
                                                            .screenHeightUnit *
                                                        50,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Stack(
                                                        alignment:
                                                            Alignment.center,
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
                                                                    fontSize:
                                                                        widget.screenHeightUnit *
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
                                                            color:
                                                                Color.fromRGBO(
                                                                    106,
                                                                    114,
                                                                    128,
                                                                    1)),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  ))
                : Container()));
  }
}



//Old Code

// Text(
                  //   "Goal: Reduce debt by 50% (to \$${ccDebt.originalTotal / 2})",
                  //   style: GoogleFonts.baloo2(
                  //       fontSize: widget.screenHeightUnit * 30,
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.black),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Stack(
                  //       children: [
                  //         Container(
                  //           width: widget.screenWidthUnit * 500,
                  //           height: widget.screenHeightUnit * 45,
                  //           decoration: BoxDecoration(
                  //             color: Color.fromRGBO(216, 216, 216, .3),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: widget.screenWidthUnit *
                  //               500 *
                  //               ((2 *
                  //                       ((ccDebt.originalTotal -
                  //                               widget.credidCardDebt) /
                  //                           ccDebt.originalTotal)))
                  //                   .clamp(0.0, 1.0),
                  //           height: widget.screenHeightUnit * 45,
                  //           decoration: BoxDecoration(
                  //             color: Color.fromRGBO(0, 127, 255, 1),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     Container(
                  //       height: widget.screenHeightUnit * 60,
                  //       width: widget.screenWidthUnit * 200,
                  //       decoration: BoxDecoration(
                  //           color: Color.fromRGBO(233, 244, 255, 1),
                  //           borderRadius: BorderRadius.circular(15),
                  //           border: Border.all(
                  //             color: Color.fromRGBO(0, 127, 255, 1),
                  //             width: 1,
                  //           )),
                  //       child: Center(
                  //         child: Text(
                  //           "Credit Score: ${widget.creditScore}",
                  //           style: GoogleFonts.baloo2(
                  //             fontWeight: FontWeight.w600,
                  //             color: Color.fromRGBO(0, 127, 255, 1),
                  //             fontSize: widget.screenHeightUnit * 30,
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),

                  //  SizedBox(
//                                     height: widget.screenHeightUnit * 20,
//                                   ),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: GestureDetector(
//                                       onTap: () {},
//                                       child: Container(
//                                         height: widget.screenHeightUnit * 60,
//                                         width: widget.screenWidthUnit * 240,
//                                         decoration: BoxDecoration(
//                                           color: Color.fromRGBO(0, 127, 255, 1),
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                         child: Center(
//                                             child: Text(
//                                           "Simulate Payments",
//                                           style: GoogleFonts.baloo2(
//                                             fontSize:
//                                                 widget.screenWidthUnit * 20,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.white,
//                                           ),
//                                         )),
//                                       ),
//                                     ),
//                                   )