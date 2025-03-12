import 'package:flutter/material.dart';

class AccountsBudgetSimulatorPage extends StatefulWidget {
  final String title;
  final double initialBudget;

  const AccountsBudgetSimulatorPage({
    Key? key,
    required this.title,
    required this.initialBudget,
  }) : super(key: key);

  @override
  _AccountsBudgetSimulatorPageState createState() => _AccountsBudgetSimulatorPageState();
}

class _AccountsBudgetSimulatorPageState extends State<AccountsBudgetSimulatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('Initial Budget: \$${widget.initialBudget.toStringAsFixed(2)}'),
      ),
    );
  }
}