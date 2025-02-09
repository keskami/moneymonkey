import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Allocatefunding extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final List<String> types;

  Allocatefunding({
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.types,
  });

  @override
  _AllocatefundingState createState() => _AllocatefundingState();
}

class _AllocatefundingState extends State<Allocatefunding> {
  int RemainingFunds = 1000;
  List<Color> colors = [
    Colors.pink,
    Colors.blue,
    Colors.teal,
    Colors.orange,
    Colors.yellow,
    Colors.pink
  ];

  List<int> prices = [100, 10, 20, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: widget.screenHeightUnit * 900,
      width: widget.screenWidthUnit * 1091,
      child: Column(
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
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: widget.screenHeightUnit * 15,
              left: widget.screenWidthUnit * 145,
            ),
            child: Row(
              children: [
                Text(
                  "Remaining Funds",
                  style: GoogleFonts.baloo2(
                    fontSize: widget.screenWidthUnit * 45,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: widget.screenWidthUnit * 100,
                ),
                Text(
                  "$RemainingFunds",
                  style: GoogleFonts.baloo2(
                    fontSize: widget.screenWidthUnit * 45,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: widget.screenHeightUnit * 20),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(widget.types.length, (i) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: widget.screenHeightUnit * 10,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: widget.screenWidthUnit * 410,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              widget.types[i],
                              style: GoogleFonts.baloo2(
                                fontSize: widget.screenWidthUnit * 45,
                                fontWeight: FontWeight.w600,
                                color: colors[i % colors.length],
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: widget.screenWidthUnit * 84,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (prices[i] > 0) {
                              setState(() {
                                prices[i] -= 10;
                                RemainingFunds += 10;
                              });
                            }
                          },
                          child: Container(
                            width: 49 * widget.screenHeightUnit,
                            height: 49 * widget.screenHeightUnit,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(79, 195, 247, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                size: widget.screenWidthUnit * 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: widget.screenWidthUnit * 52,
                        ),
                        Container(
                          width: widget.screenWidthUnit * 104,
                          child: Center(
                            child: Text(
                              "${prices[i]}",
                              style: GoogleFonts.baloo2(
                                fontSize: widget.screenWidthUnit * 45,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: widget.screenWidthUnit * 52,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              prices[i] += 10;
                              RemainingFunds -= 10;
                            });
                          },
                          child: Container(
                            width: 49 * widget.screenHeightUnit,
                            height: 49 * widget.screenHeightUnit,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(79, 195, 247, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: widget.screenWidthUnit * 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(top: widget.screenHeightUnit * 82),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height: widget.screenHeightUnit * 80,
                        width: widget.screenWidthUnit * 300,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(72, 209, 38, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Confirm",
                            style: GoogleFonts.baloo2(
                              fontSize: widget.screenWidthUnit * 35,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: widget.screenWidthUnit * 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height: widget.screenHeightUnit * 85,
                        width: widget.screenWidthUnit * 300,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(241, 75, 75, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.baloo2(
                              fontSize: widget.screenWidthUnit * 35,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
