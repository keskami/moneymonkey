import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Pages/budgetSimulator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Bottomwarning extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  Expense nextExpense;
  final List<Hint> hints;
  final int dayNumber;
  DateTime baseDate;

  Bottomwarning(
      {required this.screenHeightUnit,
      required this.screenWidthUnit,
      this.hints = const [],
      required this.nextExpense,
      required this.dayNumber,
      required this.baseDate});

  // color:
  //                                             Color.fromRGBO(135, 218, 255, 1),
  //                                         text:
  //                                             "Hint: Consider reducing entertainment spendings to boost your savings. ",
  //                                         textColor:
  //                                             Color.fromRGBO(32, 84, 116, 1),

  @override
  _BottomwarningtState createState() => _BottomwarningtState();
}

class _BottomwarningtState extends State<Bottomwarning> {
  @override
  Widget build(BuildContext context) {
    return widget.hints.length == 0
        ? Container(
            height: 90 * widget.screenHeightUnit,
            width: 1290 * widget.screenWidthUnit,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 25 * widget.screenWidthUnit,
                    right: 15 * widget.screenWidthUnit,
                  ),
                  child: Container(
                    height: 65 * widget.screenHeightUnit,
                    width: 65 * widget.screenWidthUnit,
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fcalendar%201.png?alt=media&token=9c7296fa-006a-4cf1-aca1-f6494d3c3641'),
                  ),
                ),
                Text(
                  "Day ${widget.dayNumber}",
                  style: GoogleFonts.baloo2(
                    fontSize: 34 * widget.screenHeightUnit,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 45 * widget.screenWidthUnit,
                ),
                Container(
                  height: 65 * widget.screenHeightUnit,
                  width: 65 * widget.screenWidthUnit,
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Falert%201.png?alt=media&token=5b3359d4-1d67-4c9d-9613-e0add0fe9d38'),
                ),
                SizedBox(
                  width: 20 * widget.screenWidthUnit,
                ),
                widget.nextExpense.name == ""
                    ? Text(
                        "No More Required Payments This Month",
                        style: GoogleFonts.baloo2(
                          fontSize: 34 * widget.screenHeightUnit,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : Text(
                        widget.nextExpense.dueDay
                                    .difference(widget.baseDate)
                                    .inDays ==
                                0
                            ? "Next Required Payment | ${widget.nextExpense.name} Due Today"
                            : widget.nextExpense.dueDay
                                        .difference(widget.baseDate)
                                        .inDays ==
                                    1
                                ? "Next Required Payment | ${widget.nextExpense.name} Due in ${widget.nextExpense.dueDay.difference(widget.baseDate).inDays} day"
                                : "Next Required Payment | ${widget.nextExpense.name} Due in ${widget.nextExpense.dueDay.difference(widget.baseDate).inDays} days",
                        style: GoogleFonts.baloo2(
                          fontSize: 34 * widget.screenHeightUnit,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 30 * widget.screenWidthUnit),
                  child: Container(
                    height: 65 * widget.screenHeightUnit,
                    width: 65 * widget.screenWidthUnit,
                    child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLogo2%20(1)%202.png?alt=media&token=a572c91c-6624-4e57-87d0-c1362cc6dd8e"),
                  ),
                )
              ],
            ),
          )
        : Container(
            height: 90 * widget.screenHeightUnit,
            width: 1290 * widget.screenWidthUnit,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 30 * widget.screenWidthUnit,
                  top: 21 * widget.screenHeightUnit),
              child: Text(
                "Hint: Consider reducing entertainment spendings to boost your savings. ",
                style: GoogleFonts.baloo2(
                  fontSize: 34 * widget.screenHeightUnit,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
  }
}
