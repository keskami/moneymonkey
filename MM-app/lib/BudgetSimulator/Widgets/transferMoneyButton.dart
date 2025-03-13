import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/transferMoney.dart';

class TransferMoneyButton extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final dynamic widget;
  final int checkingAccountBalance;
  final Function setStateCallback;


  const TransferMoneyButton({
    Key? key,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.widget,
    required this.checkingAccountBalance,
    required this.setStateCallback
  }) : super(key: key);

  @override
  _TransferMoneyButtonState createState() => _TransferMoneyButtonState();
}

class _TransferMoneyButtonState extends State<TransferMoneyButton> {
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            
            return Dialog(
              child: TransferMoneyPopUp(screenHeightUnit: widget.screenHeightUnit, screenWidthUnit: widget.screenWidthUnit, widget: widget.widget, setStateCallback: widget.setStateCallback,)
            );
          },
        );
      },
      child: Container(
        width: widget.screenWidthUnit * 195,
        height: widget.screenHeightUnit * 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(0, 127, 255, 1),
        ),
        child: Center(
          child: Text(
            "Transfer Money",
            style: GoogleFonts.baloo2(
              fontSize: widget.screenHeightUnit * 25,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
