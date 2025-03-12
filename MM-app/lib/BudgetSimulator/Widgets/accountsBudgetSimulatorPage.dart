import 'package:flutter/material.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/accountsPageAccountSummary.dart';

class AccountsBudgetSimulatorPage extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final dynamic widget;

  const AccountsBudgetSimulatorPage({
    Key? key,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.widget,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: widget.screenHeightUnit * 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AccountsPageAccountSummary(screenHeightUnit: widget.screenHeightUnit, screenWidthUnit: widget.screenHeightUnit, account: 'Checking', APY: 0, balance: widget.widget.checkingAccountBalance,),
              AccountsPageAccountSummary(screenHeightUnit: widget.screenHeightUnit, screenWidthUnit: widget.screenHeightUnit, account: 'Savings', APY: widget.widget.savingsAPY,balance: widget.widget.savingsAccountBalance,)
            ],

          )

        ],
      ),
      
    );
  }
}
