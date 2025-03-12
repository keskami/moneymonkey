import 'package:flutter/material.dart';

class AccountsBudgetSimulatorPage extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;

  const AccountsBudgetSimulatorPage({
    Key? key,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
  }) : super(key: key);

  @override
  _AccountsBudgetSimulatorPageState createState() =>
      _AccountsBudgetSimulatorPageState();
}

class _AccountsBudgetSimulatorPageState
    extends State<AccountsBudgetSimulatorPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeightUnit * 980,
      width: widget.screenWidthUnit * 1490,
      
    );
  }
}
