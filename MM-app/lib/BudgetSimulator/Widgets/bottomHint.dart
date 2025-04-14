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
  Function close;

  Bottomwarning(
      {required this.screenHeightUnit,
      required this.screenWidthUnit,
      this.hints = const [],
      required this.nextExpense,
      required this.dayNumber,
      required this.baseDate,
      required this.close});

  @override
  _BottomwarningtState createState() => _BottomwarningtState();

  Color goodBack = Color.fromRGBO(243, 249, 255, 1);
  Color goodText = Color.fromRGBO(0, 127, 255, 1);
  Color badText = Color.fromRGBO(255, 0, 0, 1);
  Color backBack = Color.fromRGBO(255, 243, 243, .7);
}

class _BottomwarningtState extends State<Bottomwarning> {
  @override
  Widget build(BuildContext context) {
    return widget.hints.length == 0
        ? Container(
            height: 110 * widget.screenHeightUnit,
            width: 1290 * widget.screenWidthUnit,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: .6,
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
                    height: 75 * widget.screenHeightUnit,
                    width: 75 * widget.screenWidthUnit,
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fcalendar%201.png?alt=media&token=9c7296fa-006a-4cf1-aca1-f6494d3c3641'),
                  ),
                ),
                Text(
                  "Day ${widget.dayNumber}",
                  style: GoogleFonts.baloo2(
                    fontSize: 28 * widget.screenWidthUnit,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 45 * widget.screenWidthUnit,
                ),
                Container(
                  height: 75 * widget.screenHeightUnit,
                  width: 75 * widget.screenWidthUnit,
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Falert%201.png?alt=media&token=5b3359d4-1d67-4c9d-9613-e0add0fe9d38'),
                ),
                SizedBox(
                  width: 20 * widget.screenWidthUnit,
                ),
                widget.nextExpense.dueDay.year > 2025 == ""
                    ? Text(
                        "No More Required Payments This Month",
                        style: GoogleFonts.baloo2(
                          fontSize: 28 * widget.screenWidthUnit,
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
                                : widget.nextExpense.dueDay
                                            .difference(widget.baseDate)
                                            .inDays >
                                        35
                                    ? "No More Required Payments This Month"
                                    : "Next Required Payment | ${widget.nextExpense.name} Due in ${widget.nextExpense.dueDay.difference(widget.baseDate).inDays} days",
                        style: GoogleFonts.baloo2(
                          fontSize: 28 * widget.screenWidthUnit,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 30 * widget.screenWidthUnit),
                  child: Container(
                    height: 75 * widget.screenHeightUnit,
                    width: 75 * widget.screenWidthUnit,
                    child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLogo2%20(1)%202.png?alt=media&token=a572c91c-6624-4e57-87d0-c1362cc6dd8e"),
                  ),
                )
              ],
            ),
          )
        : widget.hints.length == 1
            ? Container(
                height: 110 * widget.screenHeightUnit,
                width: 1290 * widget.screenWidthUnit,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.hints[0].good
                      ? widget.goodBack
                      : widget.backBack,
                       border: Border.all(
                              color: widget.hints[0].good
                            ? widget.goodText: widget.badText,
                            width: .6,
                            )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20 * widget.screenWidthUnit,
                          top: 4 * widget.screenHeightUnit),
                      child: Text(
                        widget.hints[0].text,
                        style: GoogleFonts.baloo2(
                          fontSize: 27 * widget.screenWidthUnit,
                          color: widget.hints[0].good
                              ? widget.goodText
                              : widget.badText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 20 * widget.screenWidthUnit,
                          top: 4 * widget.screenHeightUnit),
                      child: GestureDetector(
                          onTap: () {
                            widget.close();
                          },
                          child: Icon(
                            Icons.close,
                            size: 60 * widget.screenHeightUnit,
                            color: widget.hints[0].good
                                ? widget.goodText
                              : widget.badText,
                          )),
                    )
                  ],
                ))
            : Container(
                height: 110 * widget.screenHeightUnit,
                width: 1290 * widget.screenWidthUnit,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 110 * widget.screenHeightUnit,
                      width: 1085 * widget.screenWidthUnit,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.hints[0].good
                            ? widget.goodBack : widget.backBack,
                           border: Border.all(
                              color: widget.hints[0].good
                            ? widget.goodText: widget.badText,
                            width: .6,
                            )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20 * widget.screenWidthUnit,
                                top: 4 * widget.screenHeightUnit),
                            child: Text(
                              widget.hints[0].text,
                              style: GoogleFonts.baloo2(
                                fontSize: 20 * widget.screenWidthUnit,
                                color: widget.hints[0].good
                                    ? widget.goodText
                              : widget.badText,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 15 * widget.screenWidthUnit,
                                top: 4 * widget.screenHeightUnit),
                            child: GestureDetector(
                                onTap: () {
                                  widget.close();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 60 * widget.screenHeightUnit,
                                  color: widget.hints[0].good
                                      ? widget.goodText
                              : widget.badText,
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15 * widget.screenWidthUnit,
                    ),
                    Container(
                      height: 110 * widget.screenHeightUnit,
                      width: 190 * widget.screenWidthUnit,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: widget.hints[0].good
                            ? widget.goodBack: widget.backBack,
                            border: Border.all(
                              color: widget.hints[0].good
                            ? widget.goodText: widget.badText,
                            width: .6,
                            )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10 * widget.screenHeightUnit,
                              left: widget.screenWidthUnit * 15,
                              right: widget.screenWidthUnit * 10,
                            ),
                            child: Text(
                              "${widget.hints.length}",
                              style: GoogleFonts.baloo2(
                                fontSize: 45 * widget.screenWidthUnit,
                                color: widget.hints[0].good? widget.goodText
                              : widget.badText,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Center(
                              child: Text(
                            "hints\npending",
                            style: GoogleFonts.baloo2(
                              fontSize: 22 * widget.screenWidthUnit,
                              color: widget.hints[0].good? widget.goodText
                              : widget.badText,
                              fontWeight: FontWeight.w700,
                              height: 1, // Adjust the line spacing
                            ),
                            textAlign: TextAlign.left,
                          )),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 6 * widget.screenWidthUnit,
                                top: 4 * widget.screenHeightUnit),
                            child: GestureDetector(
                                onTap: () {
                                  widget.close();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 50 * widget.screenHeightUnit,
                                  color: widget.hints[0].good
                                      ? widget.goodText
                              : widget.badText,
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ));
  }
}
