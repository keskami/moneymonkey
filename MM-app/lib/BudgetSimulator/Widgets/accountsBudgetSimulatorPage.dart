import 'package:flutter/material.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/accountsPageAccountSummary.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/eventHistory.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/transactionHistory.dart';

class AccountsBudgetSimulatorPage extends StatefulWidget {
  final double screenHeightUnit;
  final double screenWidthUnit;
  final dynamic widget;
  final List<RandomEventTaken> randomEventsTaken;
  final List<Transaction> Transactions;

  const AccountsBudgetSimulatorPage({
    Key? key,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    required this.widget,
    required this.randomEventsTaken,
    required this.Transactions,
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
      height: widget.screenHeightUnit * 940,
      width: widget.screenWidthUnit * 1400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: widget.screenHeightUnit * 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AccountsPageAccountSummary(
                screenHeightUnit: widget.screenHeightUnit,
                screenWidthUnit: widget.screenWidthUnit,
                account: 'Checking',
                APY: 0,
                balance: widget.widget.checkingAccountBalance,
              ),
              SizedBox(
                width: widget.screenWidthUnit * 30,
              ),
              AccountsPageAccountSummary(
                screenHeightUnit: widget.screenHeightUnit,
                screenWidthUnit: widget.screenWidthUnit,
                account: 'Savings',
                APY: widget.widget.savingsAPY,
                balance: widget.widget.savingsAccountBalance,
              )
            ],
          ),
          SizedBox(
            height: widget.screenHeightUnit * 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EventHistory(
                eventsTaken: widget.randomEventsTaken,
                screenHeightUnit: widget.screenHeightUnit,
                screenWidthUnit: widget.screenWidthUnit,
              ),
               SizedBox(
                width: widget.screenWidthUnit * 30,
              ),
              TransactionHistory(
                screenHeightUnit: widget.screenHeightUnit,
                screenWidthUnit: widget.screenWidthUnit,
                Transactions: widget.Transactions,
              )
            ],
          ),
        ],
      ),
    );
  }
}
