import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/functions.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/wellnessBox2.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/welnessBox.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Allocatefunding extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final List<String> types;
  final double wellnessScore;
  int checkingAccountBalance;
  int creditCardDebt;
  int savingsAccountBalance;
  List<Expense> expenses;
  Function onConfirm;
  int savingsTransfer;
  int checkingTransfer;

  Allocatefunding({
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.types,
    required this.wellnessScore,
    required this.checkingAccountBalance,
    required this.creditCardDebt,
    required this.savingsAccountBalance,
    required this.expenses,
    required this.onConfirm,
    required this.savingsTransfer,
    required this.checkingTransfer,
  });

  @override
  _AllocatefundingState createState() => _AllocatefundingState();
  late int rentOutOf;
  late int groceriesOutOf;
  late int transportationOutOf;
  late int utilitiesOutOf;
  late int groceriesSpent;
  late int rentSpent;
  late int transportationSpent;
  late int utilitiesSpent;

  BudgetSimulatorFunctions model = BudgetSimulatorFunctions();


  Future<void> getOutOfs() async {
    for (var expense in expenses) {
      switch (expense.name) {
        case 'Rent':
          rentOutOf = expense.amount as int;
          rentSpent = expense.amountPaid as int;
          break;
        case 'Groceries':
          groceriesOutOf = expense.amount as int;
          groceriesSpent = expense.amountPaid as int;
          break;
        case 'Transportation':
          transportationOutOf = expense.amount as int;
          transportationSpent = expense.amountPaid as int;
          break;
        case 'Utilities':
          utilitiesOutOf = expense.amount as int;
          utilitiesSpent = expense.amountPaid as int;
          break;
        default:
          break;
      }
    }
  }
}

class _AllocatefundingState extends State<Allocatefunding> {
  int toCredCardDebt = 0;
  int toEntertainment = 0;
  int toFitness = 0;
  int toChecking = 0;
  int toSavings = 0;

  int rentSpentNow = 0;
  int utilitiesSpentNow = 0;
  int groceriesSpentNow = 0;
  int travelSpentNow = 0;

  late int toSpend;

  List<Color> colors = [
    Colors.pink,
    Colors.blue,
    Colors.teal,
    Colors.orange,
    Colors.yellow,
    Colors.pink
  ];
  @override
  void initState() {
    super.initState();
    widget.getOutOfs();
    setState(() {
      toSpend = widget.checkingAccountBalance;
    });
  }

