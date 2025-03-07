import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Pages/budgetSimulator.dart';

class Expenselabel extends StatefulWidget {
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
  _ExpenselabelState createState() => _ExpenselabelState();
}

class _ExpenselabelState extends State<Expenselabel> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExpenseContainer(),
          if (_isHovered) _buildDropdownMenu(),
        ],
      ),
    );
  }

  Widget _buildExpenseContainer() {
    return Container(
      height: widget.screenHeightUnit * 45,
      width: widget.screenWidthUnit * 200,
      margin: EdgeInsets.only(bottom: 0 * widget.screenHeightUnit),
      padding: EdgeInsets.symmetric(
          horizontal: 15 * widget.screenWidthUnit,
          vertical: 2 * widget.screenHeightUnit),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        _getLabelText(),
        style: GoogleFonts.baloo2(
          color: _getTextColor(),
          fontSize: widget.screenWidthUnit * 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDropdownMenu() {
    return Padding(
        padding: EdgeInsets.only(top: widget.screenHeightUnit * 2),
        child: Container(
          width: widget.screenWidthUnit * 200,
          height: widget.screenHeightUnit * 100,
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: widget.screenHeightUnit * 10,
                    left: widget.screenWidthUnit * 10,
                    bottom: widget.screenHeightUnit * 7),
                child: Text(
                  '${widget.expense.dueDay.month.toString().padLeft(2, '0')}/${widget.expense.dueDay.day.toString().padLeft(2, '0')}/${widget.expense.dueDay.year}',
                  style: GoogleFonts.baloo2(
                    color: Colors.black,
                    fontSize: widget.screenWidthUnit * 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: widget.screenWidthUnit * 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$${(widget.expense.amount - widget.expense.amountPaid).abs()}",
                        style: GoogleFonts.baloo2(
                          color: Colors.black,
                          fontSize: widget.screenWidthUnit * 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: widget.screenWidthUnit * 12,
                      ),
                      (widget.expense.name == "Utilities" ||
                              widget.expense.name == "Rent" || widget.expense.name == "CC Debt")
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: widget.screenHeightUnit * 10),
                              child: Container(
                                height: widget.screenHeightUnit * 35,
                                width: widget.screenWidthUnit * 80,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "\$${widget.expense.penalty}",
                                        style: GoogleFonts.baloo2(
                                          color: Color.fromRGBO(243, 52, 52, 1),
                                          fontSize: widget.screenWidthUnit * 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: widget.screenWidthUnit * 2,),
                                      Text(
                                        "Penalty",
                                        style: GoogleFonts.baloo2(
                                          color: Color.fromRGBO(243, 52, 52, 1),
                                          fontSize: widget.screenWidthUnit * 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ]),
                              ))
                          : Container()
                    ],
                  ))
            ],
          ),
        ));
  }

  Color _getBackgroundColor() {
    switch (widget.expense.name) {
      case "Pay Day":
        return Color.fromRGBO(185, 255, 203, 1);
      case "Rent":
        return Color.fromRGBO(255, 204, 229, 1);
      case "CC Debt":
        return Color.fromRGBO(148, 189, 255, 1);
      case "Utilities":
        return Color.fromRGBO(79, 195, 247, 1);
      default:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    switch (widget.expense.name) {
      case "Pay Day":
        return Color.fromRGBO(30, 213, 58, 1);
      case "Rent":
        return Color.fromRGBO(236, 72, 135, 1);
      case "CC Debt":
        return Color.fromRGBO(35, 102, 210, 1);
      case "Utilities":
        return Color.fromRGBO(255, 255, 255, 1);
      default:
        return Colors.black;
    }
  }

  String _getLabelText() {
    switch (widget.expense.name) {
      case "Pay Day":
        return "Pay Day!";
      case "Rent":
        return "Rent Due";
      case "CC Debt":
        return "CC Min. Due";
      case "Utilities":
        return "Utilities Due";
      default:
        return "";
    }
  }
}
