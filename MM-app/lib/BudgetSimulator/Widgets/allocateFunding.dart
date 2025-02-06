import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Allocatefunding extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;

  Allocatefunding({
    required this.screenHeightUnit,
    required this.screenWidthUnit,
  });

  @override
  _AllocatefundingState createState() => _AllocatefundingState();
}

class _AllocatefundingState extends State<Allocatefunding> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: widget.screenHeightUnit * 900,
      width: widget.screenWidthUnit * 1091,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(top: widget.screenHeightUnit * 45),
              child: Center(
                child: Text(
                  "Fund Allocation",
                  style: GoogleFonts.baloo2(
                      fontSize: widget.screenWidthUnit * 45,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              )),
          Padding(
              padding: EdgeInsets.only(
                  top: widget.screenHeightUnit * 15,
                  left: widget.screenWidthUnit * 175),
              child: Row(
                children: [
                  Text(
                    "Remaining Funds",
                    style: GoogleFonts.baloo2(
                        fontSize: widget.screenWidthUnit * 45,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: widget.screenWidthUnit * 100,),
              Text(
                    "1,000",
                    style: GoogleFonts.baloo2(
                        fontSize: widget.screenWidthUnit * 45,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
              
        ],
      ),
    );
  }
}
