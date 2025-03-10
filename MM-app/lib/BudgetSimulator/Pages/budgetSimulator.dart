import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/functions.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/allocateFunding.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/allocateFundingButton.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/baseSideOfScreen.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/baseTopOfScreen.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/eventPopUp.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/expenseLabel.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/headings2.dart';
import 'package:intl/intl.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/creditScoreBox.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/milestoneProgress.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/randomEvent.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/spendingChart.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/bottomHint.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/tableCalender.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/weekdayRow.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/welnessBox.dart';
import 'package:money_monkey/PortfolioPages/portfolio_screen.dart';
import 'package:money_monkey/Profile/profile_page.dart';
import 'package:money_monkey/home.dart';
import 'package:table_calendar/table_calendar.dart';

class BudgetSimulator extends StatefulWidget {
  BudgetSimulator({
    super.key,
    required this.name,
    required this.level,
    required this.checkingAccountBalance,
    required this.savingsAccountBalance,
    required this.creditCardDebt,
    required this.startingBalance,
    required this.savingsAPY,
    required this.ccAPY,
    required this.milestones,
    required this.creditScore,
    required this.expenses,
    required this.wellnessScore,
    required this.randomEvents,
    required this.hints,
    required this.emotionalScore,
    required this.physicalScore,
    required this.mentalScore,
  });
  double savingsTransfer = 0;
  int checkingTransfer = 0;

  final String name;
  int emotionalScore;
  int physicalScore;
  int mentalScore;
  final String level;

  double checkingAccountBalance;
  double savingsAccountBalance;
  double creditCardDebt;
  List<Hint> hints;
  int wellnessScore;
  final double startingBalance;
  final double savingsAPY;
  final double ccAPY;
  List<Milestone> milestones;
  double creditScore;
  List<Expense> expenses;
  List<RandomEvent> randomEvents;
  late Expense nextExpense = expenses[0];



  State<BudgetSimulator> createState() => _BudgetSimulatorState();
}

class _BudgetSimulatorState extends State<BudgetSimulator> {


