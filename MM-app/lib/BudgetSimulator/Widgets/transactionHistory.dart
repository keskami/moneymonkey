import 'package:flutter/material.dart';
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
                    children: widget.Transactions.map(
                        (transaction) => TransactionHistoryDropdown(
                              transaction: transaction,
                              screenHeightUnit: widget.screenHeightUnit,
                              screenWidthUnit: widget.screenWidthUnit,
                            )).toList(),
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


  const TransactionHistoryDropdown(
      {Key? key,
      required this.transaction,
      required this.screenHeightUnit,
      required this.screenWidthUnit,
   })
      : super(key: key);

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
            ? widget.screenHeightUnit * 210
            : widget.screenHeightUnit * 50,
        width: widget.screenWidthUnit * 428,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.transaction.account} Account',
                    style: GoogleFonts.baloo2(
                      fontSize: widget.screenHeightUnit * 32,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: widget.screenWidthUnit * 28,
                ),
                Text(
                  "{}",
                  style: GoogleFonts.baloo2(
                      fontSize: widget.screenHeightUnit * 32,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
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
                SizedBox(
                  width: widget.screenWidthUnit * 36,
                )
              ],
            ),
            // clicked
            //     ? Container(
            //         width: widget.screenWidthUnit * 428,
            //         height: widget.screenHeightUnit * 160,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(10),
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.black.withOpacity(0.1),
            //               spreadRadius: 2,
            //               blurRadius: 5,
            //               offset: Offset(0, 3),
            //             ),
            //           ],
            //         ),
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(
            //               vertical: widget.screenHeightUnit * 10,
            //               horizontal: widget.screenWidthUnit * 20),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     "${widget.eventTaken.choiceTaken}",
            //                     style: GoogleFonts.baloo2(
            //                         fontSize: widget.screenHeightUnit * 26,
            //                         fontWeight: FontWeight.w500,
            //                         color: Colors.black),
            //                   ),
            //                   Spacer(),
            //                   widget.eventTaken.moneyEffect == 0
            //                       ? Text(
            //                           "",
            //                           style: GoogleFonts.baloo2(
            //                               fontSize:
            //                                   widget.screenHeightUnit * 26,
            //                               fontWeight: FontWeight.w500,
            //                               color: Colors.black),
            //                         )
            //                       : widget.eventTaken.moneyEffect > 0
            //                           ? Text(
            //                               "\$${widget.eventTaken.moneyEffect}",
            //                               style: GoogleFonts.baloo2(
            //                                   fontSize:
            //                                       widget.screenHeightUnit * 26,
            //                                   fontWeight: FontWeight.w500,
            //                                   color: Color.fromRGBO(
            //                                       0, 199, 129, 1)),
            //                             )
            //                           : Text(
            //                               "-\$${(widget.eventTaken.moneyEffect).abs()}",
            //                               style: GoogleFonts.baloo2(
            //                                   fontSize:
            //                                       widget.screenHeightUnit * 26,
            //                                   fontWeight: FontWeight.w500,
            //                                   color:
            //                                       Color.fromRGBO(255, 0, 0, 1)),
            //                             ),
            //                 ],
            //               ),
            //               Text(
            //                 "${widget.eventTaken.discription}",
            //                 style: GoogleFonts.baloo2(
            //                     fontSize: widget.screenHeightUnit * 26,
            //                     fontWeight: FontWeight.w500,
            //                     color: Color.fromRGBO(108, 108, 108, 1)),
            //               ),
            //               SizedBox(
            //                 height: widget.screenHeightUnit * 10,
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   SizedBox(
            //                     height: widget.screenHeightUnit * 40,
            //                     child: IntrinsicWidth(
            //                       child: Container(
            //                         decoration: BoxDecoration(
            //                           color: widget.eventTaken.effect1Amount > 0
            //                               ? Color.fromRGBO(199, 244, 191, 1)
            //                               : Color.fromRGBO(255, 213, 213, 1),
            //                           borderRadius: BorderRadius.circular(10),
            //                         ),
            //                         child: Row(
            //                           mainAxisSize: MainAxisSize.min,
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.start,
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.center,
            //                           children: [
            //                             SizedBox(
            //                                 width: widget.screenWidthUnit * 18),
            //                             Text(
            //                               '${widget.eventTaken.effect1}: ',
            //                               style: GoogleFonts.baloo2(
            //                                 fontSize:
            //                                     widget.screenHeightUnit * 18,
            //                                 fontWeight: FontWeight.w500,
            //                                 color: Colors.black,
            //                               ),
            //                             ),
            //                             Text(
            //                               '${widget.eventTaken.effect1Amount}',
            //                               style: GoogleFonts.baloo2(
            //                                 fontSize:
            //                                     widget.screenHeightUnit * 18,
            //                                 fontWeight: FontWeight.w500,
            //                                 color: widget.eventTaken
            //                                             .effect1Amount >
            //                                         0
            //                                     ? Color.fromRGBO(30, 213, 58, 1)
            //                                     : Color.fromRGBO(
            //                                         243, 52, 52, 1),
            //                               ),
            //                             ),
            //                             SizedBox(
            //                                 width: widget.screenWidthUnit * 18),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: widget.screenWidthUnit * 11,
            //                   ),
            //                   SizedBox(
            //                     height: widget.screenHeightUnit * 40,
            //                     child: IntrinsicWidth(
            //                       child: Container(
            //                         decoration: BoxDecoration(
            //                           color: widget.eventTaken.effect2Amount > 0
            //                               ? Color.fromRGBO(199, 244, 191, 1)
            //                               : Color.fromRGBO(255, 213, 213, 1),
            //                           borderRadius: BorderRadius.circular(10),
            //                         ),
            //                         child: Row(
            //                           mainAxisSize: MainAxisSize.min,
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.start,
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.center,
            //                           children: [
            //                             SizedBox(
            //                                 width: widget.screenWidthUnit * 18),
            //                             Text(
            //                               '${widget.eventTaken.effect2}: ',
            //                               style: GoogleFonts.baloo2(
            //                                 fontSize:
            //                                     widget.screenHeightUnit * 18,
            //                                 fontWeight: FontWeight.w500,
            //                                 color: Colors.black,
            //                               ),
            //                             ),
            //                             Text(
            //                               '${widget.eventTaken.effect2Amount}',
            //                               style: GoogleFonts.baloo2(
            //                                 fontSize:
            //                                     widget.screenHeightUnit * 18,
            //                                 fontWeight: FontWeight.w500,
            //                                 color: widget.eventTaken
            //                                             .effect2Amount >
            //                                         0
            //                                     ? Color.fromRGBO(30, 213, 58, 1)
            //                                     : Color.fromRGBO(
            //                                         243, 52, 52, 1),
            //                               ),
            //                             ),
            //                             SizedBox(
            //                                 width: widget.screenWidthUnit * 18),
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ))
            //     : Container()
          ],
        ),
      ),
    );
  }
}
