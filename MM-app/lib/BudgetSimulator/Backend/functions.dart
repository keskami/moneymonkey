import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';

class BudgetSimulatorFunctions {

void nextMonth({
  required List<Expense> expenses,
  required int monthsOccurd,
  required bool noLatePayments,
  required void Function() mapExpenses,
  required Function(int) updateCreditScore,
  required double startingTransportation,
  required double startingGroceries,
  required double startingRent,
  required double startingCCMin,
}) {
  if (monthsOccurd < 2) {
    for (Expense expense in expenses) {
      if (expense.name == "Pay Day") {
        expense.dueDay = DateTime(expense.dueDay.year, expense.dueDay.month + 1, expense.dueDay.day);
      } else if (expense.name == "Transportation") {
        expense.amount += startingTransportation;
      } else if (expense.name == "Groceries") {
        expense.amount += startingGroceries;
      } else if (expense.name == "Rent") {
        expense.amount += startingRent;
        expense.dueDay = DateTime(expense.dueDay.year, expense.dueDay.month + 1, expense.dueDay.day);
      } else if (expense.name == "CC Debt" || expense.name == "Utilities") {
        expense.amount += startingCCMin;
        expense.dueDay = DateTime(expense.dueDay.year, expense.dueDay.month + 1, expense.dueDay.day);
      }
    }
  }

  monthsOccurd += 1;

  if (noLatePayments) {
    updateCreditScore(10); 
  }

  mapExpenses(); 
}


  List<Color> colors = [
    Colors.pink,
    Colors.blue,
    Colors.teal,
    Colors.orange,
    Colors.yellow,
    Colors.black,
    Colors.purple,
  ];

  List<BudgetSimulatorChartData> getChartData(
      List<String> types, List<double> percentage, List<Color> colors) {
    List<BudgetSimulatorChartData> chartData = [];
    int total = 0;

    for (int i = 0; i < types.length; i++) {
      chartData.add(BudgetSimulatorChartData(
          types[i], percentage[i], colors[i % colors.length]));
      total += percentage[i].toInt();
    }
    return chartData;
  }

  Expense nullExpense = Expense(
    name: '',
    amount: 0,
    amountPaid: 0,
    dueDay: DateTime(2029, 5, 1),
    penalty: 50,
    dueDateType: '',
  );


  List<String> getTypes(expenes) {
    List<String> types = [];
    for (Expense expense in expenes) {
      types.add(expense.name);
    }
    return types;
    
  }

  Map<String, dynamic> editMilestones({
    required List<Milestone> milestones,
    int toCredCardDebt = 0,
    int toSavings = 0,
    int toLuxary = 0,
    required String level,
    int monthsOccurd = 0,
    int daysUnderLuxary = 0,
    int toLuxaryForWeek = 0,
    bool daysUnderLuxaryDone = false,
    savingsAccountBalance = 0,
  }) {
    if (level == "Intermediate") {
      for (Milestone milestone in milestones) {
        if (milestone.name == 'Debt Avalanche Start') {
          if (monthsOccurd < 1) {
            milestone.currentAmount += toCredCardDebt;
          }
        } else if (milestone.name == 'Build an Emergency Cushion') {
          if (monthsOccurd < 2) {
            milestone.currentAmount = savingsAccountBalance as double;
          }
        } else if (milestone.name == 'Two Weeks Under Budget') {
          if (!daysUnderLuxaryDone) {
            if (toLuxaryForWeek + toLuxary >= 50) {
              milestone.currentAmount = 0;
              daysUnderLuxary = 0;
              toLuxaryForWeek = 0;
            } else if (daysUnderLuxary == 13) {
              milestone.currentAmount = 14;
              daysUnderLuxaryDone = true;
            } else if (daysUnderLuxary == 6) {
              milestone.currentAmount += 1;
              toLuxaryForWeek = 0;
              daysUnderLuxary += 1;
            } else {
              milestone.currentAmount += 1;
              toLuxaryForWeek += toLuxary;
              daysUnderLuxary += 1;
            }
          }
        }
      }
    }

    Map<String, dynamic> data = {
      "Milestones": milestones,
      "daysUnderLuxaryDone": daysUnderLuxaryDone,
      "daysUnderLuxary": daysUnderLuxary,
      "ToLuxaryForWeek": toLuxaryForWeek
    };
    return data;
  }

  Map<String, dynamic> updateNextExpense(List<Expense> expenses, DateTime now) {
    Expense nextExpense;
    if (expenses.isNotEmpty) {
      expenses.sort((a, b) => a.dueDay.compareTo(b.dueDay));
      nextExpense = expenses.firstWhere(
        (expense) => expense.dueDay.isAfter(now) && expense.name != "Pay Day",
        orElse: () => expenses.firstWhere(
            (expense) => expense.name != "Pay Day",
            orElse: () => expenses.first),
      );
      if (nextExpense == null) {
        nextExpense = nullExpense;
      }
    } else {
      nextExpense = nullExpense;
    }
    return {'expenses': expenses, 'nextExpense': nextExpense};
  }