  @override
  void initState() {
    mapExpenses();
    filterPayDays();
    super.initState();
    netCash = widget.startingBalance;
    formattedDate = DateFormat('MMM d, y').format(_focusedDay);
    getProgress();
    getExpenses();
    getUniqueWeekCountForMonth(_focusedDay.year, _focusedDay.month);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getEvents();
    });
    getStartingExpenses();
    setState(() {
      colors = functions.colors;
      chartData = functions.getChartData(types, percentage, colors);
    });
    alocateEvents();
    setState(() {
      var data = functions.updateNextExpense(widget.expenses, now);
      expenses = data['expenses'];
      widget.nextExpense = data['nextExpense'];
    });
  }

  List<BudgetSimulatorChartData> chartData = [];
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeightUnit = screenHeight / 1406;
    double screenWidthUnit = screenWidth / 2079;
    return Container(
      height: screenHeight,
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          BaseSideOfScreen(screenHeight: screenHeight, screenWidthUnit: screenWidthUnit, screenHeightUnit: screenHeightUnit),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseTopOfScreen(screenHeight: screenHeight, screenWidthUnit: screenWidthUnit, screenHeightUnit: screenHeightUnit, name: widget.name),

              FittedBox(
                child: Container(
                  width: screenWidthUnit * 1919,
                  height: screenHeight - (screenHeightUnit * 70),
                  color: Color.fromRGBO(135, 206, 235, 1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeightUnit * 25,
                      ),
                      Center(
                        child: Container(
                            width: screenWidthUnit * 1871,
                            height: screenHeightUnit * 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: widget.name == "Crush the Credit Card Debt"
                                  ? headings2.crushTheCreditCardDebtHeading(
                                      savingsLeftOver: savingsLeftOver,
                                      checkingAccountBalance:
                                          widget.checkingAccountBalance,
                                      savingsAccountBalance:
                                          widget.savingsAccountBalance,
                                      creditCardDebt: widget.creditCardDebt,
                                      netCash: widget.checkingAccountBalance +
                                          widget.savingsAccountBalance,
                                      screenWidthUnit: screenWidthUnit,
                                      screenHeightUnit: screenHeightUnit * .9,
                                      APY: widget.savingsAPY,
                                      checkingTransfer: widget.checkingTransfer as double,
                                      savingsTransfer: widget.savingsTransfer as double,
                                    )
                                  : Container(),
                            )),
                      ),
                      SizedBox(
                        height: screenHeightUnit * 19,
                      ),
                      Center(
                          child: Container(
                        width: screenWidthUnit * 1871,
                        height: screenHeightUnit * 1170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: screenHeightUnit * 1170,
                              width: screenWidthUnit * 1360,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: screenHeightUnit * 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screenWidthUnit * 67,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Budget Simulator",
                                              style: GoogleFonts.baloo2(
                                                fontSize: screenWidthUnit * 28,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeightUnit * 10,
                                            ),
                                            Text(formattedDate,
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      108, 108, 108, 1),
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          width: screenWidthUnit * 810,
                                        ),
                                        AllocateFundsButton(
                                          now : now,
                                          spendOnExpense: spendOnExpense,
                                          screenWidthUnit: screenWidthUnit,
                                          screenHeightUnit: screenHeightUnit,
                                          checkingTransfer:
                                              checkingTransfer as int,
                                          getInterestSavings:
                                              getInterestSavings,
                                          setStateCallback: setState,
                                          widget: widget,
                                          functions: functions,
                                          expenses: expenses,
                                          nextExpense: widget.nextExpense,
                                          getEvents: getEvents,
                                          checkRandomEvents: checkRandomEvents,
                                          savingsTransfer: savingsTransfer,
                                          monthlyEntertainment: monthlyEntertainment,
                                          monthlyFitness: monthlyFitness,
                                          monthsOccurd: monthsOccurd,
                                          daysUnderLuxary: daysUnderLuxary,
                                          daysUnderLuxaryDone: daysUnderLuxaryDone, toLuxaryForWeek: toLuxaryForWeek, recalculatePercentages: recalculatePercentages, nextDay: nextDay, mapExpenses: mapExpenses

                                          
                                          
                                        ),
                                      ],
                                    ),
                                    WeekdayRow(
                                      screenWidthUnit: screenWidthUnit,
                                      screenHeightUnit: screenHeightUnit,
                                    ),
                                    BudgetSimulatorCalender(
                                        screenWidthUnit: screenWidthUnit,
                                        screenHeightUnit: screenHeightUnit,
                                        focusedDay: _focusedDay,
                                        now: now,
                                        selectedDay: _selectedDay,
                                        expenses: widget.expenses,
                                        formattedDate: formattedDate,
                                        smallBoxes: smallBoxes),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: screenHeightUnit * 15),
                                      child: Center(
                                        child: Bottomwarning(
                                          screenHeightUnit:
                                              screenHeightUnit * 1.1,
                                          screenWidthUnit: screenWidthUnit,
                                          hints: widget.hints,
                                          nextExpense: widget.nextExpense,
                                          dayNumber: dayNumber,
                                          baseDate: now,
                                          close: () {
                                            setState(() {
                                              widget.hints.removeAt(0);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            SingleChildScrollView(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MilestoneProgress(
                                  milestones: widget.milestones,
                                  screenWidthUnit: screenWidthUnit,
                                  screenHeightUnit: screenHeightUnit,
                                  startingDebt: startingDebt,
                                  currentDebt: widget.creditCardDebt as int,
                                ),
                                SizedBox(
                                  height: screenHeightUnit * 20,
                                ),
                                // WellnessBoxNew(
                                //     screenHeightUnit: screenHeightUnit,
                                //     screenWidthUnit: screenWidthUnit,
                                //     score: widget.physicalScore,
                                //     type: "Physical"),
                                //      SizedBox(
                                //   height: screenHeightUnit * 20,
                                // ),
                                // WellnessBoxNew(
                                //     screenHeightUnit: screenHeightUnit,
                                //     screenWidthUnit: screenWidthUnit,
                                //     score: widget.emotionalScore,
                                //     type: "Emotional"),
                                //      SizedBox(
                                //   height: screenHeightUnit * 20,
                                // ),
                                // WellnessBoxNew(
                                //     screenHeightUnit: screenHeightUnit,
                                //     screenWidthUnit: screenWidthUnit,
                                //     score: widget.mentalScore,
                                //     type: "Mental"),

                                // SizedBox(
                                //   height: screenHeightUnit * 20,
                                // ),
                                MeterBox(
                                  screenHeightUnit: screenHeightUnit,
                                  screenWidthUnit: screenWidthUnit,
                                  creditScore: widget.creditScore as int,
                                ),
                                SizedBox(
                                  height: screenHeightUnit * 20,
                                ),
                                WellnessBox(
                                  screenHeightUnit: screenHeightUnit,
                                  screenWidthUnit: screenWidthUnit,
                                  wellnessScore: widget.wellnessScore,
                                ),
                                SizedBox(
                                  height: screenHeightUnit * 20,
                                ),
                                SpendingDonutChart(
                                  screenWidthUnit: screenWidthUnit,
                                  screenHeightUnit: screenHeightUnit,
                                  types: types,
                                  percentage: percentage,
                                  total: totalSpending,
                                  chartData: chartData,
                                ),
                                SizedBox(
                                  height: screenHeightUnit * 20,
                                ),
                              ],
                            ))
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

    List<Color> colors = [];
  late double netCash;
  final Headings2 headings2 = Headings2();
  DateTime now = DateTime(2025, 5, 1);
  DateTime _focusedDay = DateTime(2025, 5, 1);
  DateTime _selectedDay = DateTime(2025, 5, 1);
  String formattedDate = '';
  int progress = 0;
  List<String> types = [];
  List<double> percentage = [];
  BudgetSimulatorFunctions functions = BudgetSimulatorFunctions();
  double totalSpending = 0;
  bool smallBoxes = true;
  double wellnessScore = 600;
  int checkingAccountBalance = 600;
  bool eventProccesed = false;
  double checkingTransfer = 0;
  double savingsTransfer = 0;
  int monthlyFitness = 0;
  int monthlyEntertainment = 0;
  int toLuxaryForWeek = 0;
  int daysUnderLuxary = 0;
  bool daysUnderLuxaryDone = false;
  final Map<DateTime, List<Expense>> expensesMapped = {};
  List<Expense> expenses = [];
  int startingDebt = 1;
  int startingRent = 1;
  int startingCCMin = 1;
  int startingUtilites = 1;
  int startingTransportaion = 100;
  int startingGroceries = 250;
  List<Expense> trueExpenses = [];

  bool noLatePayments = true;

  int monthsOccurd = 0;

  Future<void> nextMonth() async {
    if (monthsOccurd < 2) {
      for (Expense expense in widget.expenses) {
        if (expense.name == "Pay Day") {
          setState(() {
            expense.dueDay = DateTime(expense.dueDay.year,
                expense.dueDay.month + 1, expense.dueDay.day);
          });
        } else if (expense.name == "Transportation") {
          setState(() {
            expense.amount += startingTransportaion;
          });
        } else if (expense.name == "Groceries") {
          setState(() {
            expense.amount += startingGroceries;
          });
        } else if (expense.name == "Rent") {
          setState(() {
            expense.amount += startingRent;
            expense.dueDay = DateTime(expense.dueDay.year,
                expense.dueDay.month + 1, expense.dueDay.day);
          });
        } else if (expense.name == "CC Debt") {
          setState(() {
            expense.amount += startingCCMin;
            expense.dueDay = DateTime(expense.dueDay.year,
                expense.dueDay.month + 1, expense.dueDay.day);
          });
        } else if (expense.name == "Utilities") {
          setState(() {
            expense.amount += startingCCMin;
            expense.dueDay = DateTime(expense.dueDay.year,
                expense.dueDay.month + 1, expense.dueDay.day);
          });
        }
      }
    }
    setState(() {
      monthsOccurd += 1;
    });
    if (noLatePayments) {
      setState(() {
        widget.creditScore += 10;
      });
    }
    setState(() {
      noLatePayments = true;
    });
    mapExpenses();
  }

  Future<void> endGame() async {
    // Credit Score
  }

  int dayNumber = 1;

  Future<void> nextDay() async {
   

    if (now.month != now.add(Duration(days: 1)).month) {
      getInterestCCDebt();
      nextMonth();
    }

    setState(() {
      now = now.add(Duration(days: 1));
      _focusedDay = now;
      _selectedDay = now;
      formattedDate = DateFormat('MMM d, y').format(_focusedDay);
      dayNumber += 1;
    });

    if (now.day == 2) {
      if (!functions.checkIfPaymentIsPaid("Rent", widget.expenses)) {
        setState(() {
          widget.hints = functions.addHint(
              "Rent", widget.hints, now, widget.level, widget.name);
        });
      }
    } else if (now.day == 8) {
      if (!functions.checkIfPaymentIsPaid("Utilities", widget.expenses)) {
        setState(() {
          widget.hints = functions.addHint(
              "Utilities", widget.hints, now, widget.level, widget.name);
        });
      }
    } else if (now.day == 16) {
      for (Milestone milestone in widget.milestones) {
        if (milestone.name == "Two Weeks Under Budget") {
          if (milestone.currentAmount < 7) {
            setState(() {
              widget.hints = functions.addHint("Two Weeks Under Budget",
                  widget.hints, now, widget.level, widget.name);
            });
          }
        } else if (milestone.name == "Debt Avalanche Start") {
          if (milestone.currentAmount / milestone.goalAmount < 0.5 &&
              now.month == 5) {
            setState(() {
              widget.hints = functions.addHint("Debt Avalanche Start",
                  widget.hints, now, widget.level, widget.name);
            });
          }
        }
      }
    } else if (now.day == 24) {
      if (!functions.checkIfPaymentIsPaid("CC Debt", widget.expenses)) {
        setState(() {
          widget.hints = functions.addHint(
              "CC Min", widget.hints, now, widget.level, widget.name);
        });
      }
      for (Milestone milestone in widget.milestones) {
        if (milestone.name == "Two Weeks Under Budget") {
          if (milestone.currentAmount < 2) {
            setState(() {
              widget.hints = functions.addHint("Two Weeks Under Budget",
                  widget.hints, now, widget.level, widget.name);
            });
          }
        }
      }
    } else if ((now.month == 2 && now.day == 27) ||
        (now.month != 2 && now.day == 29)) {
      setState(() {
        widget.hints = functions.addHint(
            "End of Month", widget.hints, now, widget.level, widget.name);
      });
    }
  }

  Future<void> getEvents() async {
    DateTime normalizedToday = normalizeDate(now);
    if (expensesMapped.containsKey(normalizedToday)) {
      List<Expense> todayExpenses = expensesMapped[normalizedToday]!;
      for (Expense expense in todayExpenses) {
        if (expense.name == "Pay Day") {
          setState(() {
            widget.hints = functions.addHint(
                "Pay Day", widget.hints, now, widget.level, widget.name);
          });

          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return EventPopUp(
                expense: expense,
                onTouch: () {
                  setState(() {
                    widget.checkingAccountBalance -= expense.amount;
                    eventProccesed = true;
                    Navigator.of(context).pop();
                   
                  });
                },
              );
            },
          );
          if (!eventProccesed) {
            setState(() {
              widget.checkingAccountBalance -= expense.amount as int;
              eventProccesed = true;
            });
            
          }
        } else if (expense.name == "Rent") {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return EventPopUp(
                expense: expense,
                onTouch: () {
                  expense.amountPaid >= expense.amount
                      ? setState(() {
                          eventProccesed = true;
                          Navigator.of(context).pop();
                        })
                      : setState(() {
                          expense.amount += expense.penalty;
                          widget.creditScore -= 10;
                          noLatePayments = false;
                          eventProccesed = true;
                          Navigator.of(context).pop();
                        });
                },
              );
            },
          );
          if (!eventProccesed) {
            if (expense.amountPaid < expense.amount) {
              setState(() {
                expense.amount += expense.penalty;
                widget.creditScore -= 10;
                noLatePayments = false;
              });
            }
            setState(() {
              eventProccesed = true;
            });
          }
        } else if (expense.name == "CC Debt") {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return EventPopUp(
                expense: expense,
                onTouch: () {
                  expense.amountPaid >= expense.amount
                      ? setState(() {
                          eventProccesed = true;
                          Navigator.of(context).pop();
                        })
                      : setState(() {
                          expense.amount += expense.penalty;
                          widget.creditCardDebt += expense.penalty;
                          widget.creditScore -= 10;
                          noLatePayments = false;
                          eventProccesed = true;
                          Navigator.of(context).pop();
                        });
                },
              );
            },
          );
          if (!eventProccesed) {
            if (expense.amountPaid < expense.amount) {
              setState(() {
                expense.amount += expense.penalty;
                widget.creditCardDebt += expense.penalty;
                widget.creditScore -= 10;
                noLatePayments = false;
              });
            }
            setState(() {
              eventProccesed = true;
            });
          }
        } else if (expense.name == "Utilities") {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return EventPopUp(
                expense: expense,
                onTouch: () {
                  expense.amountPaid >= expense.amount
                      ? setState(() {
                          eventProccesed = true;
                          Navigator.of(context).pop();
                        })
                      : setState(() {
                          expense.amount += expense.penalty;
                          widget.creditScore -= 10;
                          noLatePayments = false;
                          eventProccesed = true;
                          Navigator.of(context).pop();
                        });
                },
              );
            },
          );
          if (!eventProccesed) {
            if (expense.amountPaid < expense.amount) {
              setState(() {
                expense.amount += expense.penalty;
                widget.creditScore -= 10;
                noLatePayments = false;
              });
            }
            setState(() {
              eventProccesed = true;
            });
          }
        } else {
          print(expense.name);
        }
      }
    }
    setState(() {
      eventProccesed = false;
    });
  }

  Future<void> getUniqueWeekCountForMonth(int year, int month) async {
    final firstDayOfMonth = DateTime(year, month, 1);

    final lastDayOfMonth = DateTime(year, month + 1, 0);
    int mondays = 0;

    if (firstDayOfMonth.weekday != DateTime.monday) {
      mondays += 1;
    }

    for (int day = 2; day <= lastDayOfMonth.day; day++) {
      if (DateTime(year, month, day).weekday == DateTime.monday) {
        mondays += 1;
      }
    }
    if (mondays <= 5) {
      setState(() {
        smallBoxes = false;
      });
    }
  }

  void mapExpenses() {

    expensesMapped.clear();

    for (Expense expense in widget.expenses) {
      DateTime normalizedDate = normalizeDate(expense.dueDay);
      if (expensesMapped.containsKey(normalizedDate)) {
        expensesMapped[normalizedDate]!.add(expense);
      } else {
        expensesMapped[normalizedDate] = [expense];
      }
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  Future<void> spendOnExpense(int amount, String type) async {
    for (Expense expense in widget.expenses) {
      if (expense.name == type) {
        setState(() {
          expense.amountPaid += amount;
        });
        break;
      }
    }
  }

  recalculatePercentages() {
    totalSpending = 0;
    int i = 0;

    for (Expense expense in widget.expenses) {
      if (expense.name != "Pay Day") {
        setState(() {
          totalSpending += expense.amountPaid;
          i += 1;
        });
      }
    }

    List<double> newPercentage = [];
    for (Expense expense in widget.expenses) {
      if (expense.name != "Pay Day") {
        newPercentage.add((expense.amountPaid / totalSpending) * 100);
      }
    }
    setState(() {
      percentage = newPercentage;
      chartData = functions.getChartData(types, percentage, colors);
    });
  }

  Future<void> getExpenses() async {
    for (Expense expense in trueExpenses) {
      types.add(expense.name);
      totalSpending += expense.amountPaid;
    }
    for (Expense expense in trueExpenses) {
      setState(() {
        percentage.add((expense.amountPaid / totalSpending) * 100);
      });
    }
  }

  DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Future<void> filterPayDays() async {
    var filterdEvents =
        widget.expenses.where((element) => element.name != "Pay Day");
    setState(() {
      trueExpenses = filterdEvents.toList();
    });
  }

  Future<void> getProgress() async {
    int milestoneCount = widget.milestones.length;
    double totalProgress = 0;
    for (Milestone milestone in widget.milestones) {
      totalProgress += (milestone.currentAmount / milestone.goalAmount) * 100;
    }
    setState(() {
      progress = (totalProgress / milestoneCount).round();
    });
  }

  double savingsLeftOver = 0;

  void getInterestSavings() {
    if (widget.savingsAccountBalance > 0) {
      double dailyRate = pow(1 + (widget.savingsAPY / 100), 1 / 365) - 1;
      double interest = widget.savingsAccountBalance * dailyRate;
      setState(() {
        savingsLeftOver += interest;
      });

      if (savingsLeftOver >= 10) {
        setState(() {
          widget.savingsAccountBalance += 10;
          savingsLeftOver -= 10;
        });
      }
    }
  }

  void getInterestCCDebt() {
    double interest =
        widget.creditCardDebt * (pow(1 + (widget.ccAPY / 100), 1 / 12) - 1);
    int roundedInterest = (interest / 10).round() * 10;
    setState(() {
      widget.creditCardDebt += roundedInterest;
    });
    for (Expense expense in widget.expenses) {
      if (expense.name == "CC Debt") {
        setState(() {
          expense.amount += roundedInterest;
        });
      }
    }
  }

  Future<void> getStartingExpenses() async {
    setState(() {
      startingDebt = widget.creditCardDebt as int;
    });
    for (Expense expense in widget.expenses) {
      if (expense.name == "CC Debt") {
        setState(() {
          startingCCMin = expense.amount as int;
        });
      } else if (expense.name == "Rent") {
        setState(() {
          startingRent = expense.amount as int;
        });
      } else if (expense.name == "Utilities") {
        setState(() {
          startingUtilites = expense.amount as int;
        });
      } else if (expense.name == "Transportation") {
        setState(() {
          startingTransportaion = expense.amount as int;
        });
      } else if (expense.name == "Groceries") {
        startingGroceries = expense.amount as int;
      }
    }
  }

  List<RandomEvent> allocatedEvents = [];

  List<List<int>> dayRanges = [
    [4, 8],
    [18, 21],
    [25, 28],
    [37, 40],
    [43, 47],
    [52, 57],
    [61, 69],
    [72, 86]
  ];

  Future<void> alocateEvents() async {
    for (var range in dayRanges) {
      int randomDay = range[0] +
          (range[1] - range[0]) *
              (DateTime.now().millisecondsSinceEpoch % 100) ~/
              100;

      DateTime eventDay = now.add(Duration(days: randomDay));
      int randomIndex =
          (DateTime.now().millisecondsSinceEpoch % widget.randomEvents.length);
      RandomEvent? event = widget.randomEvents.isNotEmpty
          ? widget.randomEvents.removeAt(randomIndex)
          : null;

      if (event != null) {
        setState(() {
          event.trigerDay = eventDay;

          allocatedEvents.add(event);
        });
      }
    }
  }

  Future<void> checkRandomEvents() async {
    DateTime normalizedToday = normalizeDate(now);
    DateTime normalizedTodayPlusTwo = normalizedToday.add(Duration(days: 2));

    for (RandomEvent randomEvent in allocatedEvents) {
      if (isSameDay(normalizedToday, randomEvent.trigerDay)) {
        print(randomEvent.name);

        if (context.mounted) {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return WillPopScope(
                  onWillPop: () async => false,
                  child: Dialog(
                    child: RandomEventPop(
                      event: randomEvent,
                      onConfirm: (
                        String Source,
                        int amount,
                        String effect1,
                        int effect1Amount,
                        String effect2,
                        int effect2Amount,
                      ) {
                        Navigator.of(context).pop();
                        if (Source == "Cash") {
                          setState(() {
                            widget.checkingAccountBalance += amount;
                          });
                        } else if (Source == "CC") {
                          setState(() {
                            widget.creditCardDebt -= amount;
                          });
                        }

                        if (effect1 == "Credit Score") {
                          setState(() {
                            widget.creditScore += effect1Amount;
                          });
                        } else {
                          int x = widget.wellnessScore + effect1Amount;
                          setState(() {
                            widget.wellnessScore = min(x, 1000);
                            widget.wellnessScore = max(0, widget.wellnessScore);
                          });
                        }
                        if (effect2 == "Credit Score") {
                          setState(() {
                            widget.creditScore += effect2Amount;
                          });
                        } else {
                          int x = widget.wellnessScore + effect2Amount;
                          setState(() {
                            widget.wellnessScore = min(x, 1000);
                            widget.wellnessScore = max(0, widget.wellnessScore);
                          });
                        }
                      },
                    ),
                  ));
            },
          );
        }
      }

      if (isSameDay(normalizedTodayPlusTwo, randomEvent.trigerDay)) {
        setState(() {
          widget.hints = functions.addHint(
              randomEvent.name, widget.hints, now, widget.level, widget.name);
        });
      }
    }
  }
}
