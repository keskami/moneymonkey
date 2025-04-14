import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_monkey/BudgetSimulator/Backend/functions.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetDashboard extends StatefulWidget {
  dynamic widget;

  BudgetDashboard({Key? key, required this.widget}) : super(key: key);

  @override
  _BudgetDashboardState createState() => _BudgetDashboardState();
}

class _BudgetDashboardState extends State<BudgetDashboard> {
  DateTime currentDate = DateTime(2025, 3, 1);
  double cashOnHand = 2100;
  double unallocated = 2100;
  int creditScore = 665;
  String? expandedPanel;

  Map<String, int> selectedExpenses = {'essentials': 0, 'debt': 0};

  Map<String, TextEditingController> allocationControllers = {
    'essentials': TextEditingController(),
    'goal': TextEditingController(),
    'debt': TextEditingController()
  };

  // Budget categories
  late Map<String, dynamic> essentials;
  late Map<String, dynamic> goal;
  late Map<String, dynamic> debt;
  BudgetSimulatorFunctions functions = BudgetSimulatorFunctions();
  Map<String, dynamic> essentialsExpenseSpending = {};

  @override
  void initState() {
    
    super.initState();

    setState(() {
      currentDate = widget.widget.widget.now;
      cashOnHand = widget.widget.widget.checkingAccountBalance;
      unallocated = widget.widget.widget.checkingAccountBalance;
      creditScore = widget.widget.widget.creditScore;
      print("here");

      essentials = {
        'items': functions.EssentialExpenses(widget.widget, widget.widget.widget.expenses),
        'allocated': functions.EssentialExpensesTotal(widget.widget),
      };

      goal = {
        'allocated': 0.0,
        'target': 2500.0,
        'monthlyTarget': 833.0,
        'dueDate': 18,
        'paid': false,
        'progress': 0.0
      };

      debt = {
        'allocated': 0.0,
        'items': [
          {
            'name': 'Student Loan',
            'amount': 250.0,
            'dueDate': 12,
            'paid': false,
            'allocated': 0.0,
            'plan': 'standard',
            'plans': [
              {
                'name': 'Standard',
                'amount': 250.0,
                'interest': '5%',
                'term': '10 years'
              },
              {
                'name': 'Extended',
                'amount': 150.0,
                'interest': '5.5%',
                'term': '15 years'
              },
              {
                'name': 'Graduated',
                'amount': 100.0,
                'interest': '5.25%',
                'term': '10 years'
              }
            ]
          },
          {
            'name': 'Credit Card',
            'amount': 75.0,
            'dueDate': 25,
            'paid': false,
            'allocated': 0.0,
            'balance': 2500.0,
            'interest': '18% APR'
          }
        ]
      };
    });

    _loadFromSharedPreferences();
  }

  // Handle expense selection
  void handleExpenseSelect(String category, int index) {
    setState(() {
      selectedExpenses[category] = index;
    });
  }

  // Handle allocation
  void handleAllocation(String category) {
    final inputValue = allocationControllers[category]!.text;
    var amount = inputValue.isEmpty ? 0.0 : double.parse(inputValue);

    if (amount <= 0) return;

    amount = min(amount, unallocated);

    setState(() {
      unallocated -= amount;

      switch (category) {
        case 'essentials':
          final selectedEssentialIndex = selectedExpenses['essentials']!;
          final items = List<Map<String, dynamic>>.from(essentials['items']);

          items[selectedEssentialIndex]['allocated'] =
              (items[selectedEssentialIndex]['allocated'] as double) + amount;

          String name = items[selectedEssentialIndex]['name'];
          if (name == "Subs & Memberships") {
            name = "Subscriptions & Memberships";
          }
          if (essentialsExpenseSpending.containsKey(name)) {
            essentialsExpenseSpending[name] =
                essentialsExpenseSpending[name] + amount;
          } else {
            essentialsExpenseSpending[name] = amount;
          }

          essentials['allocated'] =
              (essentials['allocated'] as double) + amount;
          essentials['items'] = items;

          break;

        case 'goal':
          goal['allocated'] = (goal['allocated'] as double) + amount;
          goal['progress'] =
              ((goal['allocated'] as double) / (goal['target'] as double)) *
                  100;
          if (goal['progress'] > 100) goal['progress'] = 100.0;
          break;

        case 'debt':
          final selectedDebtIndex = selectedExpenses['debt']!;
          final items = List<Map<String, dynamic>>.from(debt['items']);
          items[selectedDebtIndex]['allocated'] =
              (items[selectedDebtIndex]['allocated'] as double) + amount;

          debt['allocated'] = (debt['allocated'] as double) + amount;
          debt['items'] = items;
          break;
      }

      // Clear input after allocation
      allocationControllers[category]!.clear();
    });

    // Save to SharedPreferences
    _saveToSharedPreferences();
  }

