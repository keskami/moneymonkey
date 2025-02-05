import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Pages/budgetSimulator.dart';

class Expenselabel extends StatelessWidget {
  final Expense expense;
  final double screenWidthUnit;
  final double screenHeightUnit;

  Expenselabel(
      {Key? key,
      required this.expense,
      required this.screenWidthUnit,
      required this.screenHeightUnit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return expense.name == "Pay Day"
        ? Container(
            height: screenHeightUnit * 45,
            width: screenWidthUnit * 200,
            margin: EdgeInsets.only(bottom: 0 * screenHeightUnit),
            padding: EdgeInsets.symmetric(
                horizontal: 15 * screenWidthUnit,
                vertical: 2 * screenHeightUnit),
            decoration: BoxDecoration(
              color: Color.fromRGBO(185, 255, 203, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "Pay Day!",
              style: GoogleFonts.baloo2(
                color: Color.fromRGBO(30, 213, 58, 1),
                fontSize: screenWidthUnit * 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        : expense.name == "Rent" ?
        
        Container(
            height: screenHeightUnit * 45,
            width: screenWidthUnit * 200,
            margin: EdgeInsets.only(bottom: 0 * screenHeightUnit),
            padding: EdgeInsets.symmetric(
                horizontal: 15 * screenWidthUnit,
                vertical: 2 * screenHeightUnit),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 204, 229, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "Rent Due",
              style: GoogleFonts.baloo2(
                color: Color.fromRGBO(236, 72, 135, 1),
                fontSize: screenWidthUnit * 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ) : expense.name == "CC Debt" ?
        
        Container(
            height: screenHeightUnit * 45,
            width: screenWidthUnit * 200,
            margin: EdgeInsets.only(bottom: 0 * screenHeightUnit),
            padding: EdgeInsets.symmetric(
                horizontal: 15 * screenWidthUnit,
                vertical: 2 * screenHeightUnit),
            decoration: BoxDecoration(
              color: Color.fromRGBO(148, 189, 255, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "CC Min. Due",
              style: GoogleFonts.baloo2(
                color: Color.fromRGBO(35, 102, 210, 1),
                fontSize: screenWidthUnit * 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ) : expense.name == "Utilites" ?
        
        Container(
            height: screenHeightUnit * 45,
            width: screenWidthUnit * 200,
            margin: EdgeInsets.only(bottom: 0 * screenHeightUnit),
            padding: EdgeInsets.symmetric(
                horizontal: 15 * screenWidthUnit,
                vertical: 2 * screenHeightUnit),
            decoration: BoxDecoration(
              color: Color.fromRGBO(79, 195, 247, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "Utilities Due",
              style: GoogleFonts.baloo2(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: screenWidthUnit * 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ) : Container();
  }
}
