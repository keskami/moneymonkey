import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/lightBlueInfo.dart';

class StudentLoansScreen extends StatefulWidget {
  final double screenWidthUnit;
  final double screenHeightUnit;
  final StudentLoan studentLoan;
  final double studentLoanDebt;
  final Function? onClick;

  const StudentLoansScreen({
    Key? key,
    required this.screenWidthUnit,
    required this.screenHeightUnit,
    required this.studentLoan,
    required this.studentLoanDebt,
    required this.onClick,
  }) : super(key: key);

  @override
  _StudentLoansScreenState createState() => _StudentLoansScreenState();
}

class _StudentLoansScreenState extends State<StudentLoansScreen> {
  bool isSwitched = false;

  StudentLoan studentLoanStandard = StudentLoan(
    name: "Standard Repayment Plan",
    interestRate: 5,
    monthlyPayment: 250,
    monthsLeft: 120,
  );
  StudentLoan studentLoanExtended = StudentLoan(
    name: "Extended Repayment Plan",
    interestRate: 5.5,
    monthlyPayment: 150,
    monthsLeft: 180,
  );

  late StudentLoan option1;

  @override
  void initState() {
    super.initState();
    if(widget.studentLoan.name == "Standard Repayment Plan"){
      setState(() {
        option1 = studentLoanExtended;
      });

    }else{
      option1 = studentLoanStandard;
    }
  }



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
                  height: widget.screenHeightUnit * 520,
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
                        vertical: widget.screenHeightUnit * 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: widget.screenWidthUnit * 70,
                              height: widget.screenHeightUnit * 70,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(216, 216, 216, .4),
                                backgroundBlendMode: BlendMode.darken,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.monetization_on,
                                  color: Colors.black,
                                  size: widget.screenWidthUnit * 32,
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
                            amount: "\$${widget.studentLoanDebt}",
                            big: true),
                        SizedBox(
                          height: widget.screenHeightUnit * 15,
                        ),
                        LightBlueInfo(
                            screenHeightUnit: widget.screenHeightUnit,
                            screenWidthUnit: widget.screenWidthUnit,
                            name: "Interest Rate",
                            amount: "${widget.studentLoan.interestRate}%",
                            big: true),
                        SizedBox(
                          height: widget.screenHeightUnit * 15,
                        ),
                        LightBlueInfo(
                            screenHeightUnit: widget.screenHeightUnit,
                            screenWidthUnit: widget.screenWidthUnit,
                            name: "Monthly Payment",
                            amount: "\$${widget.studentLoan.monthlyPayment}",
                            big: true),
                        SizedBox(
                          height: widget.screenHeightUnit * 15,
                        ),
                        LightBlueInfo(
                            screenHeightUnit: widget.screenHeightUnit,
                            screenWidthUnit: widget.screenWidthUnit,
                            name: "Term",
                            amount: widget.studentLoan.monthsLeft > 36
                                ? "${(widget.studentLoan.monthsLeft / 12).toStringAsFixed(0)} Years"
                                : "${widget.studentLoan.monthsLeft} Months",
                            big: true)
                      ],
                    ),
                  )),
              SizedBox(width: widget.screenWidthUnit * 10),
              Container(
                  height: widget.screenHeightUnit * 520,
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
                              width: widget.screenWidthUnit * 70,
                              height: widget.screenHeightUnit * 70,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(216, 216, 216, .4),
                                backgroundBlendMode: BlendMode.darken,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.speed,
                                  color: Colors.black,
                                  size: widget.screenWidthUnit * 32,
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
                                    "\$${widget.studentLoan.monthlyPayment}",
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
                                    "\$${4200 - widget.studentLoan.monthlyPayment}",
                                    style: GoogleFonts.baloo2(
                                        fontSize: widget.screenHeightUnit * 32,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(0, 199, 129, 1)),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: widget.screenHeightUnit * 35,
          ),
          Container(
              width: widget.screenWidthUnit * 1210,
              height: widget.screenHeightUnit * 115,
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
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widget.screenWidthUnit * 70,
                        height: widget.screenHeightUnit * 70,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(216, 216, 216, .4),
                          backgroundBlendMode: BlendMode.darken,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.tune,
                            color: Colors.black,
                            size: widget.screenWidthUnit * 32,
                          ),
                        ),
                      ),
                      SizedBox(width: widget.screenWidthUnit * 20),
                      Text(
                        "Try Other Repayment Plans",
                        style: GoogleFonts.baloo2(
                          fontSize: widget.screenHeightUnit * 35,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeColor: Colors.white,
                        activeTrackColor: Color.fromRGBO(0, 127, 255, 1),
                      )
                    ],
                  ))),
          SizedBox(
            height: widget.screenHeightUnit * 30,
          ),
          isSwitched
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: widget.screenHeightUnit * 520,
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
                        padding: EdgeInsets.only(
                          left: widget.screenWidthUnit * 30,
                          top: widget.screenHeightUnit * 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option1.name,
                              style: GoogleFonts.baloo2(
                                fontSize: widget.screenHeightUnit * 35,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: widget.screenHeightUnit * 15,
                            ),
                            Container(
                                height: widget.screenHeightUnit * 320,
                                width: widget.screenWidthUnit * 540,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color.fromRGBO(106, 114, 128, 1),
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: widget.screenWidthUnit * 25),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Payment:",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 30,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  0, 127, 255, 1),
                                            ),
                                          ),
                                          Text(
                                            "\$${option1.monthlyPayment}",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 34,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Interest Rate:",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 30,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  0, 127, 255, 1),
                                            ),
                                          ),
                                          Text(
                                            "${option1.interestRate}%",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 34,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Term",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 30,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  0, 127, 255, 1),
                                            ),
                                          ),
                                          Text(
                                            option1.monthsLeft > 36
                                                ? "${(option1.monthsLeft / 12).toStringAsFixed(0)} Years"
                                                : "${option1.monthsLeft} Months",

                                            
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 34,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Remaining:",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 30,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  0, 127, 255, 1),
                                            ),
                                          ),
                                          Text(
                                            "\$${4200-option1.monthlyPayment}",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 34,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  0, 199, 129, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: widget.screenHeightUnit * 20,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    right: widget.screenWidthUnit * 30),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                     
                                      widget.onClick!(option1);
                                       if(option1.name == "Standard Repayment Plan"){
                                        setState(() {
                                          option1 = studentLoanExtended;
                                        });
                                      }else{
                                        setState(() {
                                          option1 = studentLoanStandard;
                                        });
                                      }

                                    },
                                    child: Container(
                                      width: widget.screenWidthUnit * 200,
                                      height: widget.screenHeightUnit * 65,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(0, 127, 255, 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Choose This Plan",
                                          style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 30,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: widget.screenWidthUnit * 10),
                    Container(
                      height: widget.screenHeightUnit * 520,
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
                        padding: EdgeInsets.only(
                          left: widget.screenWidthUnit * 30,
                          top: widget.screenHeightUnit * 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option1.name,
                              style: GoogleFonts.baloo2(
                                fontSize: widget.screenHeightUnit * 35,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: widget.screenHeightUnit * 15,
                            ),
                            Container(
                                height: widget.screenHeightUnit * 320,
                                width: widget.screenWidthUnit * 540,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color.fromRGBO(106, 114, 128, 1),
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: widget.screenWidthUnit * 25),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Payment:",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 30,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  0, 127, 255, 1),
                                            ),
                                          ),
                                          Text(
                                            "\$${option1.monthlyPayment}",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 34,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Interest Rate:",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 30,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  0, 127, 255, 1),
                                            ),
                                          ),
                                          Text(
                                            "${option1.interestRate}%",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 34,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Term",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 30,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  0, 127, 255, 1),
                                            ),
                                          ),
                                          Text(
                                            option1.monthsLeft > 36
                                                ? "${(option1.monthsLeft / 12).toStringAsFixed(0)} Years"
                                                : "${option1.monthsLeft} Months",

                                            
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 34,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Remaining:",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 30,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  0, 127, 255, 1),
                                            ),
                                          ),
                                          Text(
                                            "\$${4200-option1.monthlyPayment}",
                                            style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 34,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  0, 199, 129, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: widget.screenHeightUnit * 20,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    right: widget.screenWidthUnit * 30),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                     
                                      widget.onClick!(option1);
                                       if(option1.name == "Standard Repayment Plan"){
                                        setState(() {
                                          option1 = studentLoanExtended;
                                        });
                                      }else{
                                        setState(() {
                                          option1 = studentLoanStandard;
                                        });
                                      }

                                    },
                                    child: Container(
                                      width: widget.screenWidthUnit * 200,
                                      height: widget.screenHeightUnit * 65,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(0, 127, 255, 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Choose This Plan",
                                          style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 30,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