  // Handle loan plan change
  void handleLoanPlanChange(String planName) {
    final debtItems = List<Map<String, dynamic>>.from(debt['items']);
    final plans = List<Map<String, dynamic>>.from(debtItems[0]['plans']);

    final selectedPlan = plans.firstWhere(
      (plan) => plan['name'].toString().toLowerCase() == planName.toLowerCase(),
      orElse: () => <String, dynamic>{},
    );

    if (selectedPlan.isNotEmpty) {
      setState(() {
        debtItems[0]['plan'] = planName.toLowerCase();
        debtItems[0]['amount'] = selectedPlan['amount'];
        debt['items'] = debtItems;
      });

      // Update calendar event for student loan
      _updateCalendarEvent(
          'Student Loan', selectedPlan['amount'], debtItems[0]['dueDate']);

      // Save to SharedPreferences
      _saveToSharedPreferences();
    }
  }

  void _updateCalendarEvent(String name, double amount, int dueDate) {
    _getSharedPreferences().then((prefs) {
      final String calendarEventsJson =
          prefs.getString('calendarEvents') ?? '[]';
      final List<dynamic> calendarEvents = jsonDecode(calendarEventsJson);

      final eventIndex =
          calendarEvents.indexWhere((event) => event['name'] == name);

      if (eventIndex >= 0) {
        calendarEvents[eventIndex] = {
          'name': name,
          'amount': amount,
          'dueDate': dueDate
        };
      } else {
        calendarEvents
            .add({'name': name, 'amount': amount, 'dueDate': dueDate});
      }

      prefs.setString('calendarEvents', jsonEncode(calendarEvents));
    });
  }

  // Reset all allocations
  void handleReset() {
    setState(() {
      essentialsExpenseSpending = {};
      cashOnHand = widget.widget.widget.checkingAccountBalance;
      unallocated = widget.widget.widget.checkingAccountBalance;


      essentials = {
        'items': functions.EssentialExpenses(widget.widget,widget.widget.widget.expenses),
        'allocated': functions.EssentialExpensesTotal(widget.widget),
      };

      goal = {
        'allocated': 0.0,
        'target': 2500.0,
        'monthlyTarget': 833.0,
        'dueDate': 18,
        'paid': false,
        'progress': 0.0
      };

      final debtItems = List<Map<String, dynamic>>.from(debt['items']);
      final currentPlan = debtItems[0]['plan'];
      final plans = List<Map<String, dynamic>>.from(debtItems[0]['plans']);
      final planDetails = plans.firstWhere(
        (p) =>
            p['name'].toString().toLowerCase() ==
            currentPlan.toString().toLowerCase(),
        orElse: () => {'amount': 250.0},
      );

      debt = {
        'allocated': 0.0,
        'items': [
          {
            'name': 'Student Loan',
            'amount': planDetails['amount'],
            'dueDate': 12,
            'paid': false,
            'allocated': 0.0,
            'plan': currentPlan ?? 'standard',
            'plans': [
              {
                'name': 'Standard',
                'amount': 250.0,
                'interest': '5%',
                'term': '10 years'
              },
              {
                'name': 'Extended',
                'amount': 150.0,
                'interest': '5.5%',
                'term': '15 years'
              },
              {
                'name': 'Graduated',
                'amount': 100.0,
                'interest': '5.25%',
                'term': '10 years'
              }
            ]
          },
          {
            'name': 'Credit Card',
            'amount': 75.0,
            'dueDate': 25,
            'paid': false,
            'allocated': 0.0,
            'balance': 2500.0,
            'interest': '18% APR'
          }
        ]
      };

      // Reset inputs
      allocationControllers.forEach((key, controller) {
        controller.clear();
      });
    });

    // Save to SharedPreferences
    _saveToSharedPreferences();
  }

