import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/bottomHint.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/tableCalender.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/weekdayRow.dart';

class CrushTheCreditCardDebtPages extends StatefulWidget {
  final double screenWidthUnit;
  final double screenHeightUnit;
  final String currentChoice;
  final Function(String) onOptionSelected;
  final dynamic widget;
  final String formattedDate;
  final bool smallBoxes;

  const CrushTheCreditCardDebtPages({
    super.key,
    required this.screenWidthUnit,
    required this.screenHeightUnit,
    required this.currentChoice,
    required this.onOptionSelected,
    required this.widget,
    required this.formattedDate,
    required this.smallBoxes,
  });

  @override
  _CrushTheCreditCardDebtPagesState createState() =>
      _CrushTheCreditCardDebtPagesState();
}

class _CrushTheCreditCardDebtPagesState
    extends State<CrushTheCreditCardDebtPages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeightUnit * 60,
      width: widget.screenWidthUnit * 1370,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: widget.screenHeightUnit * 85,
                height: widget.screenHeightUnit * 1,
                color: Colors.black,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.onOptionSelected("Calendar");
                    },
                    child: Text(
                      "Calendar",
                      style: GoogleFonts.baloo2(
                        fontSize: widget.screenWidthUnit * 20,
                        fontWeight: FontWeight.w600,
                        color: widget.currentChoice == "Calendar"
                            ? const Color.fromRGBO(0, 127, 255, 1)
                            : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: widget.screenHeightUnit * 6),
                  Container(
                    width: widget.screenHeightUnit * 120,
                    height: widget.screenHeightUnit * 1,
                    color: widget.currentChoice == "Calendar"
                        ? const Color.fromRGBO(0, 127, 255, 1)
                        : Colors.black,
                  ),
                ],
              ),
              Container(
                width: widget.screenHeightUnit * 85,
                height: widget.screenHeightUnit * 1,
                color: Colors.black,
              ),
              GestureDetector(
                onTap: () {
                  widget.onOptionSelected("Credit Management");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Credit Management",
                      style: GoogleFonts.baloo2(
                        fontSize: widget.screenWidthUnit * 20,
                        fontWeight: FontWeight.w600,
                        color: widget.currentChoice == "Credit Management"
                            ? const Color.fromRGBO(0, 127, 255, 1)
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: widget.screenHeightUnit * 6),
                    Container(
                      width: widget.screenHeightUnit * 270,
                      height: widget.screenHeightUnit * 1,
                      color: widget.currentChoice == "Credit Management"
                          ? const Color.fromRGBO(0, 127, 255, 1)
                          : Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                width: widget.screenHeightUnit * 85,
                height: widget.screenHeightUnit * 1,
                color: Colors.black,
              ),
              GestureDetector(
                onTap: () {
                  widget.onOptionSelected("Accounts");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Accounts",
                      style: GoogleFonts.baloo2(
                        fontSize: widget.screenWidthUnit * 20,
                        fontWeight: FontWeight.w600,
                        color: widget.currentChoice == "Accounts"
                            ? const Color.fromRGBO(0, 127, 255, 1)
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: widget.screenHeightUnit * 6),
                    Container(
                      width: widget.screenHeightUnit * 160,
                      height: widget.screenHeightUnit * 1,
                      color: widget.currentChoice == "Accounts"
                          ? const Color.fromRGBO(0, 127, 255, 1)
                          : Colors.black,
                    ),
                  ],
                ),
              ),
               Container(
                width: widget.screenHeightUnit * 85,
                height: widget.screenHeightUnit * 1,
                color: Colors.black,
              ),
              GestureDetector(
                onTap: () {
                  widget.onOptionSelected("Overall Score");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Overall Score",
                      style: GoogleFonts.baloo2(
                        fontSize: widget.screenWidthUnit * 20,
                        fontWeight: FontWeight.w600,
                        color: widget.currentChoice == "Overall Score"
                            ? const Color.fromRGBO(0, 127, 255, 1)
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: widget.screenHeightUnit * 6),
                    Container(
                      width: widget.screenHeightUnit * 190,
                      height: widget.screenHeightUnit * 1,
                      color: widget.currentChoice == "Overall Score"
                          ? const Color.fromRGBO(0, 127, 255, 1)
                          : Colors.black,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: widget.screenHeightUnit * 1,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
