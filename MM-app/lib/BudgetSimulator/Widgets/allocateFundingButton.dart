import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/functions.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/allocateFunding.dart';

class AllocateFundsButton extends StatefulWidget {
  final double screenWidthUnit;
  final double screenHeightUnit;
  int checkingTransfer;
  final Function getInterestSavings;
  final Function setStateCallback;
  final dynamic widget;
  final dynamic functions;
  dynamic expenses;
  Expense? nextExpense;
  final Function getEvents;
  final Function checkRandomEvents;
  double savingsTransfer;
  int monthlyFitness;
  int monthlyEntertainment;
  int monthsOccurd;
  int daysUnderLuxary;
  int toLuxaryForWeek;
  bool daysUnderLuxaryDone;
  Function spendOnExpense;
  DateTime now;
  Function recalculatePercentages;
  Function mapExpenses;
  Function nextDay;

  AllocateFundsButton({
    Key? key,
    required this.screenWidthUnit,
    required this.screenHeightUnit,
    required this.checkingTransfer,
    required this.getInterestSavings,
    required this.setStateCallback,
    required this.widget,
    required this.functions,
    required this.expenses,
    required this.nextExpense,
    required this.getEvents,
    required this.checkRandomEvents,
    required this.savingsTransfer,
    required this.monthlyFitness,
    required this.monthlyEntertainment,
    required this.monthsOccurd,
    required this.daysUnderLuxary,
    required this.toLuxaryForWeek,
    required this.daysUnderLuxaryDone,
    required this.spendOnExpense,
    required this.now,
    required this.recalculatePercentages,
    required this.mapExpenses,
    required this.nextDay,
  }) : super(key: key);

  @override
  _AllocateFundsButtonState createState() => _AllocateFundsButtonState();
}