  void handleSubmit() {
    if (essentialsExpenseSpending != null &&
        essentialsExpenseSpending.isNotEmpty) {
      for (String name in essentialsExpenseSpending.keys) {
        if (name == "Rent") {
          widget.widget.widget.rentThisMonth += essentialsExpenseSpending[name];
        } else if (name == "Subscriptions & Memberships") {
          widget.widget.widget.subsAndMembershipsThisMonth +=
              essentialsExpenseSpending[name];
        } else if (name == "Groceries") {
          widget.widget.widget.groceriesThisMonth +=
              essentialsExpenseSpending[name];
        } else if (name == "Utilities") {
          widget.widget.widget.utilitiesThisMonth +=
              essentialsExpenseSpending[name];
        } else if (name == "Transportation") {
          widget.widget.widget.transportationThisMonth +=
              essentialsExpenseSpending[name];
        }
        setState(() {
          widget.widget.spendOnExpense(essentialsExpenseSpending[name], name);
          widget.widget.widget.checkingAccountBalance -=
              essentialsExpenseSpending[name];
          Transaction transaction = Transaction(
              name: "$name Paid",
              day: widget.widget.widget.now,
              amount: -essentialsExpenseSpending[name],
              toOrFrom: "Transfer out",
              account: "Checking",
              currentAmount: widget.widget.widget.checkingAccountBalance);
          widget.widget.widget.Transactions.add(transaction);
        });
      }

      setState(() {
        essentialsExpenseSpending = {};
        cashOnHand = widget.widget.widget.checkingAccountBalance;
      });
    }

    final finalBudget = {
      'essentials': essentials,
      'goal': goal,
      'debt': debt,
      'date': currentDate.toIso8601String()
    };
  }

  // Find next upcoming expenses
  Map<String, dynamic> getNextExpenses() {
    final day = currentDate.day;
    List<Map<String, dynamic>> nextExpenses = [];
    int minDaysAway = 31;

    // Helper function to check and add expenses
    void checkAndAddExpense(Map<String, dynamic> expense, String category) {
      final daysAway = expense['dueDate'] >= day
          ? expense['dueDate'] - day
          : expense['dueDate'] + 30 - day;

      if (daysAway < minDaysAway) {
        // Found a closer expense, clear array and add this one
        minDaysAway = daysAway;
        nextExpenses = [
          {'category': category, ...expense}
        ];
      } else if (daysAway == minDaysAway) {
        // Same day as current closest, add to array
        nextExpenses.add({'category': category, ...expense});
      }
    }

    // Check essentials
    final essentialItems = List<Map<String, dynamic>>.from(essentials['items']);
    essentialItems.forEach((item) {
      if (!(item['paid'] as bool)) {
        checkAndAddExpense(item, 'essentials');
      }
    });

    // Check goal
    if (!(goal['paid'] as bool)) {
      checkAndAddExpense({
        'name': 'Retirement Contribution',
        'amount': goal['monthlyTarget'],
        'dueDate': goal['dueDate']
      }, 'goal');
    }

    // Check debt
    final debtItems = List<Map<String, dynamic>>.from(debt['items']);
    debtItems.forEach((item) {
      if (!(item['paid'] as bool)) {
        checkAndAddExpense(item, 'debt');
      }
    });

    return {'expenses': nextExpenses, 'daysAway': minDaysAway};
  }

  // Calculate total due amounts
  double get essentialsDue {
    final items = List<Map<String, dynamic>>.from(essentials['items']);
    double x = items.fold(0, (sum, item) => sum + (item['amount'] as double));
    return items.fold(0, (sum, item) => sum + (item['amount'] as double));
  }

  double get goalDue => goal['monthlyTarget'] as double;

  double get debtDue {
    final items = List<Map<String, dynamic>>.from(debt['items']);
    return items.fold(0, (sum, item) => sum + (item['amount'] as double));
  }

  // Toggle panel expansion
  void togglePanel(String panel) {
    setState(() {
      expandedPanel = expandedPanel == panel ? null : panel;
    });
  }