  List<int> prices = [100, 10, 20, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return true
        ? Container(
            height: widget.screenHeightUnit * 1066,
            width: widget.screenWidthUnit * 1190,
            decoration: BoxDecoration(
                color: Color.fromRGBO(79, 195, 247, 1),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.only(
                top: widget.screenHeightUnit * 45,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: widget.screenHeightUnit * 270,
                          width: widget.screenWidthUnit * 470,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: widget.screenWidthUnit * 30,
                                      top: widget.screenHeightUnit * 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.account_balance,
                                        size: widget.screenHeightUnit * 48,
                                        color: Colors.black,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: widget.screenWidthUnit * 10,
                                              top: widget.screenHeightUnit * 5),
                                          child: Text(
                                            "Overview",
                                            style: GoogleFonts.baloo2(
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        38,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          )),
                                    ],
                                  )),
                              SizedBox(height: widget.screenHeightUnit * 8),
                              Container(
                                  height: widget.screenHeightUnit * 1,
                                  width: widget.screenWidthUnit * 470,
                                  color: Colors.black),
                              SizedBox(height: widget.screenHeightUnit * 25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total to spend",
                                        style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 25,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                108, 108, 108, 1)),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                          height: widget.screenHeightUnit * 5),
                                      Text(
                                        toChecking >= 0 ? 
                                        "\$${widget.checkingAccountBalance}" : "\$${widget.checkingAccountBalance + toChecking}",
                                        style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 65,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(0, 0, 0, 1)),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Credit Debt",
                                        style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 25,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                108, 108, 108, 1)),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                          height: widget.screenHeightUnit * 5),
                                      Text(
                                        "-\$${widget.creditCardDebt}",
                                        style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 65,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Color.fromRGBO(243, 52, 52, 1)),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                      SizedBox(
                        width: widget.screenWidthUnit * 10,
                      ),
                      Container(
                        height: widget.screenHeightUnit * 270,
                        width: widget.screenWidthUnit * 660,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: widget.screenWidthUnit * 30,
                                      top: widget.screenHeightUnit * 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: widget.screenHeightUnit * 45,
                                        width: widget.screenHeightUnit * 45,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Icon(
                                          Icons.swap_horiz,
                                          color: Colors.white,
                                          size: widget.screenHeightUnit * 40,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: widget.screenWidthUnit * 10,
                                              top: widget.screenHeightUnit * 3),
                                          child: Text(
                                            "Transfer Money",
                                            style: GoogleFonts.baloo2(
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        38,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          )),
                                    ],
                                  )),
                              SizedBox(height: widget.screenHeightUnit * 10),
                              Container(
                                  height: widget.screenHeightUnit * 1,
                                  width: widget.screenWidthUnit * 660,
                                  color: Colors.black),
                              SizedBox(height: widget.screenHeightUnit * 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Checking",
                                        style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 30,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        height: widget.screenHeightUnit * 14,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if ((widget
                                                      .checkingAccountBalance) + toChecking + widget.checkingTransfer >
                                                  0 && (widget
                                                      .checkingAccountBalance) + toChecking > 0) {
                                                setState(() {
                                                  //widget.savingsAccountBalance +=
                                                    //  10;
                                                  //widget.checkingAccountBalance -=
                                                      //10;
                                                 
                                                  toChecking -= 10;
                                                  toSavings += 10;
                                                  
                                                });
                                              }
                                            },
                                            child: Container(
                                              width:
                                                  55 * widget.screenHeightUnit,
                                              height:
                                                  55 * widget.screenHeightUnit,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    79, 195, 247, 1),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.remove,
                                                  size:
                                                      widget.screenHeightUnit *
                                                          45,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    widget.screenWidthUnit * 0),
                                            child: Container(
                                                width: widget.screenWidthUnit *
                                                    120,
                                                child: Center(
                                                    child: toChecking == 0
                                                        ? Text(
                                                            "0",
                                                            style: GoogleFonts
                                                                .baloo2(
                                                              fontSize: widget
                                                                      .screenHeightUnit *
                                                                  45,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        : toChecking > 0
                                                            ? Text(
                                                                "+${toChecking}",
                                                                style: GoogleFonts.baloo2(
                                                                    fontSize:
                                                                        widget.screenHeightUnit *
                                                                            45,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            30,
                                                                            213,
                                                                            58,
                                                                            1)),
                                                              )
                                                            : Text(
                                                                "${toChecking}",
                                                                style: GoogleFonts.baloo2(
                                                                    fontSize:
                                                                        widget.screenHeightUnit *
                                                                            45,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            243,
                                                                            52,
                                                                            52,
                                                                            1)),
                                                              ))),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if ((widget.savingsAccountBalance + toSavings + widget.savingsTransfer) >
                                                  0  &&(widget.savingsAccountBalance + toSavings) >
                                                  0) {
                                                setState(() {
                                                  
                                                  //widget.savingsAccountBalance -=
                                                      //10;
                                                  //widget.checkingAccountBalance +=
                                                      //10;
                                                  toChecking += 10;
                                                  toSavings -= 10;
                                                  //toSpend -= 10;
                                                });
                                              }
                                            },
                                            child: Container(
                                              width:
                                                  55 * widget.screenHeightUnit,
                                              height:
                                                  55 * widget.screenHeightUnit,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    79, 195, 247, 1),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  size:
                                                      widget.screenHeightUnit *
                                                          45,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: widget.screenHeightUnit * 45),
                                      child: Image.network(
                                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fdouble-arrow%20(1)%201.png?alt=media&token=8ba81355-4ecb-4af3-af33-49ccc6b947ae",
                                        height: widget.screenHeightUnit * 73,
                                        width: widget.screenWidthUnit * 73,
                                      )),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Savings",
                                        style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 30,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        height: widget.screenHeightUnit * 14,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (widget.savingsAccountBalance  + toSavings + widget.savingsTransfer>
                                                  0 && widget.savingsAccountBalance  + toSavings>
                                                  0) {
                                                setState(() {
                                                  //widget.savingsAccountBalance -=
                                                      //10;
                                                  //widget.checkingAccountBalance +=
                                                      //10;
                                                  toChecking += 10;
                                                  toSavings -= 10;
                                                });
                                              }
                                            },
                                            child: Container(
                                              width:
                                                  55 * widget.screenHeightUnit,
                                              height:
                                                  55 * widget.screenHeightUnit,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    79, 195, 247, 1),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.remove,
                                                  size:
                                                      widget.screenHeightUnit *
                                                          45,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    widget.screenWidthUnit * 0),
                                            child: Container(
                                                width: widget.screenWidthUnit *
                                                    120,
                                                child: Center(
                                                    child: toSavings == 0
                                                        ? Text(
                                                            "0",
                                                            style: GoogleFonts
                                                                .baloo2(
                                                              fontSize: widget
                                                                      .screenHeightUnit *
                                                                  45,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        : toSavings > 0
                                                            ? Text(
                                                                "+${toSavings}",
                                                                style: GoogleFonts.baloo2(
                                                                    fontSize:
                                                                        widget.screenHeightUnit *
                                                                            45,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            30,
                                                                            213,
                                                                            58,
                                                                            1)),
                                                              )
                                                            : Text(
                                                                "${toSavings}",
                                                                style: GoogleFonts.baloo2(
                                                                    fontSize:
                                                                        widget.screenHeightUnit *
                                                                            45,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            243,
                                                                            52,
                                                                            52,
                                                                            1)),
                                                              ))),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (widget
                                                      .checkingAccountBalance  + toChecking>
                                                  0 &&  widget
                                                      .checkingAccountBalance  + toChecking + widget.checkingTransfer>
                                                  0) {
                                                setState(() {
                                                  //widget.savingsAccountBalance +=
                                                      //10;
                                                  //widget.checkingAccountBalance -=
                                                      //10;

                                                  toChecking -= 10;
                                                  toSavings += 10;
                                                  if(toChecking < 0){
                                                    toSpend -= 10;

                                                  }
                                                  
                                                });
                                              }
                                            },
                                            child: Container(
                                              width:
                                                  55 * widget.screenHeightUnit,
                                              height:
                                                  55 * widget.screenHeightUnit,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    79, 195, 247, 1),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  size:
                                                      widget.screenHeightUnit *
                                                          45,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: widget.screenHeightUnit * 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: widget.screenHeightUnit * 260,
                              width: widget.screenWidthUnit * 470,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: WellnessBox2(
                                  screenHeightUnit: widget.screenHeightUnit,
                                  screenWidthUnit: widget.screenWidthUnit,
                                  wellnessScore: widget.wellnessScore)),
                          SizedBox(
                            height: widget.screenHeightUnit * 10,
                          ),
                          Container(
                              height: widget.screenHeightUnit * 260,
                              width: widget.screenWidthUnit * 470,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: widget.screenWidthUnit * 190,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Entertainment",
                                            style: GoogleFonts.baloo2(
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        42,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    59, 130, 246, 1)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: widget.screenWidthUnit * 30,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (toEntertainment > 0) {
                                            setState(() {
                                              toEntertainment -= 10;
                                              widget.checkingAccountBalance +=
                                                  10;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 50 * widget.screenHeightUnit,
                                          height: 50 * widget.screenHeightUnit,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(79, 195, 247, 1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.remove,
                                              size:
                                                  widget.screenHeightUnit * 35,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                widget.screenWidthUnit * 0),
                                        child: Container(
                                            width: widget.screenWidthUnit * 120,
                                            child: Center(
                                                child: Text(
                                              "+$toEntertainment",
                                              style: GoogleFonts.baloo2(
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        45,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ))),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (widget.checkingAccountBalance >
                                              10) {
                                            setState(() {
                                              toEntertainment += 10;
                                              widget.checkingAccountBalance -=
                                                  10;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 50 * widget.screenHeightUnit,
                                          height: 50 * widget.screenHeightUnit,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(79, 195, 247, 1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              size:
                                                  widget.screenHeightUnit * 35,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: widget.screenHeightUnit * 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: widget.screenWidthUnit * 190,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Fitness",
                                            style: GoogleFonts.baloo2(
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        42,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    251, 176, 59, 1)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: widget.screenWidthUnit * 30,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (toFitness > 0) {
                                            setState(() {
                                              toFitness -= 10;
                                              widget.checkingAccountBalance +=
                                                  10;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 50 * widget.screenHeightUnit,
                                          height: 50 * widget.screenHeightUnit,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(79, 195, 247, 1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.remove,
                                              size:
                                                  widget.screenHeightUnit * 35,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                widget.screenWidthUnit * 0),
                                        child: Container(
                                            width: widget.screenWidthUnit * 120,
                                            child: Center(
                                                child: Text(
                                              "+$toFitness",
                                              style: GoogleFonts.baloo2(
                                                fontSize:
                                                    widget.screenHeightUnit *
                                                        45,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ))),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (widget.checkingAccountBalance >
                                              0) {
                                            setState(() {
                                              toFitness += 10;
                                              widget.checkingAccountBalance -=
                                                  10;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 50 * widget.screenHeightUnit,
                                          height: 50 * widget.screenHeightUnit,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(79, 195, 247, 1),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              size:
                                                  widget.screenHeightUnit * 35,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        width: widget.screenWidthUnit * 10,
                      ),
                      Container(
                          height: widget.screenHeightUnit * 530,
                          width: widget.screenWidthUnit * 660,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: widget.screenWidthUnit * 30,
                                        top: widget.screenHeightUnit * 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: widget.screenHeightUnit *
                                                    5),
                                            child: Text(
                                              "Required Payments",
                                              style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      widget.screenHeightUnit *
                                                          38,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            )),
                                      ],
                                    )),
                                SizedBox(height: widget.screenHeightUnit * 8),
                                Container(
                                    height: widget.screenHeightUnit * 1,
                                    width: widget.screenWidthUnit * 660,
                                    color: Colors.black),
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: widget.screenWidthUnit * 32),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                            children: [
                                            RequiredMeter(
                                              screenHeightUnit:
                                                widget.screenHeightUnit,
                                              screenWidthUnit:
                                                widget.screenWidthUnit,
                                              type: "Rent",
                                              outOf: widget.rentOutOf,
                                              spent: widget.rentSpent,
                                              spentNow: rentSpentNow,
                                              onTapAdd: () {
                                              if (widget.checkingAccountBalance > 0 &&
                                                widget.rentSpent < widget.rentOutOf) {
                                                setState(() {
                                                widget.checkingAccountBalance -= 10;
                                                widget.rentSpent += 10;
                                                rentSpentNow += 10;
                                                });
                                              }
                                              },
                                              onTapSub: () {
                                              if (rentSpentNow > 0) {
                                                setState(() {
                                                widget.checkingAccountBalance += 10;
                                                rentSpentNow -= 10;
                                                widget.rentSpent -= 10;
                                                });
                                              }
                                              },
                                            ),
                                            RequiredMeter(
                                              screenHeightUnit:
                                                widget.screenHeightUnit,
                                              screenWidthUnit:
                                                widget.screenWidthUnit,
                                              type: "Groceries",
                                              outOf: widget.groceriesOutOf,
                                              spent: widget.groceriesSpent,
                                              spentNow: groceriesSpentNow,
                                              onTapAdd: () {
                                              if (widget.checkingAccountBalance > 0 &&
                                                widget.groceriesSpent < widget.groceriesOutOf) {
                                                setState(() {
                                                widget.checkingAccountBalance -= 10;
                                                widget.groceriesSpent += 10;
                                                groceriesSpentNow += 10;
                                                });
                                              }
                                              },
                                              onTapSub: () {
                                              if (groceriesSpentNow > 0) {
                                                setState(() {
                                                widget.checkingAccountBalance += 10;
                                                groceriesSpentNow -= 10;
                                                widget.groceriesSpent -= 10;
                                                });
                                              }
                                              },
                                            ),
                                            RequiredMeter(
                                              screenHeightUnit:
                                                widget.screenHeightUnit,
                                              screenWidthUnit:
                                                widget.screenWidthUnit,
                                              type: "Transportation",
                                              outOf: widget.transportationOutOf,
                                              spent: widget.transportationSpent,
                                              spentNow: travelSpentNow,
                                              onTapAdd: () {
                                              if (widget.checkingAccountBalance > 0 &&
                                                widget.transportationSpent < widget.transportationOutOf) {
                                                setState(() {
                                                widget.checkingAccountBalance -= 10;
                                                widget.transportationSpent += 10;
                                                travelSpentNow += 10;
                                                });
                                              }
                                              },
                                              onTapSub: () {
                                              if (travelSpentNow > 0) {
                                                setState(() {
                                                widget.checkingAccountBalance += 10;
                                                travelSpentNow -= 10;
                                                widget.transportationSpent -= 10;
                                                });
                                              }
                                              },
                                            ),
                                            RequiredMeter(
                                              screenHeightUnit:
                                                widget.screenHeightUnit,
                                              screenWidthUnit:
                                                widget.screenWidthUnit,
                                              type: "Utilities",
                                              outOf: widget.utilitiesOutOf,
                                              spent: widget.utilitiesSpent,
                                              spentNow: utilitiesSpentNow,
                                              onTapAdd: () {
                                              if (widget.checkingAccountBalance > 0 &&
                                                widget.utilitiesSpent < widget.utilitiesOutOf) {
                                                setState(() {
                                                widget.checkingAccountBalance -= 10;
                                                widget.utilitiesSpent += 10;
                                                utilitiesSpentNow += 10;
                                                });
                                              }
                                              },
                                              onTapSub: () {
                                              if (utilitiesSpentNow > 0) {
                                                setState(() {
                                                widget.checkingAccountBalance += 10;
                                                utilitiesSpentNow -= 10;
                                                widget.utilitiesSpent -= 10;
                                                });
                                              }
                                              },
                                            ),
                                          ],
                                        )))
                              ])),
                    ],
                  ),
                  SizedBox(
                    height: widget.screenHeightUnit * 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: widget.screenHeightUnit * 135,
                          width: widget.screenWidthUnit * 615,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: widget.screenHeightUnit * 45,
                                  width: widget.screenHeightUnit * 45,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Icon(
                                    Icons.swap_horiz,
                                    color: Colors.white,
                                    size: widget.screenHeightUnit * 40,
                                  ),
                                ),
                                SizedBox(
                                  width: widget.screenWidthUnit * 10,
                                ),
                                Text(
                                  "Pay off debt",
                                  style: GoogleFonts.baloo2(
                                      fontSize: widget.screenHeightUnit * 50,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: widget.screenWidthUnit * 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (toCredCardDebt > 0) {
                                      setState(() {
                                        widget.creditCardDebt += 10;
                                        widget.checkingAccountBalance += 10;
                                        toCredCardDebt -= 10;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 70 * widget.screenHeightUnit,
                                    height: 70 * widget.screenHeightUnit,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(79, 195, 247, 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        size: widget.screenHeightUnit * 60,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: widget.screenWidthUnit * 40),
                                  child: Container(
                                      width: widget.screenWidthUnit * 120,
                                      child: Center(
                                          child: Text(
                                        "+$toCredCardDebt",
                                        style: GoogleFonts.baloo2(
                                          fontSize:
                                              widget.screenHeightUnit * 62,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(72, 209, 38, 1),
                                        ),
                                      ))),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (widget.checkingAccountBalance > 0) {
                                      setState(() {
                                        toCredCardDebt += 10;
                                        widget.checkingAccountBalance -= 10;
                                        widget.creditCardDebt -= 10;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 70 * widget.screenHeightUnit,
                                    height: 70 * widget.screenHeightUnit,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(79, 195, 247, 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size: widget.screenHeightUnit * 60,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        width: widget.screenWidthUnit * 10,
                      ),
                      Container(
                        height: widget.screenHeightUnit * 135,
                        width: widget.screenWidthUnit * 515,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                    widget.onConfirm(
                                    toSavings,
                                    toChecking,
                                    toChecking >=0? widget.checkingAccountBalance : widget.checkingAccountBalance + toChecking , 
                                    rentSpentNow,
                                    groceriesSpentNow,
                                    travelSpentNow,
                                    utilitiesSpentNow,
                                    toFitness,
                                    toEntertainment,
                                    toCredCardDebt,
                                    
                                    );
                                     Navigator.of(context).pop();
                                    
                                 
                                },
                                child: Container(
                                    height: widget.screenHeightUnit * 65,
                                    width: widget.screenWidthUnit * 210,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(72, 209, 38, 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Confirm",
                                        style: GoogleFonts.baloo2(
                                          fontSize: widget.screenWidthUnit * 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: widget.screenWidthUnit * 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                    height: widget.screenHeightUnit * 65,
                                    width: widget.screenWidthUnit * 210,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(241, 75, 75, 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.baloo2(
                                          fontSize: widget.screenWidthUnit * 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))
        : Container(
            color: Colors.white,
            height: widget.screenHeightUnit * 900,
            width: widget.screenWidthUnit * 1091,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: widget.screenHeightUnit * 45),
                  child: Center(
                    child: Text(
                      "Fund Allocation",
                      style: GoogleFonts.baloo2(
                        fontSize: widget.screenWidthUnit * 45,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: widget.screenHeightUnit * 15,
                    left: widget.screenWidthUnit * 145,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Remaining Funds",
                        style: GoogleFonts.baloo2(
                          fontSize: widget.screenWidthUnit * 45,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: widget.screenWidthUnit * 100,
                      ),
                      Text(
                        "$widget.creditCardDebt",
                        style: GoogleFonts.baloo2(
                          fontSize: widget.screenWidthUnit * 45,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: widget.screenHeightUnit * 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(widget.types.length, (i) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: widget.screenHeightUnit * 10,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: widget.screenWidthUnit * 410,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    widget.types[i],
                                    style: GoogleFonts.baloo2(
                                      fontSize: widget.screenWidthUnit * 45,
                                      fontWeight: FontWeight.w600,
                                      color: colors[i % colors.length],
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: widget.screenWidthUnit * 84,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (prices[i] > 0) {
                                    setState(() {
                                      prices[i] -= 10;
                                      widget.creditCardDebt += 10;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 49 * widget.screenHeightUnit,
                                  height: 49 * widget.screenHeightUnit,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(79, 195, 247, 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      size: widget.screenWidthUnit * 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: widget.screenWidthUnit * 52,
                              ),
                              Container(
                                width: widget.screenWidthUnit * 104,
                                child: Center(
                                  child: Text(
                                    "${prices[i]}",
                                    style: GoogleFonts.baloo2(
                                      fontSize: widget.screenWidthUnit * 45,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: widget.screenWidthUnit * 52,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    prices[i] += 10;
                                    widget.creditCardDebt -= 10;
                                  });
                                },
                                child: Container(
                                  width: 49 * widget.screenHeightUnit,
                                  height: 49 * widget.screenHeightUnit,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(79, 195, 247, 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      size: widget.screenWidthUnit * 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: widget.screenHeightUnit * 82),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              height: widget.screenHeightUnit * 80,
                              width: widget.screenWidthUnit * 300,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(72, 209, 38, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Confirm",
                                  style: GoogleFonts.baloo2(
                                    fontSize: widget.screenWidthUnit * 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          width: widget.screenWidthUnit * 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              height: widget.screenHeightUnit * 85,
                              width: widget.screenWidthUnit * 300,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(241, 75, 75, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.baloo2(
                                    fontSize: widget.screenWidthUnit * 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

class RequiredMeter extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final String type;
  int spent;
  int outOf;
  int spentNow;
  Function onTapAdd;
  Function onTapSub;

  RequiredMeter({
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.type,
    required this.outOf,
    required this.spent,
    required this.spentNow,
    required this.onTapAdd,
    required this.onTapSub
  });

  @override
  _RequiredMeterState createState() => _RequiredMeterState();
}

class _RequiredMeterState extends State<RequiredMeter> {
  int currentPayments = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.type,
                  style: GoogleFonts.baloo2(
                      fontSize: widget.screenHeightUnit * 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  width: widget.screenWidthUnit * 8,
                ),
                Padding(
                  padding: EdgeInsets.only(top: widget.screenHeightUnit * 10),
                  child: Text(
                    "\$${widget.spent}/${widget.outOf}",
                    style: GoogleFonts.baloo2(
                        fontSize: widget.screenHeightUnit * 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: widget.screenHeightUnit * 5,
            ),
            Stack(
              children: [
                Container(
                  width: widget.screenWidthUnit * 300,
                  height: widget.screenHeightUnit * 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(216, 216, 216, 1),
                  ),
                ),
                Container(
                  width: widget.screenWidthUnit *
                      300 *
                      (widget.outOf > 0
                          ? (widget.spent / widget.outOf).clamp(0.0, 1.0)
                          : 0.0),
                  height: widget.screenHeightUnit * 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(251, 176, 59, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: widget.screenWidthUnit * 75,
              top: widget.screenHeightUnit * 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  
                    widget.onTapSub();
                    
                  
                  
                  
                },
                child: Container(
                  width: 50 * widget.screenHeightUnit,
                  height: 50 * widget.screenHeightUnit,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(79, 195, 247, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.remove,
                      size: widget.screenHeightUnit * 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: widget.screenHeightUnit * 0),
                  child: Container(
                    width: widget.screenWidthUnit * 140,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "\+${widget.spentNow}",
                        style: GoogleFonts.baloo2(
                          fontSize: widget.screenHeightUnit * 38,
                          color: Color.fromRGBO(30, 213, 58, 1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  widget.onTapAdd();
                },
                child: Container(
                  width: 50 * widget.screenHeightUnit,
                  height: 50 * widget.screenHeightUnit,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(79, 195, 247, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: widget.screenHeightUnit * 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
