import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:intl/intl.dart';

class TransactionHistory extends StatefulWidget {
  final List<Transaction> Transactions;
  final double screenHeightUnit;
  final double screenWidthUnit;

  const TransactionHistory({
    Key? key,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.Transactions,
  }) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidthUnit * 517,
      height: widget.screenHeightUnit * 540,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: widget.screenHeightUnit * 24,
                left: widget.screenWidthUnit * 32),
            child: Text(
              "Accounts & Transactions",
              style: GoogleFonts.baloo2(
                  fontSize: widget.screenWidthUnit * 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: widget.screenHeightUnit * 24,
                  left: widget.screenWidthUnit * 32),
              child: Container(
                width: widget.screenWidthUnit * 460,
                height: widget.screenHeightUnit * 400,
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.Transactions.reversed
                        .map((transaction) => TransactionHistoryDropdown(
                              transaction: transaction,
                              screenHeightUnit: widget.screenHeightUnit,
                              screenWidthUnit: widget.screenWidthUnit,
                            ))
                        .toList(),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class TransactionHistoryDropdown extends StatefulWidget {
  final Transaction transaction;
  final double screenHeightUnit;
  final double screenWidthUnit;

  const TransactionHistoryDropdown({
    Key? key,
    required this.transaction,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
  }) : super(key: key);

  @override
  _TransactionHistoryDropdownState createState() =>
      _TransactionHistoryDropdownState();
}

class _TransactionHistoryDropdownState
    extends State<TransactionHistoryDropdown> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.screenHeightUnit * 20),
      child: Container(
        height: clicked
            ? widget.screenHeightUnit * 185
            : widget.screenHeightUnit * 55,
        width: widget.screenWidthUnit * 428,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: widget.screenHeightUnit * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: widget.screenWidthUnit * 200,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${widget.transaction.account} Account',
                          style: GoogleFonts.baloo2(
                            fontSize: widget.screenHeightUnit * 32,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                    )),
                SizedBox(
                  width: widget.screenWidthUnit * 8,
                ),
                widget.transaction.currentAmount >= 0
                    ? Text(
                        "\$${widget.transaction.currentAmount % 1 == 0 ? widget.transaction.currentAmount.toStringAsFixed(0) : widget.transaction.currentAmount.toStringAsFixed(2)}",
                        style: GoogleFonts.baloo2(
                          fontSize: widget.screenHeightUnit * 32,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 199, 129, 1),
                        ),
                      )
                    : Text('\$0',
                        style: GoogleFonts.baloo2(
                            fontSize: widget.screenHeightUnit * 32,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      clicked = !clicked;
                    });
                  },
                  child: Icon(
                    clicked ? Icons.chevron_right : Icons.expand_more,
                    color: Colors.black,
                    size: widget.screenHeightUnit * 50,
                  ),
                ),
              ],
            ),
            clicked
                ? Container(
                    width: widget.screenWidthUnit * 428,
                    height: widget.screenHeightUnit * 132,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: widget.screenHeightUnit * 10,
                          horizontal: widget.screenWidthUnit * 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${DateFormat.MMMM().format(widget.transaction.day)} ${widget.transaction.day.day}, ${widget.transaction.day.year}',
                                style: GoogleFonts.baloo2(
                                    fontSize: widget.screenHeightUnit * 32,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(108, 108, 108, 1)),
                              ),
                              SizedBox(
                                width: widget.screenWidthUnit * 28,
                              ),
                              SizedBox(
                                height: widget.screenHeightUnit * 42,
                                child: IntrinsicWidth(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: widget.transaction.amount >= 0
                                            ? Color.fromRGBO(242, 255, 245, .7)
                                            : Color.fromRGBO(255, 243, 243, 1),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 1,
                                          color: widget.transaction.amount >= 0
                                              ? Color.fromRGBO(0, 199, 129, 1)
                                              : Color.fromRGBO(255, 0, 0, 1),
                                        )),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: widget.screenWidthUnit * 18),
                                        Text(
                                          '${widget.transaction.toOrFrom}',
                                          style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 26,
                                            fontWeight: FontWeight.w500,
                                            color: widget.transaction.amount >=
                                                    0
                                                ? Color.fromRGBO(0, 199, 129, 1)
                                                : Color.fromRGBO(255, 0, 0, 1),
                                          ),
                                        ),
                                        SizedBox(
                                            width: widget.screenWidthUnit * 18),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              widget.transaction.amount >= 0
                                  ? Text(
                                      "\$${widget.transaction.amount}",
                                      style: GoogleFonts.baloo2(
                                          fontSize:
                                              widget.screenHeightUnit * 26,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromRGBO(0, 199, 129, 1)),
                                    )
                                  : Text(
                                      "-\$${(widget.transaction.amount).abs()}",
                                      style: GoogleFonts.baloo2(
                                          fontSize:
                                              widget.screenHeightUnit * 26,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromRGBO(255, 0, 0, 1)),
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: widget.screenWidthUnit * 10,
                          ),
                          Text("${widget.transaction.name}",
                              style: GoogleFonts.baloo2(
                                  fontSize: widget.screenHeightUnit * 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black))
                        ],
                      ),
                    ))
                : Container()
          ],
        ),
      ),
    );
  }
}
