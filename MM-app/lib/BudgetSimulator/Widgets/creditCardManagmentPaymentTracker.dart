import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreditCardManagementPaymentTracker extends StatelessWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final List<int> due;
  final List<int> paid;
  final List<bool> done;
  final int monthsOccurd;

  CreditCardManagementPaymentTracker({
    Key? key,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.due,
    required this.paid,
    required this.done,
    required this.monthsOccurd,
  }) : super(key: key);

  List<String> Months = ["May:", "June:", "July:"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeightUnit * 300,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
                due.length,
                (i) => MonthTrackerRow(
                      month: Months[i],
                      due: due[i],
                      paid: paid[i],
                      done: done[i],
                      screenHeightUnit: screenHeightUnit,
                      screenWidthUnit: screenWidthUnit,
                      i: i,
                      doneList: done,
                    )),
          ]),
    );
  }
}

class MonthTrackerRow extends StatelessWidget {
  final String month;
  final int due;
  final int paid;
  final bool done;
  final double screenHeightUnit;
  final double screenWidthUnit;
  final int i;
  final List<bool> doneList;

  MonthTrackerRow({
    Key? key,
    required this.month,
    required this.due,
    required this.paid,
    required this.done,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.i,
    required this.doneList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          paid >= due
              ? Icons.check_circle
              : done
                  ? Icons.cancel
                  : Icons.pending,
          color: paid >= due
              ? Colors.green
              : done
                  ? Colors.red
                  : Colors.grey,
          size: screenHeightUnit * 60,
        ),
        SizedBox(
          width: screenWidthUnit * 40,
        ),
        Container(
            width: screenWidthUnit * 50,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                month,
                style: GoogleFonts.baloo2(
                    fontSize: screenHeightUnit * 24,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(106, 114, 128, 1)),
              ),
            )),
        SizedBox(
          width: screenWidthUnit * 150,
        ),
        Container(
            width: screenWidthUnit * 80,
            child: Align(
              alignment: Alignment.centerLeft,
              child: (i == 0 || doneList[i - 1])
                  ? Text('\$$paid',
                      style: GoogleFonts.baloo2(
                          fontSize: screenHeightUnit * 36,
                          fontWeight: FontWeight.w500,
                          color: Colors.black))
                  : Text(''),
            )),
        paid >= due
            ? Text(
                "+\$${paid - due}",
                style: GoogleFonts.baloo2(
                    fontSize: screenHeightUnit * 36,
                    fontWeight: FontWeight.w500,
                    color: Colors.green),
              )
            : Text("\$${paid - due}",
                style: GoogleFonts.baloo2(
                  fontSize: screenHeightUnit * 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ))
      ],
    );
  }
}