class _AllocateFundsButtonState extends State<AllocateFundsButton> {
  BudgetSimulatorFunctions functions = BudgetSimulatorFunctions();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.screenHeightUnit * 15),
      child: Container(
        width: widget.screenWidthUnit * 195,
        height: widget.screenHeightUnit * 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(0, 127, 255, 1),
        ),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Allocatefunding(
                    toCheckingTransfer: widget.checkingTransfer,
                    screenHeightUnit: widget.screenHeightUnit,
                    screenWidthUnit: widget.screenWidthUnit,
                    wellnessScore: widget.widget.wellnessScore,
                    checkingAccountBalance:
                        widget.widget.checkingAccountBalance as int,
                    creditCardDebt: widget.widget.creditCardDebt as int,
                    savingsAccountBalance: widget.widget.savingsAccountBalance,
                    checkingTransfer: widget.widget.checkingTransfer,
                    savingsTransfer: widget.savingsTransfer,
                    expenses: widget.widget.expenses,
                    monthlyFitness: widget.monthlyFitness,
                    monthlyEntertainment: widget.monthlyEntertainment,
                    onConfirm: (
                      double toSavings,
                      double toChecking,
                      double newChecking,
                      double rentSpent,
                      double groceriesSpent,
                      double travelSpentNow,
                      double utilitiesSpent,
                      double toFitness,
                      double toEntertainment,
                      double toCredCardDebt,
                      int monthlyEntertainment,
                      int monthlyFitness,
                      int wellnessScore,
                    ) {
                      double totalOff = 0;
                      widget.getInterestSavings();
                      widget.setStateCallback(() {
                        if (rentSpent > 0) {
                          Transaction rentTransaction = Transaction(
                              name: "Paid Rent",
                              day: widget.widget.now,
                              amount: -rentSpent,
                              toOrFrom: "Transfer out",
                              account: "Checking",
                              currentAmount:
                                  widget.widget.checkingAccountBalance -
                                      rentSpent);
                          widget.widget.Transactions.add(rentTransaction);
                          totalOff += rentSpent;
                        }
                        if (groceriesSpent > 0) {
                          Transaction groceriesTransaction = Transaction(
                              name: "Paid Groceries",
                              day: widget.widget.now,
                              amount: -groceriesSpent,
                              toOrFrom: "Transfer out",
                              account: "Checking",
                              currentAmount:
                                  widget.widget.checkingAccountBalance -
                                      groceriesSpent - totalOff);
                          widget.widget.Transactions.add(groceriesTransaction);
                          totalOff += groceriesSpent;
                        }
                        if (travelSpentNow > 0) {
                          Transaction travelTransaction = Transaction(
                              name: "Paid Transportation",
                              day: widget.widget.now,
                              amount: -travelSpentNow,
                              toOrFrom: "Transfer out",
                              account: "Checking",
                              currentAmount:
                                  widget.widget.checkingAccountBalance -
                                      travelSpentNow - totalOff);
                                      totalOff += travelSpentNow;
                          widget.widget.Transactions.add(travelTransaction);
                        }
                        if (utilitiesSpent > 0) {
                          Transaction utilitiesTransaction = Transaction(
                              name: "Paid Utilities",
                              day: widget.widget.now,
                              amount: -utilitiesSpent,
                              toOrFrom: "Transfer out",
                              account: "Checking",
                              currentAmount:
                                  widget.widget.checkingAccountBalance -
                                      utilitiesSpent - totalOff);
                          widget.widget.Transactions.add(utilitiesTransaction);
                          totalOff += utilitiesSpent;
                        }
                        if (toFitness > 0) {
                          Transaction fitnessTransaction = Transaction(
                              name: "Paid Fitness",
                              day: widget.widget.now,
                              amount: -toFitness,
                              toOrFrom: "Transfer out",
                              account: "Checking",
                              currentAmount:
                                  widget.widget.checkingAccountBalance -
                                      toFitness - totalOff);
                          widget.widget.Transactions.add(fitnessTransaction);
                          totalOff += toFitness;
                        }
                        if (toEntertainment > 0) {
                          Transaction entertainmentTransaction = Transaction(
                              name: "Paid Entertainment",
                              day: widget.widget.now,
                              amount: -toEntertainment,
                              toOrFrom: "Transfer out",
                              account: "Checking",
                              currentAmount:
                                  widget.widget.checkingAccountBalance -
                                      toEntertainment - totalOff);
                          widget.widget.Transactions
                              .add(entertainmentTransaction);
                              totalOff += toEntertainment;
                        }
                        if (toCredCardDebt > 0) {
                          Transaction creditCardTransaction = Transaction(
                              name: "Paid Credit Card Debt",
                              day: widget.widget.now,
                              amount: -toCredCardDebt,
                              toOrFrom: "Transfer out",
                              account: "Checking",
                              currentAmount:
                                  widget.widget.checkingAccountBalance -
                                      toCredCardDebt - totalOff);
                          widget.widget.Transactions.add(creditCardTransaction);
                          totalOff += toCredCardDebt;
                        }

                        if (widget.widget.savingsTransfer != 0) {
                          Transaction savingsTransaction;
                          Transaction checkingTransaction;

                          if (widget.widget.savingsTransfer > 0) {
                            savingsTransaction = Transaction(
                              name: "Transfer From Checking",
                              day: widget.widget.now,
                              amount: widget.widget.savingsTransfer,
                              toOrFrom: "Transfer in",
                              account: "Savings",
                              currentAmount:
                                  widget.widget.savingsAccountBalance +
                                      widget.widget.savingsTransfer,
                            );
                            checkingTransaction = Transaction(
                              name: "Transfer To Savings",
                              day: widget.widget.now,
                              amount: -widget.widget.savingsTransfer,
                              toOrFrom: "Transfer out",
                              account: "Checking",
                              currentAmount:
                                  widget.widget.checkingAccountBalance -
                                      widget.widget.savingsTransfer - totalOff,
                            );
                          } else {
                            savingsTransaction = Transaction(
                              name: "Transfer To Checking",
                              day: widget.widget.now,
                              amount: widget.widget.savingsTransfer,
                              toOrFrom: "Transfer out",
                              account: "Savings",
                              currentAmount:
                                  widget.widget.savingsAccountBalance +
                                      widget.widget.savingsTransfer,
                            );

                            checkingTransaction = Transaction(
                              name: "Transfer From Savings",
                              day: widget.widget.now,
                              amount: -widget.widget.savingsTransfer,
                              toOrFrom: "Transfer in",
                              account: "Checking",
                              currentAmount:
                                  widget.widget.checkingAccountBalance -
                                      widget.widget.savingsTransfer - totalOff,
                            );
                          }
                          widget.widget.Transactions.add(savingsTransaction);
                          widget.widget.Transactions.add(checkingTransaction);
                        }

                        //widget.widget.checkingAccountBalance = newChecking;

                        widget.widget.checkingAccountBalance +=
                            widget.widget.checkingTransfer;

                        widget.widget.savingsAccountBalance +=
                            widget.widget.savingsTransfer;

                        widget.widget.savingsTransfer = toSavings;
                        widget.widget.checkingTransfer = toChecking;

                        widget.widget.creditCardDebt -= toCredCardDebt;
                        widget.widget.wellnessScore = wellnessScore;

                        var milestoneData = {};

                        if (widget.widget.name ==
                            "Crush the Credit Card Debt") {
                          milestoneData = widget.functions.editMilestones(
                            milestones: widget.widget.milestones,
                            toCredCardDebt: toCredCardDebt,
                            toSavings: toSavings,
                            toLuxary: toEntertainment + toFitness,
                            level: widget.widget.level,
                            monthsOccurd: widget.monthsOccurd,
                            daysUnderLuxary: widget.daysUnderLuxary,
                            toLuxaryForWeek: widget.toLuxaryForWeek,
                            daysUnderLuxaryDone: widget.daysUnderLuxaryDone,
                            savingsAccountBalance:
                                widget.widget.savingsAccountBalance,
                          );
                          widget.widget.milestones =
                              milestoneData['Milestones'];
                        }

                        widget.spendOnExpense(rentSpent, "Rent");
                        widget.spendOnExpense(groceriesSpent, "Groceries");
                        widget.spendOnExpense(travelSpentNow, "Transportation");
                        widget.spendOnExpense(utilitiesSpent, "Utilities");
                        widget.spendOnExpense(toFitness, "Fitness");
                        widget.spendOnExpense(toEntertainment, "Entertainment");
                        widget.spendOnExpense(toCredCardDebt, "CC Debt");

                        widget.recalculatePercentages();
                        widget.mapExpenses();
                        widget.nextDay();
                        var data = functions.updateNextExpense(
                            widget.widget.expenses, widget.now);
                        widget.expenses = data['expenses'];
                        widget.widget.nextExpense = data['nextExpense'];
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          widget.getEvents();
                          widget.checkRandomEvents();
                        });
                      });
                    },
                  ),
                );
              },
            );
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Allocate Funds",
                  style: GoogleFonts.baloo2(
                    fontSize: widget.screenWidthUnit * 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: widget.screenWidthUnit * 3),
                Icon(Icons.arrow_forward_ios,
                    size: widget.screenWidthUnit * 15, color: Colors.white),
                Icon(Icons.arrow_forward_ios,
                    size: widget.screenWidthUnit * 15, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
