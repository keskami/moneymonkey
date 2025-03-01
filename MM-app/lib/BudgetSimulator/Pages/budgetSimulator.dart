import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/functions.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/allocateFunding.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/eventPopUp.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/expenseLabel.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/headings2.dart';
import 'package:intl/intl.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/creditScoreBox.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/milestoneProgress.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/randomEvent.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/spendingChart.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/bottomHint.dart';
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

  State<BudgetSimulator> createState() => _BudgetSimulatorState();
}

class _BudgetSimulatorState extends State<BudgetSimulator> {
  late double netCash;
  final Headings2 headings2 = Headings2();
  DateTime now = DateTime(2025, 5, 1);
  DateTime _focusedDay = DateTime(2025, 5, 1);
  DateTime _selectedDay = DateTime(2025, 5, 1);
  String formattedDate = '';
  CalendarFormat _calendarFormat = CalendarFormat.month;
  int progress = 0;
  List<String> types = [];
  List<double> percentage = [];
  int toSpend = 0;
  BudgetSimulatorFunctions functions = BudgetSimulatorFunctions();
  late Expense nextExpense = functions.nullExpense;
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
    setState(() {
      toSpend = widget.checkingAccountBalance as int;
    });

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

  Future<void> changeMoney(int amount, String type) async {
    if (type == "Checking Account") {
      checkingAccountBalance += amount;
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
                    setState(() {
                      toSpend = checkingAccountBalance;
                    });
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
            setState(() {
              toSpend = checkingAccountBalance;
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
    for (Expense expense in widget.expenses) {
      types.add(expense.name);
      totalSpending += expense.amountPaid;
    }
    for (Expense expense in widget.expenses) {
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
      widget.expenses = filterdEvents.toList();
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
      chartData = functions.getChartData(types, percentage, colors);
    });

    alocateEvents();
    setState(() {
      var data = functions.updateNextExpense(widget.expenses, now);
      expenses = data['expenses'];
      nextExpense = data['nextExpense'];
    });
  }

  List<BudgetSimulatorChartData> chartData = [];
  List<Color> colors = [
    Colors.pink,
    Colors.blue,
    Colors.teal,
    Colors.orange,
    Colors.yellow,
    Colors.black,
    Colors.purple,
  ];

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
          SizedBox(
            height: screenHeight,
            width: screenWidthUnit * 159,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black,
                    width: screenWidthUnit * 1.5,
                  ),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeightUnit * 80,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Container(
                      height: screenHeightUnit * 100,
                      width: screenWidthUnit * 130,
                      child: Center(
                        child: Container(
                          height: screenHeightUnit * 60,
                          width: screenWidthUnit * 60,
                          child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FBottom%20Navigation%20Bar%20Icons%2FLesson%20Page.png?alt=media&token=1e20b2e4-ee49-49cc-bc01-dcf08b21104b"),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PortfolioScreen()),
                      );
                    },
                    child: Container(
                      height: screenHeightUnit * 100,
                      width: screenWidthUnit * 130,
                      child: Center(
                        child: Container(
                          height: screenHeightUnit * 60,
                          width: screenWidthUnit * 60,
                          child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FBottom%20Navigation%20Bar%20Icons%2FPortfolio.png?alt=media&token=d2012e7d-19fb-4766-9777-ce09231e4021"),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Container(
                      height: screenHeightUnit * 100,
                      width: screenWidthUnit * 130,
                      child: Center(
                        child: Container(
                          height: screenHeightUnit * 60,
                          width: screenWidthUnit * 60,
                          child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FBottom%20Navigation%20Bar%20Icons%2FTrading.png?alt=media&token=2037e6b1-6fb6-48af-aecf-5f288c2159b0"),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: screenHeightUnit * 100,
                      width: screenWidthUnit * 100,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(225, 243, 254, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Container(
                          height: screenHeightUnit * 60,
                          width: screenWidthUnit * 60,
                          child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FBottom%20Navigation%20Bar%20Icons%2FbudgetingSimulator.png?alt=media&token=27735960-da68-4e24-ae22-4a977b929264"),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );
                    },
                    child: Container(
                      height: screenHeightUnit * 100,
                      width: screenWidthUnit * 130,
                      child: Center(
                        child: Container(
                          height: screenHeightUnit * 60,
                          width: screenWidthUnit * 60,
                          child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FBottom%20Navigation%20Bar%20Icons%2FProfile.png?alt=media&token=80ec6904-46b7-4f76-85e1-dc21531e7a7c"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeightUnit * 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(screenWidthUnit * 15,
                            screenHeightUnit * 16, 0, screenWidthUnit * 8),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: screenWidthUnit * 24,
                          color: Colors.black,
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: screenWidthUnit * 4),
                        child: Text(
                          'Quit ${widget.name}',
                          style: GoogleFonts.baloo2(
                              fontSize: screenWidthUnit * 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenWidthUnit * 999,
                          screenHeightUnit * 6, screenWidthUnit * 31, 0),
                      child: Container(
                        height: screenHeightUnit * 70,
                        width: screenWidthUnit * 76,
                        child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLogo2%20(1)%202.png?alt=media&token=a572c91c-6624-4e57-87d0-c1362cc6dd8e",
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        }),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(0, screenHeightUnit * 6, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/img_monkeymoney_50.png',
                            height: screenHeightUnit * 50,
                          ),
                          SizedBox(
                            width: screenWidthUnit * 5,
                          ),
                          Text(
                            "3",
                            style: GoogleFonts.baloo2(
                              fontSize: screenWidthUnit * 27,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: screenWidthUnit * 39,
                          ),
                          Image.asset(
                            'assets/images/img_monkeymoney_51.png',
                            height: screenHeightUnit * 50,
                          ),
                          SizedBox(
                            width: screenWidthUnit * 5,
                          ),
                          Text(
                            "3",
                            style: GoogleFonts.baloo2(
                              fontSize: screenWidthUnit * 27,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: screenWidthUnit * 39,
                          ),
                          Image.asset(
                            'assets/images/img_monkeymoney_52.png',
                            height: screenHeightUnit * 50,
                          ),
                          SizedBox(
                            width: screenWidthUnit * 5,
                          ),
                          Text(
                            "3",
                            style: GoogleFonts.baloo2(
                              fontSize: screenWidthUnit * 27,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
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
                                      checkingTransfer: checkingTransfer,
                                      savingsTransfer: savingsTransfer,
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
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: screenHeightUnit * 15),
                                          child: Container(
                                            width: screenWidthUnit * 195,
                                            height: screenHeightUnit * 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color.fromRGBO(
                                                  79, 195, 247, 1),
                                            ),
                                            child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Dialog(
                                                        backgroundColor: Colors
                                                            .transparent, // Remove background color
                                                        child: Allocatefunding(
                                                          toCheckingTransfer:
                                                              checkingTransfer
                                                                  as int,
                                                          screenHeightUnit:
                                                              screenHeightUnit,
                                                          screenWidthUnit:
                                                              screenWidthUnit,
                                                          types: types,
                                                          wellnessScore: widget
                                                              .wellnessScore,
                                                          checkingAccountBalance:
                                                              widget.checkingAccountBalance
                                                                  as int,
                                                          creditCardDebt: widget
                                                                  .creditCardDebt
                                                              as int,
                                                          savingsAccountBalance:
                                                              widget.savingsAccountBalance
                                                                  as int,
                                                          checkingTransfer:
                                                              checkingTransfer
                                                                  as int,
                                                          savingsTransfer:
                                                              savingsTransfer
                                                                  as int,
                                                          expenses:
                                                              widget.expenses,
                                                          monthlyFitness:
                                                              monthlyFitness,
                                                          monthlyEntertainment:
                                                              monthlyEntertainment,
                                                          onConfirm: (
                                                            int toSavings,
                                                            int toChecking,
                                                            int newChecking,
                                                            int rentSpent,
                                                            int groceriesSpent,
                                                            int travelSpentNow,
                                                            int utilitiesSpent,
                                                            int toFitness,
                                                            int toEntertainment,
                                                            int toCredCardDebt,
                                                            int monthlyEntertainment,
                                                            int monthlyFitness,
                                                            int wellnessScore,
                                                          ) {
                                                            getInterestSavings();
                                                            setState(() {
                                                              toSpend -= min(0,
                                                                  toChecking);

                                                              widget.checkingAccountBalance +=
                                                                  checkingTransfer;
                                                              checkingTransfer =
                                                                  toChecking
                                                                      as double;
                                                              widget.savingsAccountBalance +=
                                                                  savingsTransfer;
                                                              savingsTransfer =
                                                                  toSavings
                                                                      as double;
                                                              widget.creditCardDebt -=
                                                                  toCredCardDebt; // easier to do double here than fix past
                                                              monthlyEntertainment =
                                                                  monthlyEntertainment;
                                                              monthlyFitness =
                                                                  monthlyFitness;
                                                              widget.wellnessScore =
                                                                  wellnessScore;

                                                              var milestoneData =
                                                                  {};

                                                              if (widget.name ==
                                                                  "Crush the Credit Card Debt") {
                                                                milestoneData =
                                                                    functions
                                                                        .editMilestones(
                                                                  milestones: widget
                                                                      .milestones,
                                                                  toCredCardDebt:
                                                                      toCredCardDebt,
                                                                  toSavings:
                                                                      toSavings,
                                                                  toLuxary:
                                                                      toEntertainment +
                                                                          toFitness,
                                                                  level: widget
                                                                      .level,
                                                                  monthsOccurd:
                                                                      monthsOccurd,
                                                                  daysUnderLuxary:
                                                                      daysUnderLuxary,
                                                                  toLuxaryForWeek:
                                                                      toLuxaryForWeek,
                                                                  daysUnderLuxaryDone:
                                                                      daysUnderLuxaryDone,
                                                                  savingsAccountBalance:
                                                                      widget
                                                                          .savingsAccountBalance,
                                                                );
                                                                widget.milestones =
                                                                    milestoneData[
                                                                        'Milestones'];
                                                                daysUnderLuxaryDone =
                                                                    milestoneData[
                                                                        'daysUnderLuxaryDone'];
                                                                daysUnderLuxary =
                                                                    milestoneData[
                                                                        'daysUnderLuxary'];
                                                                toLuxaryForWeek =
                                                                    milestoneData[
                                                                        'ToLuxaryForWeek'];
                                                              }

                                                              spendOnExpense(
                                                                  rentSpent,
                                                                  "Rent");
                                                              spendOnExpense(
                                                                  groceriesSpent,
                                                                  "Groceries");
                                                              spendOnExpense(
                                                                  travelSpentNow,
                                                                  "Transportation");
                                                              spendOnExpense(
                                                                  utilitiesSpent,
                                                                  "Utilities");
                                                              spendOnExpense(
                                                                  toFitness,
                                                                  "Fitness");
                                                              spendOnExpense(
                                                                  toEntertainment,
                                                                  "Entertainment");
                                                              spendOnExpense(
                                                                  toCredCardDebt,
                                                                  "CC Debt");

                                                              recalculatePercentages();
                                                              mapExpenses();
                                                              nextDay();

                                                              var data = functions
                                                                  .updateNextExpense(
                                                                      widget
                                                                          .expenses,
                                                                      now);
                                                              expenses = data[
                                                                  'expenses'];
                                                              nextExpense = data[
                                                                  'nextExpense'];

                                                              WidgetsBinding
                                                                  .instance
                                                                  .addPostFrameCallback(
                                                                      (_) {
                                                                getEvents();
                                                                checkRandomEvents();
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Allocate Funds",
                                                      style: GoogleFonts.baloo2(
                                                        fontSize:
                                                            screenWidthUnit *
                                                                18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          screenWidthUnit * 3,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size:
                                                          screenWidthUnit * 15,
                                                      color: Colors.white,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size:
                                                          screenWidthUnit * 15,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ))),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: screenHeightUnit * 8,
                                          bottom: screenHeightUnit * 18),
                                      child: Center(
                                        child: Container(
                                          width: screenWidthUnit * 1290,
                                          height: screenHeightUnit * 55,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Color.fromRGBO(79, 195, 247, 1),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "MO",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "TUES",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "WED",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "THURS",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "FRI",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "SAT",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "SUN",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        height: screenHeightUnit * 830,
                                        width: screenWidthUnit * 1290,
                                        child: TableCalendar(
                                          focusedDay: _focusedDay,
                                          firstDay: DateTime.utc(2022, 01, 01),
                                          lastDay: DateTime.utc(2026, 01, 01),
                                          calendarFormat: CalendarFormat.month,
                                          daysOfWeekVisible: false,
                                          selectedDayPredicate: (day) {
                                            return isSameDay(_selectedDay, day);
                                          },
                                          eventLoader: (day) {
                                            final normalizdDay =
                                                normalizeDate(day);
                                            return expensesMapped[
                                                    normalizdDay] ??
                                                [];
                                          },
                                          onDaySelected:
                                              (selectedDay, focusedDay) {
                                            setState(() {
                                              _selectedDay = selectedDay;
                                              _focusedDay = focusedDay;
                                              formattedDate =
                                                  DateFormat('MMM d, y')
                                                      .format(_selectedDay);
                                            });
                                          },
                                          headerVisible: false,
                                          calendarStyle: CalendarStyle(
                                            outsideDaysVisible: true,
                                            cellMargin: EdgeInsets.all(2),
                                            defaultTextStyle:
                                                TextStyle(color: Colors.black),
                                            outsideTextStyle:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          rowHeight: smallBoxes
                                              ? screenHeightUnit * 135
                                              : screenHeightUnit * 165,
                                          calendarBuilders: CalendarBuilders(
                                            outsideBuilder:
                                                (context, day, focusedDay) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      192, 192, 192, .5),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                ),
                                              );
                                            },
                                            defaultBuilder:
                                                (context, day, focusedDay) {
                                              final bool isToday =
                                                  isSameDay(day, now);
                                              final bool isSelected =
                                                  _selectedDay != null &&
                                                      isSameDay(
                                                          _selectedDay, day);
                                              final bool isFocused =
                                                  isSameDay(day, _focusedDay);

                                              // Set fill and border color dynamically
                                              Color fillColor = Colors.white;
                                              Color borderColor = Colors.grey;

                                              if (isSelected) {
                                                borderColor = const Color(
                                                    0xFF51A4F1); // Blue border for selected
                                              } else if (isFocused) {
                                                borderColor = Colors
                                                    .blueAccent; // Light blue for focused
                                              }

                                              return isSameDay(day, now)
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                        color: Colors.white,
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                              top: 5,
                                                              right: 5,
                                                              child: Container(
                                                                  width:
                                                                      screenHeightUnit *
                                                                          50,
                                                                  height:
                                                                      screenHeightUnit *
                                                                          50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: isToday
                                                                        ? Color.fromRGBO(
                                                                            243,
                                                                            52,
                                                                            53,
                                                                            1)
                                                                        : Colors
                                                                            .transparent,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      '${day.day}',
                                                                      style: GoogleFonts
                                                                          .baloo2(
                                                                        fontSize:
                                                                            screenWidthUnit *
                                                                                25,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: isToday
                                                                            ? Color.fromRGBO(
                                                                                255,
                                                                                255,
                                                                                255,
                                                                                1)
                                                                            : Color.fromRGBO(
                                                                                108,
                                                                                108,
                                                                                108,
                                                                                1),
                                                                      ),
                                                                    ),
                                                                  ))),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        color: fillColor,
                                                        border: Border.all(
                                                          color: borderColor,
                                                          width: (isSelected ||
                                                                  isFocused
                                                              ? 1
                                                              : 1),
                                                        ),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            top: 5,
                                                            right: 5,
                                                            child: Text(
                                                              '${day.day}',
                                                              style: GoogleFonts
                                                                  .baloo2(
                                                                fontSize:
                                                                    screenWidthUnit *
                                                                        25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        108,
                                                                        108,
                                                                        108,
                                                                        1),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                            },
                                            todayBuilder:
                                                (context, day, focusedDay) {
                                              final bool isToday =
                                                  isSameDay(day, now);
                                              return Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1),
                                                  color: Colors.white,
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                        top: 5,
                                                        right: 5,
                                                        child: Container(
                                                            width:
                                                                screenHeightUnit *
                                                                    50,
                                                            height:
                                                                screenHeightUnit *
                                                                    50,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: isToday
                                                                  ? Color
                                                                      .fromRGBO(
                                                                          243,
                                                                          52,
                                                                          53,
                                                                          1)
                                                                  : Colors
                                                                      .transparent,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${day.day}',
                                                                style:
                                                                    GoogleFonts
                                                                        .baloo2(
                                                                  fontSize:
                                                                      screenWidthUnit *
                                                                          25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: isToday
                                                                      ? Color.fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          1)
                                                                      : Color.fromRGBO(
                                                                          108,
                                                                          108,
                                                                          108,
                                                                          1),
                                                                ),
                                                              ),
                                                            ))),
                                                  ],
                                                ),
                                              );
                                            },
                                            markerBuilder:
                                                (context, day, events) {
                                              if (events.isEmpty) {
                                                return const SizedBox
                                                    .shrink(); // No events, no markers
                                              }

                                              return Positioned(
                                                bottom: 5,
                                                left: 5,
                                                right: 5,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: events.map((e) {
                                                    final myExpense =
                                                        e as Expense;
                                                    return Expenselabel(
                                                      expense: myExpense,
                                                      screenHeightUnit:
                                                          screenHeightUnit,
                                                      screenWidthUnit:
                                                          screenWidthUnit,
                                                    );
                                                  }).toList(),
                                                ),
                                              );
                                            },
                                            selectedBuilder:
                                                (context, day, focusedDay) {
                                              return day.month != now.month
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            192, 192, 192, .5),
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    )
                                                  : isSameDay(day, now)
                                                      ? Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0xFF51A4F1),
                                                                width: 2),
                                                            color: Colors.white,
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                  top: 5,
                                                                  right: 5,
                                                                  child: Container(
                                                                      width: screenHeightUnit * 50,
                                                                      height: screenHeightUnit * 50,
                                                                      decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Color.fromRGBO(
                                                                            243,
                                                                            52,
                                                                            53,
                                                                            1),
                                                                      ),
                                                                      child: Center(
                                                                        child:
                                                                            Text(
                                                                          '${day.day}',
                                                                          style:
                                                                              GoogleFonts.baloo2(
                                                                            fontSize:
                                                                                screenWidthUnit * 25,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Color.fromRGBO(
                                                                                255,
                                                                                255,
                                                                                255,
                                                                                1),
                                                                          ),
                                                                        ),
                                                                      ))),
                                                            ],
                                                          ),
                                                        )
                                                      : Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0xFF51A4F1),
                                                                width: 2),
                                                            color: Colors.white,
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                top: 5,
                                                                right: 5,
                                                                child: Text(
                                                                  '${day.day}',
                                                                  style:
                                                                      GoogleFonts
                                                                          .baloo2(
                                                                    fontSize:
                                                                        screenWidthUnit *
                                                                            25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            108,
                                                                            108,
                                                                            108,
                                                                            1),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          nextExpense: nextExpense,
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
                            // Container(
                            //   width: screenWidthUnit * 1,
                            //   height: screenHeightUnit * 1122,
                            //   color: Colors.black,
                            // ),

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
}
