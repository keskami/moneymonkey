import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransferMoneyPopUp extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final dynamic widget;
  final Function setStateCallback;
  final Function nextDay;

  TransferMoneyPopUp({
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.widget,
    required this.setStateCallback,
    required this.nextDay,
  });

  @override
  _TransferMoneyPopUpState createState() => _TransferMoneyPopUpState();
}

class _TransferMoneyPopUpState extends State<TransferMoneyPopUp> {
  int toChecking = 0;
  int toSavings = 0;
  String _selectedValue = 'Checking → Savings';
  final List<String> _options = ['Checking → Savings', 'Savings → Checking'];
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidthUnit * 600,
      height: widget.screenHeightUnit * 900,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widget.screenWidthUnit * 40,
                vertical: widget.screenHeightUnit * 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transfer Money",
                  style: GoogleFonts.baloo2(
                    fontSize: widget.screenHeightUnit * 45,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    size: widget.screenHeightUnit * 55,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widget.screenWidthUnit * 40,
                vertical: widget.screenHeightUnit * 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: widget.screenHeightUnit * 150,
                    width: widget.screenWidthUnit * 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(208, 227, 255, 1),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: widget.screenWidthUnit * 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Checking",
                            style: GoogleFonts.baloo2(
                              fontSize: widget.screenHeightUnit * 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "\$${widget.widget.checkingAccountBalance}",
                            style: GoogleFonts.baloo2(
                              fontSize: widget.screenHeightUnit * 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    )),
                Container(
                    height: widget.screenHeightUnit * 150,
                    width: widget.screenWidthUnit * 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(208, 255, 227, 1),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: widget.screenWidthUnit * 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Savings",
                            style: GoogleFonts.baloo2(
                              fontSize: widget.screenHeightUnit * 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "\$${widget.widget.savingsAccountBalance}",
                            style: GoogleFonts.baloo2(
                              fontSize: widget.screenHeightUnit * 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: widget.screenWidthUnit * 40,
                vertical: widget.screenHeightUnit * 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transfer Direction",
                  style: GoogleFonts.baloo2(
                    fontSize: widget.screenHeightUnit * 26,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 62, 61, 61),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 26 * widget.screenWidthUnit),
                      borderRadius: BorderRadius.circular(8),
                      items: _options.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedValue = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.screenHeightUnit * 60,
                ),
                Text("Amount",
                    style: GoogleFonts.baloo2(
                      fontSize: widget.screenHeightUnit * 26,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 62, 61, 61),
                    )),
                Container(
                  width: widget.screenWidthUnit * 520,
                  height: widget.screenHeightUnit * 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.attach_money,
                          size: widget.screenHeightUnit * 40,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: false),
                          decoration: InputDecoration(
                            hintText: '0',
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              double newValue = double.parse(value.trim());

                              if (_selectedValue == 'Checking → Savings') {
                                newValue = min(
                                    widget.widget.checkingAccountBalance
                                        as double,
                                    double.parse(value));
                              } else {
                                newValue = min(
                                    widget.widget.savingsAccountBalance
                                        as double,
                                    double.parse(value));
                              }

                              setState(() {
                                amountController.text = newValue.toString();
                                amountController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(
                                      offset: amountController.text.length),
                                );
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: widget.screenHeightUnit * 40,
                ),
                GestureDetector(

                  
                    onTap: () {
                      if(amountController.text.isEmpty) {
                        Navigator.of(context).pop();
                        return;
                      }
                      widget.setStateCallback(() {
                        widget.widget.checkingAccountBalance =
                          widget.widget.checkingAccountBalance +
                              (widget.widget.checkingTransfer);
                              widget.widget.savingsAccountBalance =
                              widget.widget.savingsAccountBalance + widget.widget.savingsTransfer;
                      });
                      
                      widget.nextDay();

                      if (_selectedValue == 'Checking → Savings') {
                        widget.setStateCallback(() {
                          widget.widget.checkingTransfer =
                              -double.parse(amountController.text);
                          widget.widget.savingsTransfer =
                              double.parse(amountController.text);
                        });
                      } else {
                         widget.setStateCallback(() {
                          widget.widget.checkingTransfer =
                              double.parse(amountController.text);
                          widget.widget.savingsTransfer =
                              -double.parse(amountController.text);
                        });
                      }
                      amountController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        width: widget.screenWidthUnit * 520,
                        height: widget.screenHeightUnit * 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 0, 127, 255),
                        ),
                        child: Center(
                          child: Text(
                            "Transfer Money",
                            style: GoogleFonts.baloo2(
                              fontSize: widget.screenHeightUnit * 35,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