  bool checkIfPaymentIsPaid(String type, List<Expense> expenses) {
    for (Expense expense in expenses) {
      if (expense.name == type) {
        if (expense.amountPaid >= expense.amount) {
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }

  List<Hint> addHint(
    String type,
    List<Hint> hints,
    DateTime now,
    String level,
    String name,
  ) {
    if (name == "Crush the Credit Card Debt") {
      if (level == "Intermediate") {
        if (type == "Pay Day") {
          if (now.day == 1 && now.month == 5) {
            hints.add(Hint(
              text:
                  "Today you receive \$1,250. Plan ahead—allocate funds for rent (\$500 due by the 5th),\nutilities, and extra debt payments to kickstart your Debt Avalanche.",
              good: true,
            ));
          } else {
            hints.add(Hint(
              text:
                  "New paycheck received! Consider whether to boost your debt repayment or cover\nupcoming expenses. Every decision now affects your future costs.",
              good: true,
            ));
          }
        } else if (type == "End of Month") {
          hints.add(Hint(
            text:
                "Month’s end: Review your performance. Have you met your payment milestones\nand avoided excess fees? Use this recap to adjust your strategy for next month.",
            good: true,
          ));
        } else if (type == "Rent") {
          hints.add(Hint(
            text:
                "Heads up: Rent (\$500) is due on the 5th. Ensure you’ve set aside enough funds\nto avoid a \$25 late fee.",
            good: true,
          ));
        } else if (type == "Utilities") {
          hints.add(Hint(
            text:
                "Reminder: Utilities (\$150) are due by the 10th. Reserve funds now to prevent any\nlate fee.",
            good: true,
          ));
        } else if (type == "CC Min") {
          hints.add(Hint(
            text:
                "Tomorrow the credit card minimum is due (\$200). If you can, try to pay\nextra—remember, early extra payments help reduce your",
            good: true,
          ));
        } else if (type == "Car Repair Surprise") {
          hints.add(Hint(
            text:
                "Your car might need urgent repairs soon, costing around \$250. You can pay for it in full to ensure\nsafety, or skip it and switch to public transportation. Weigh your needs and available funds.",
            good: false,
          ));
        } else if (type == "Home Appliance Breakdown") {
          hints.add(Hint(
            text:
                "A home appliance may break soon, costing \$100. You can either pay the full cost immediately\nto fix it or skip repairs and adjust your routine. Consider your current cash flow and priorities.",
            good: false,
          ));
        } else if (type == "Class Registration or Certification Fee") {
          hints.add(Hint(
            text:
                "An education opportunity with a \$200 fee is approaching. You can enroll immediately to invest in\nyour future, or postpone enrollment to conserve funds. Reflect on your goals and situation.",
            good: false,
          ));
        } else if (type == "Impulse Buy") {
          hints.add(Hint(
            text:
                "Watch for an impulse buy opportunity soon—a \$200 gadget or event invite. You can purchase it immediately\nto satisfy the urge or resist and preserve your funds. Reflect on your priorities before deciding.",
            good: false,
          ));
        } else if (type == "Unexpected Windfall") {
          hints.add(Hint(
            text:
                "Good news—a \$150 windfall is coming! You could use it entirely to reduce your debt or spend it on \nentertainment. Consider your current debt load versus your need for a morale boost.",
            good: true,
          ));
        } else if (type == "Wedding Invitation") {
          hints.add(Hint(
            text:
                "A wedding invitation is on the horizon, costing about \$150. You can attend fully by covering all expenses\nor decline the invitation altogether. Consider the social benefits versus the financial impact",
            good: false,
          ));
        } else if (type == "Medical Bill") {
          hints.add(Hint(
            text:
                "A \$300 medical bill is approaching. You might settle it in full now with your cash or charge it to your\ncredit card to keep cash on hand. Think about how you wish to manage this expense.",
            good: false,
          ));
        } else if (type == "Family Emergency Request") {
          hints.add(Hint(
            text:
                "A family member might request a \$200 loan soon. You can choose to lend the full amount to help, or politely\ndecline to protect your funds. Consider your capacity to assist versus your own financial stability.",
            good: false,
          ));
        } else if (type == "Small Bonus / Part-Time Gig") {
          hints.add(Hint(
            text:
                "A \$100 bonus from a side gig is coming. You could use it entirely to lower your debt or spend it on\nleisure.Think about whether reducing your liabilities or boosting your morale is more critical right now.",
            good: true,
          ));
        } else if (type == "Two Weeks Under Budget") {
          hints.add(Hint(
            text:
                "Reminder: Keep your entertainment spending under \$50 this week to meet your budget goals.\nSaving now can help reduce future debt.",
            good: true,
          ));
        } else if (type == "Debt Avalanche Start") {
          hints.add(Hint(
            text:
                "Mid-month check: Are you on track to pay an extra \$300 toward your credit card?\nEarly extra payments reduce interest—review your allocations now!",
            good: true,
          ));
        }
      }
    }
    return hints;
  }

  int calculateWellnessFitness(
      int score, int fitnessAdded, int monthlyFitness) {
    if (fitnessAdded < 0) {
      if (monthlyFitness <= 50) {
        score -= 30;
      } else if (monthlyFitness <= 100) {
        score -= 10;
      } else if (monthlyFitness <= 150) {
        score -= 5;
      }
    } else {
      if (monthlyFitness < 50) {
        score += 30;
      } else if (monthlyFitness < 100) {
        score += 10;
      } else if (monthlyFitness < 150) {
        score += 5;
      }
    }

    return min(score, 1000);
  }

  int calculateWellnessEntertainment(
      int score, int entertainmentAdded, int monthlyEntertainment) {
    if (entertainmentAdded < 0) {
      if (monthlyEntertainment <= 100) {
        score -= 20;
      } else if (monthlyEntertainment <= 200) {
        score -= 10;
      } else if (monthlyEntertainment <= 350) {
        score -= 5;
      }
    } else {
      if (monthlyEntertainment < 100) {
        score += 20;
      } else if (monthlyEntertainment < 200) {
        score += 10;
      } else if (monthlyEntertainment < 350) {
        score += 5;
      }
    }

    return min(score, 1000);
  }
}

class BudgetSimulatorEvent {
  final String title;

  BudgetSimulatorEvent(this.title);
}

class BudgetSimulatorChartData {
  final String category;
  final double percentage;
  final Color color;

  BudgetSimulatorChartData(this.category, this.percentage, this.color);
}
