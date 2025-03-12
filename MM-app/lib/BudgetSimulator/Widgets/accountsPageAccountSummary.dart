import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountsPageAccountSummary extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final String account;
  final int APY;
  final int balance;

  const AccountsPageAccountSummary({
    Key? key,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.account,
    required this.APY,
    required this.balance,
  }) : super(key: key);

  @override
  _AccountsPageAccountSummaryState createState() => _AccountsPageAccountSummaryState();
}

class _AccountsPageAccountSummaryState extends State<AccountsPageAccountSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeightUnit * 320,
      width: widget.screenWidthUnit * 620,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Colors.black
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: widget.screenWidthUnit *32, top: widget.screenHeightUnit * 23, bottom: widget.screenHeightUnit * 22),
          child: Text("${widget.account} Account",
          style: GoogleFonts.baloo2(
            fontSize: widget.screenHeightUnit * 35,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(108, 108, 108, 1)
          ),),
          
          
          ),
          Container(
            width: widget.screenWidthUnit * 620,
            height: widget.screenHeightUnit * 1,
            color: Colors.black,
          ),
          Padding(padding: EdgeInsets.only(left: widget.screenWidthUnit *32, top: widget.screenHeightUnit * 23, bottom: widget.screenHeightUnit * 0),
          child: Text("\$${widget.balance}",
          style: GoogleFonts.baloo2(
            fontSize: widget.screenHeightUnit * 55,
            fontWeight: FontWeight.w600,
            color: Colors.black
          ),),
          ),

          Padding(padding: EdgeInsets.only(left: widget.screenWidthUnit *32, top: widget.screenHeightUnit * 0, bottom: widget.screenHeightUnit * 0),
          child: Text("Available Balance",
          style: GoogleFonts.baloo2(
            fontSize: widget.screenHeightUnit * 28,
            fontWeight: FontWeight.w600,
            color: Colors.black
          ),),
          ),
           Padding(padding: EdgeInsets.only(left: widget.screenWidthUnit *32, top: widget.screenHeightUnit * 0, bottom: widget.screenHeightUnit * 0),
          child: Text("Earning: ${widget.APY}% APY",
          style: GoogleFonts.baloo2(
            fontSize: widget.screenHeightUnit * 28,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(108, 108, 108, 1)
          ),),
          ),
          
        ],
      ),
      
    );
  }
}