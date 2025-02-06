import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/allocateFunding.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/expenseLabel.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/headings.dart';
import 'package:intl/intl.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/meterBox.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/milestoneProgress.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/spendingChart.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/bottomWarning.dart';
import 'package:table_calendar/table_calendar.dart';

class BudgetSimulator extends StatefulWidget {
  BudgetSimulator({
    super.key,
    required this.name,
    required this.checkingAccountBalance,
    required this.savingsAccountBalance,
    required this.creditCardDebt,
    required this.startingBalance,
    required this.APY,
    required this.milestones,
    required this.creditScore,
    required this.expenses,
  });

  final String name;

  final double checkingAccountBalance;
  final double savingsAccountBalance;
  final double creditCardDebt;
  final double startingBalance;
  final double APY;
  final List<Milestone> milestones;
  final double creditScore;
  List<Expense> expenses;

  State<BudgetSimulator> createState() => _BudgetSimulatorState();
}

class _BudgetSimulatorState extends State<BudgetSimulator> {
  late double netCash;
  final Headings headings = Headings();
  final DateTime now = DateTime.now(); // Current date and time
  String formattedDate = '';
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now().add(Duration(days: 0));
  int progress = 0;
  List<String> types = [];
  List<double> percentage = [];
  double totalSpending = 0;
  bool smallBoxes = true;

  final Map<DateTime, List<Expense>> expensesMapped = {};
  final List<Expense> expenses = [];

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
    for (Expense expense in widget.expenses) {
      DateTime normalizedDate = normalizeDate(expense.dueDay);
      if (expensesMapped.containsKey(normalizedDate)) {
        expensesMapped[normalizedDate]!.add(expense);
      } else {
        expensesMapped[normalizedDate] = [expense];
      }
    }
  }

  DateTime _selectedDay = DateTime.now();

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  Future<void> getExpenses() async {
    for (Expense expense in widget.expenses) {
      types.add(expense.name);
      totalSpending += expense.amountPaid;
    }
    for (Expense expense in widget.expenses) {
      percentage.add((expense.amountPaid / totalSpending) * 100);
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

  @override
  void initState() {
    mapExpenses();
    filterPayDays();
    super.initState();
    netCash = widget.startingBalance;
    formattedDate = DateFormat('MMM d, y').format(_selectedDay);
    getProgress();
    getExpenses();
    getUniqueWeekCountForMonth(_focusedDay.year, _focusedDay.month);
  }

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
                                  ? headings.crushTheCreditCardDebtHeading(
                                      checkingAccountBalance:
                                          widget.checkingAccountBalance,
                                      savingsAccountBalance:
                                          widget.savingsAccountBalance,
                                      creditCardDebt: widget.creditCardDebt,
                                      netCash: netCash,
                                      screenWidthUnit: screenWidthUnit,
                                      screenHeightUnit: screenHeightUnit * .9,
                                      APY: widget.APY,
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
                                                      return AlertDialog(
                                                          content:
                                                              Allocatefunding(
                                                        screenHeightUnit:
                                                            screenHeightUnit,
                                                        screenWidthUnit:
                                                            screenWidthUnit,
                                                      ));
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
                                                                16,
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
                                                          screenWidthUnit * 13,
                                                      color: Colors.white,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size:
                                                          screenWidthUnit * 13,
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
                                              final bool isToday = isSameDay(
                                                  day, DateTime.now());
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

                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: fillColor,
                                                  border: Border.all(
                                                    color: borderColor,
                                                    width:
                                                        (isSelected || isFocused
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
                                                        style:
                                                            GoogleFonts.baloo2(
                                                          fontSize:
                                                              screenWidthUnit *
                                                                  25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromRGBO(
                                                              108, 108, 108, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            todayBuilder:
                                                (context, day, focusedDay) {
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
                                                              color: Color
                                                                  .fromRGBO(
                                                                      243,
                                                                      52,
                                                                      53,
                                                                      1),
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
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
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
                                          bottom: screenHeightUnit * 30),
                                      child: Center(
                                        child: Bottomwarning(
                                          screenHeightUnit:
                                              screenHeightUnit * .9,
                                          screenWidthUnit: screenWidthUnit,
                                          color:
                                              Color.fromRGBO(135, 218, 255, 1),
                                          text:
                                              "Hint: Consider reducing entertainment spendings to boost your savings. ",
                                          textColor:
                                              Color.fromRGBO(32, 84, 116, 1),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MilestoneProgress(
                                  milestones: widget.milestones,
                                  screenWidthUnit: screenWidthUnit,
                                  screenHeightUnit: screenHeightUnit,
                                  progress: progress,
                                ),
                                SizedBox(
                                  height: screenHeightUnit * 30,
                                ),
                                MeterBox(
                                  screenHeightUnit: screenHeightUnit,
                                  screenWidthUnit: screenWidthUnit,
                                  creditScore: widget.creditScore as int,
                                ),
                                SizedBox(
                                  height: screenHeightUnit * 30,
                                ),
                                SpendingDonutChart(
                                  screenWidthUnit: screenWidthUnit,
                                  screenHeightUnit: screenHeightUnit,
                                  types: types,
                                  percentage: percentage,
                                  total: totalSpending,
                                ),
                              ],
                            )
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

class Event {
  final String title;

  Event(this.title);
}