  // Format currency
  String formatCurrency(double value) {
    return NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 0,
    ).format(value);
  }

  // Save data to SharedPreferences
  Future<void> _saveToSharedPreferences() async {
    final prefs = await _getSharedPreferences();

    await prefs.setString(
        "essentialsExpenseSpending", jsonEncode(essentialsExpenseSpending));

    final budgetData = {
      'essentials': essentials,
      'goal': goal,
      'debt': debt,
      'unallocated': unallocated,
      'cashOnHand': cashOnHand,
      'creditScore': creditScore
    };

    await prefs.setString('budgetData', jsonEncode(budgetData));
  }

  // Load data from SharedPreferences
  Future<void> _loadFromSharedPreferences() async {
    final prefs = await _getSharedPreferences();

    final savedData = prefs.getString('budgetData');
    final essentialsExpenseSpendingData =
        prefs.getString('essentialsExpenseSpending');


    if (savedData != null) {
      final Map<String, dynamic> parsedData = jsonDecode(savedData);

      setState(() {
        essentials = parsedData['essentials'];
        goal = parsedData['goal'];
        debt = parsedData['debt'];
        unallocated = parsedData['unallocated'];
        cashOnHand = parsedData['cashOnHand'];
        creditScore = parsedData['creditScore'];
        essentialsExpenseSpending = jsonDecode(essentialsExpenseSpendingData!);
      });
    }
  }

  Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final nextExpensesData = getNextExpenses();
    final nextExpenses =
        List<Map<String, dynamic>>.from(nextExpensesData['expenses']);
    final daysAway = nextExpensesData['daysAway'] as int;

    return Scaffold(
      body: Container(
        color: Colors.grey[800]?.withOpacity(0.5),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF007FFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Colors.white),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat('MMMM d, yyyy').format(currentDate),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.attach_money,
                                  color: Colors.white),
                              const SizedBox(width: 4),
                              Text(
                                'Cash on Hand: ${formatCurrency(cashOnHand)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ' (${formatCurrency(unallocated)} unallocated)',
                                style: TextStyle(
                                  color: Colors.blue[100],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Next expense alert
                      if (nextExpenses.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.amber[50],
                            border: Border.all(color: Colors.amber[200]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.amber[500],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Next due${nextExpenses.length > 1 ? ' (multiple)' : ''}:',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    ...nextExpenses
                                        .map((expense) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  widget
                                                                  .widget
                                                                  .widget
                                                                  .nextExpense
                                                                  .dueDay
                                                                  .year >
                                                              2025 ==
                                                          ""
                                                      ? Text(
                                                          "No More Payments This Month",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        )
                                                      : Text(
                                                          widget
                                                                      .widget
                                                                      .widget
                                                                      .nextExpense
                                                                      .dueDay
                                                                      .difference(widget
                                                                          .widget
                                                                          .widget
                                                                          .now)
                                                                      .inDays ==
                                                                  0
                                                              ? "${widget.widget.widget.nextExpense.name} Today"
                                                              : widget
                                                                          .widget
                                                                          .widget
                                                                          .nextExpense
                                                                          .dueDay
                                                                          .difference(widget
                                                                              .widget
                                                                              .widget
                                                                              .now)
                                                                          .inDays ==
                                                                      1
                                                                  ? "${widget.widget.widget.nextExpense.name} in ${widget.widget.widget.nextExpense.dueDay.difference(widget.widget.widget.now).inDays} day"
                                                                  : widget.widget.widget.nextExpense
                                                                              .dueDay
                                                                              .difference(widget.widget.widget.now)
                                                                              .inDays >
                                                                          35
                                                                      ? "No More Required Payments This Month"
                                                                      : "${widget.widget.widget.nextExpense.name}  in ${widget.widget.widget.nextExpense.dueDay.difference(widget.widget.widget.now).inDays} days",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                // Main content
                Flexible(
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 400),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildPanel(
                            title: 'Essentials',
                            subtitle: 'Basic living expenses',
                            allocated: essentials['allocated'],
                            due: essentialsDue,
                            panelName: 'essentials',
                            content: Column(
                              children: [
                                ...(essentials['items'] as List)
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final index = entry.key;
                                  final item = entry.value;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              item['name'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              ' (Due: ${item['dueDate']}th)',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${formatCurrency(item['allocated'])} / ${formatCurrency(item['amount'])}',
                                          style: TextStyle(
                                            color: item['allocated'] >=
                                                    item['amount']
                                                ? const Color(0xFF00C781)
                                                : const Color(0xFF007FFF),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                const Divider(),
                                const SizedBox(height: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Select expense:',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    DropdownButtonFormField<int>(
                                      value: selectedExpenses['essentials'],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                      ),
                                      items: (essentials['items'] as List)
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final item = entry.value;
                                        return DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(
                                            '${item['name']} (${formatCurrency(item['amount'])})',
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          handleExpenseSelect(
                                              'essentials', value);
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: allocationControllers[
                                                'essentials'],
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  bottomLeft:
                                                      Radius.circular(4),
                                                ),
                                              ),
                                              hintText:
                                                  'Enter amount to allocate',
                                            ),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              TextInputFormatter.withFunction(
                                                (oldValue, newValue) {
                                                  final text = newValue.text;
                                                  if (text.isEmpty) {
                                                    return newValue;
                                                  }
                                                  final value =
                                                      double.tryParse(text);
                                                  if (value == null) {
                                                    return oldValue;
                                                  }
                                                  final selectedEssentialIndex =
                                                      selectedExpenses[
                                                          'essentials']!;
                                                  final items = List<
                                                          Map<String,
                                                              dynamic>>.from(
                                                      essentials['items']);
                                                  final selectedItem = items[
                                                      selectedEssentialIndex];
                                                  final maxAmount = min<double>(
                                                      widget.widget.widget
                                                              .checkingAccountBalance
                                                          as double,
                                                      (selectedItem['amount'] -
                                                              selectedItem[
                                                                  'allocated'])
                                                          as double);

                                                  if (value > maxAmount) {
                                                    return oldValue;
                                                  }
                                                  return newValue;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: TextButton(
                                            onPressed: () =>
                                                handleAllocation('essentials'),
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF007FFF),
                                              shape:
                                                   RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 16),
                                            ),
                                            child: Text(
                                              'Allocate',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Most people prioritize Essentials first',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Goal (Retirement) Panel
                          _buildPanel(
                            title: 'Goal (Retirement)',
                            subtitle:
                                'Target: ${formatCurrency(goal['target'])} in 3 months',
                            allocated: goal['allocated'],
                            due: goalDue,
                            panelName: 'goal',
                            content: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Monthly Contribution',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Due: ${goal['dueDate']}th - ${formatCurrency(goal['monthlyTarget'])}',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Progress',
                                            style: TextStyle(fontSize: 14)),
                                        Text(
                                            '${goal['progress'].toStringAsFixed(0)}%',
                                            style:
                                                const TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: goal['progress'] / 100,
                                        backgroundColor: Colors.grey[200],
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Color(0xFF007FFF)),
                                        minHeight: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 32),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            allocationControllers['goal'],
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4),
                                            ),
                                          ),
                                          hintText: 'Enter amount to allocate',
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    TextButton(
                                      onPressed: () => handleAllocation('goal'),
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF007FFF),
                                        shape:  RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 16),
                                      ),
                                      child: const Text(
                                        'Allocate',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                if (goal['allocated'] < goal['monthlyTarget'])
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      'Contributing extra next month could help you reach your goal',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: const Color(0xFFF33434),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Debt Panel
                          _buildPanel(
                            title: 'Debt',
                            subtitle: 'Loan & credit card payments',
                            allocated: debt['allocated'],
                            due: debtDue,
                            panelName: 'debt',
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Student Loan
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Student Loan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              ' (Due: ${debt['items'][0]['dueDate']}th)',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${formatCurrency(debt['items'][0]['allocated'])} / ${formatCurrency(debt['items'][0]['amount'])}',
                                          style: TextStyle(
                                            color: debt['items'][0]
                                                        ['allocated'] >=
                                                    debt['items'][0]['amount']
                                                ? const Color(0xFF00C781)
                                                : const Color(0xFF007FFF),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Loan Plan Options:',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 2.5,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 8,
                                            ),
                                            itemCount: (debt['items'][0]
                                                    ['plans'] as List)
                                                .length,
                                            itemBuilder: (context, idx) {
                                              final plan = debt['items'][0]
                                                  ['plans'][idx];
                                              final isSelected = debt['items']
                                                      [0]['plan'] ==
                                                  plan['name']
                                                      .toString()
                                                      .toLowerCase();

                                              return GestureDetector(
                                                onTap: () =>
                                                    handleLoanPlanChange(
                                                        plan['name']),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? const Color(
                                                            0xFFE6F5FF)
                                                        : Colors.white,
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? const Color(
                                                              0xFF007FFF)
                                                          : Colors.grey[300]!,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        plan['name'],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        '${formatCurrency(plan['amount'])}/month',
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        '${plan['interest']} for ${plan['term']}',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey[600]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Credit Card
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Credit Card',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              ' (Due: ${debt['items'][1]['dueDate']}th)',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${formatCurrency(debt['items'][1]['allocated'])} / ${formatCurrency(debt['items'][1]['amount'])}',
                                          style: TextStyle(
                                            color: debt['items'][1]
                                                        ['allocated'] >=
                                                    debt['items'][1]['amount']
                                                ? const Color(0xFF00C781)
                                                : const Color(0xFF007FFF),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Current Balance:',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              Text(
                                                formatCurrency(debt['items'][1]
                                                    ['balance']),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Interest Rate:',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                              Text(
                                                debt['items'][1]['interest'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const Divider(height: 32),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Select debt:',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    DropdownButtonFormField<int>(
                                      value: selectedExpenses['debt'],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                      ),
                                      items: (debt['items'] as List)
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final item = entry.value;
                                        return DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(
                                            '${item['name']} (${formatCurrency(item['amount'])})',
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          handleExpenseSelect('debt', value);
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller:
                                                allocationControllers['debt'],
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  bottomLeft:
                                                      Radius.circular(4),
                                                ),
                                              ),
                                              hintText:
                                                  'Enter amount to allocate',
                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        TextButton(
                                          onPressed: () =>
                                              handleAllocation('debt'),
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF007FFF),
                                            shape:  RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5)
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 16),
                                          ),
                                          child: const Text(
                                            'Allocate',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Metrics & Feedback Area
                
                Container(
                  width: double.infinity,
                  padding:  EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border(
                      top: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Center(child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildMetricItem(
                        icon: Icons.account_balance_wallet,
                        label: 'Unallocated',
                        value: formatCurrency(unallocated),
                        color: const Color(0xFF00C781),
                      ),
                      _buildMetricItem(
                        icon: Icons.trending_up,
                        label: 'Retirement Progress',
                        value:
                            '${formatCurrency(goal['allocated'])} / ${formatCurrency(goal['target'])}',
                        color: const Color(0xFF007FFF),
                      ),
                      _buildMetricItem(
                        icon: Icons.credit_card,
                        label: 'Credit Score',
                        value: creditScore.toString(),
                        color: const Color(0xFF007FFF),
                      ),
                      _buildMetricItem(
                        icon: Icons.attach_money,
                        label: 'Debt Paydown',
                        value:
                            '${formatCurrency(debt['allocated'])} This Month',
                        color: const Color(0xFFF33434),
                      ),
                    ],
                  ),)
                  
                  
                ),

                // Action Buttons
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: handleReset,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        icon: const Icon(Icons.refresh,
                            size: 18, color: Colors.grey),
                        label: const Text(
                          'Reset Allocations',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: handleSubmit,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          backgroundColor: const Color(0xFF00C781),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        icon: const Icon(Icons.check_circle, size: 18, color: Colors.white,),
                        label: const Text('Submit Budget', style: TextStyle(color: Colors.white,),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPanel({
    required String title,
    required String subtitle,
    required double allocated,
    required double due,
    required String panelName,
    required Widget content,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => togglePanel(panelName),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${formatCurrency(allocated)} / ${formatCurrency(due)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: allocated < due
                              ? const Color(0xFFF33434)
                              : const Color(0xFF00C781),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          expandedPanel == panelName ? '↑' : '↓',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (expandedPanel == panelName)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[100]!),
                ),
              ),
              child: content,
            ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers when widget is removed
    allocationControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }
}
