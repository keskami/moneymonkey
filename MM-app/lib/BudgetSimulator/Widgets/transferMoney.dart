import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransferMoneyPopUp extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final dynamic widget;
  final Function setStateCallback;

  TransferMoneyPopUp({
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.widget,
    required this.setStateCallback,
  });

  @override
  _TransferMoneyPopUpState createState() => _TransferMoneyPopUpState();
}

class _TransferMoneyPopUpState extends State<TransferMoneyPopUp> {
  int toChecking = 0;
  int toSavings = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeightUnit * 600,
      width: widget.screenWidthUnit * 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Checking"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (widget.widget.checkingAccountBalance +
                                  toChecking >
                              0) {
                            setState(() {
                              toChecking -= 10;
                              toSavings += 10;
                            });
                          }
                          {}
                        },
                        child: Container(
                          width: 55 * widget.screenHeightUnit,
                          height: 55 * widget.screenHeightUnit,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(79, 195, 247, 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              size: widget.screenHeightUnit * 45,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: widget.screenWidthUnit * 0),
                        child: Container(
                          width: widget.screenWidthUnit * 120,
                          child: Center(
                            child: toChecking == 0
                                ? Text(
                                    "0",
                                    style: GoogleFonts.baloo2(
                                      fontSize: widget.screenHeightUnit * 45,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  )
                                : toChecking > 0
                                    ? Text(
                                        "+${toChecking}",
                                        style: GoogleFonts.baloo2(
                                          fontSize:
                                              widget.screenHeightUnit * 45,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(30, 213, 58, 1),
                                        ),
                                      )
                                    : Text(
                                        "${toChecking}",
                                        style: GoogleFonts.baloo2(
                                          fontSize:
                                              widget.screenHeightUnit * 45,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(243, 52, 52, 1),
                                        ),
                                      ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.widget.savingsAccountBalance + toSavings >
                              0) {
                            setState(() {
                              toChecking += 10;
                              toSavings -= 10;
                            });
                          }
                          {}
                        },
                        child: Container(
                          width: 55 * widget.screenHeightUnit,
                          height: 55 * widget.screenHeightUnit,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(79, 195, 247, 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: widget.screenHeightUnit * 45,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: widget.screenWidthUnit * 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Savings"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (widget.widget.savingsAccountBalance + toSavings >
                              0) {
                            setState(() {
                              toChecking += 10;
                              toSavings -= 10;
                            });
                          }
                          {}
                        },
                        child: Container(
                          width: 55 * widget.screenHeightUnit,
                          height: 55 * widget.screenHeightUnit,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(79, 195, 247, 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              size: widget.screenHeightUnit * 45,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: widget.screenWidthUnit * 0),
                        child: Container(
                          width: widget.screenWidthUnit * 120,
                          child: Center(
                            child: toSavings == 0
                                ? Text(
                                    "0",
                                    style: GoogleFonts.baloo2(
                                      fontSize: widget.screenHeightUnit * 45,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  )
                                : toSavings > 0
                                    ? Text(
                                        "+${toSavings}",
                                        style: GoogleFonts.baloo2(
                                          fontSize:
                                              widget.screenHeightUnit * 45,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(30, 213, 58, 1),
                                        ),
                                      )
                                    : Text(
                                        "${toSavings}",
                                        style: GoogleFonts.baloo2(
                                          fontSize:
                                              widget.screenHeightUnit * 45,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(243, 52, 52, 1),
                                        ),
                                      ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.widget.checkingAccountBalance +
                                  toChecking >
                              0) {
                            setState(() {
                              toChecking -= 10;
                              toSavings += 10;
                            });
                          }
                          {}
                        },
                        child: Container(
                          width: 55 * widget.screenHeightUnit,
                          height: 55 * widget.screenHeightUnit,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(79, 195, 247, 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: widget.screenHeightUnit * 45,
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  widget.setStateCallback(() {
                    widget.widget.checkingTransfer += toChecking;
                    widget.widget.savingsTransfer += toSavings;
                  });

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
        ],
      ),
    );
  }
}
