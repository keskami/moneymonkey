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
      width: widget.screenWidthUnit * 1490,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: widget.screenHeightUnit * 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AccountsPageAccountSummary(
                screenHeightUnit: widget.screenHeightUnit,
                screenWidthUnit: widget.screenWidthUnit,
                account: 'Checking',
                APY: 0,
                balance: widget.widget.checkingAccountBalance,
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
            height: widget.screenHeightUnit * 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              EventHistory(
                eventsTaken: widget.randomEventsTaken,
                screenHeightUnit: widget.screenHeightUnit,
                screenWidthUnit: widget.screenWidthUnit,
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
