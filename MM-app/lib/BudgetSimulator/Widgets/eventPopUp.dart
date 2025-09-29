import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Pages/budgetSimulator.dart';

class EventPopUp extends StatefulWidget {
  final Expense expense;
  final Function onTouch;

  EventPopUp({required this.expense, required this.onTouch});

  @override
  _EventPopUpState createState() => _EventPopUpState();
}

class _EventPopUpState extends State<EventPopUp> {
  @override
  Widget build(BuildContext context) {
    double screenHeightUnit = MediaQuery.of(context).size.height / 1080;
    double screenWidthUnit = MediaQuery.of(context).size.width / 1920;
    return widget.expense.name == "Pay Day"
        ? Center(
            child: Container(
                height: screenHeightUnit * 646,
                width: screenWidthUnit * 857,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeightUnit * 30),
                    Text(
                      "Event!",
                      style: GoogleFonts.baloo2(
                          fontSize: screenWidthUnit * 45,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: screenHeightUnit * 0),
                    Container(
                        width: screenWidthUnit * 380,
                        height: screenHeightUnit * 320,
                        child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGreenUpArrows.png?alt=media&token=d2ce3295-e98e-4cca-8b72-ce8756dbed31")),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.baloo2(
                          fontSize: screenWidthUnit * 20,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: "You have received\nyour pay day check for ",
                            style: TextStyle(
                                color: Color.fromRGBO(108, 108, 108, 1)),
                          ),
                          TextSpan(
                            text: "\$${-widget.expense.amount}",
                            style: TextStyle(
                                color: Color.fromRGBO(30, 213, 58, 1)),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                        padding: EdgeInsets.only(bottom: screenHeightUnit * 45),
                        child: GestureDetector(
                          onTap: () {
                            widget.onTouch();
                          },
                          child: Container(
                            height: screenHeightUnit * 73,
                            width: screenWidthUnit * 307,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(79, 195, 247, 1),
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                              child: Text(
                                "Continue",
                                style: GoogleFonts.baloo2(
                                    fontSize: screenWidthUnit * 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ))
                  ],
                )),
          )
        : widget.expense.name == "Rent" ||  widget.expense.name =="Utilities" || widget.expense.name == "Groceries" ||  widget.expense.name =="Transportation"
            ? Center(
                child: Container(
                    height: screenHeightUnit * 646,
                    width: screenWidthUnit * 857,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeightUnit * 15),
                        Text(
                          "Event!",
                          style: GoogleFonts.baloo2(
                              fontSize: screenWidthUnit * 45,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: screenHeightUnit * 0),
                        Container(
                            width: screenWidthUnit * 300,
                            height: screenHeightUnit * 260,
                            child: widget.expense.amountPaid <
                                    widget.expense.amount
                                ? Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FdownArrows.png?alt=media&token=0d61a19e-0583-414e-a9dd-50e1e85bf57f")
                                : Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGreenUpArrows.png?alt=media&token=d2ce3295-e98e-4cca-8b72-ce8756dbed31")),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.baloo2(
                              fontSize: screenWidthUnit * 20,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "Your ${widget.expense.name} was due for\n",
                                style: TextStyle(
                                    color: Color.fromRGBO(108, 108, 108, 1)),
                              ),
                              TextSpan(
                                text: "\$${widget.expense.amount}",
                                style: TextStyle(
                                    color: widget.expense.amountPaid >=
                                            widget.expense.amount
                                        ? Color.fromRGBO(108, 108, 108, 1)
                                        : Color.fromRGBO(243, 52, 52, 1)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeightUnit * 2,
                        ),
                        widget.expense.amountPaid >= widget.expense.amount
                            ? Text(
                                "You paid your ${widget.expense.name} on time\n and incurred no penalty",
                                style: GoogleFonts.baloo2(
                                    fontSize: screenWidthUnit * 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(108, 108, 108, 1)),
                                textAlign: TextAlign.center,
                              )
                            : RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: GoogleFonts.baloo2(
                                    fontSize: screenWidthUnit * 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "You did not pay your ${widget.expense.name} on time\nand owe penalty of ",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(108, 108, 108, 1)),
                                    ),
                                    TextSpan(
                                      text: "\$${widget.expense.penalty}",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(243, 52, 52, 1)),
                                    ),
                                  ],
                                ),
                              ),
                        Spacer(),
                        Padding(
                            padding:
                                EdgeInsets.only(bottom: screenHeightUnit * 45),
                            child: GestureDetector(
                              onTap: () {
                                widget.onTouch();
                              },
                              child: Container(
                                height: screenHeightUnit * 73,
                                width: screenWidthUnit * 307,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(79, 195, 247, 1),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Center(
                                  child: Text(
                                    "Continue",
                                    style: GoogleFonts.baloo2(
                                        fontSize: screenWidthUnit * 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    )),
              )
            : widget.expense.name == "CC Debt"
            ? Center(
                child: Container(
                    height: screenHeightUnit * 646,
                    width: screenWidthUnit * 857,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeightUnit * 15),
                        Text(
                          "Event!",
                          style: GoogleFonts.baloo2(
                              fontSize: screenWidthUnit * 45,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: screenHeightUnit * 0),
                        Container(
                            width: screenWidthUnit * 300,
                            height: screenHeightUnit * 260,
                            child: widget.expense.amountPaid <
                                    widget.expense.amount
                                ? Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FdownArrows.png?alt=media&token=0d61a19e-0583-414e-a9dd-50e1e85bf57f")
                                : Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FGreenUpArrows.png?alt=media&token=d2ce3295-e98e-4cca-8b72-ce8756dbed31")),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.baloo2(
                              fontSize: screenWidthUnit * 20,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "Your credit card minimum was due for\n",
                                style: TextStyle(
                                    color: Color.fromRGBO(108, 108, 108, 1)),
                              ),
                              TextSpan(
                                text: "\$${widget.expense.amount}",
                                style: TextStyle(
                                    color: widget.expense.amountPaid >=
                                            widget.expense.amount
                                        ? Color.fromRGBO(108, 108, 108, 1)
                                        : Color.fromRGBO(243, 52, 52, 1)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeightUnit * 2,
                        ),
                        widget.expense.amountPaid >= widget.expense.amount
                            ? Text(
                                "You paid your minimum on time\n and incurred no penalty",
                                style: GoogleFonts.baloo2(
                                    fontSize: screenWidthUnit * 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(108, 108, 108, 1)),
                                textAlign: TextAlign.center,
                              )
                            : RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: GoogleFonts.baloo2(
                                    fontSize: screenWidthUnit * 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "You did not pay your minimum on time\nand owe penalty of ",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(108, 108, 108, 1)),
                                    ),
                                    TextSpan(
                                      text: "\$${widget.expense.penalty}",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(243, 52, 52, 1)),
                                    ),
                                  ],
                                ),
                              ),
                        Spacer(),
                        Padding(
                            padding:
                                EdgeInsets.only(bottom: screenHeightUnit * 45),
                            child: GestureDetector(
                              onTap: () {
                                widget.onTouch();
                              },
                              child: Container(
                                height: screenHeightUnit * 73,
                                width: screenWidthUnit * 307,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(79, 195, 247, 1),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Center(
                                  child: Text(
                                    "Continue",
                                    style: GoogleFonts.baloo2(
                                        fontSize: screenWidthUnit * 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    )),
              )
            : Container();
  }
}
