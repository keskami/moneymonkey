import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/headings.dart';
import 'package:intl/intl.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/meterBox.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/milestoneProgress.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/spendingChart.dart';
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
  DateTime _focusedDay = DateTime.now();
  int progress = 0;
  List<String> types = [];
  List<double> percentage = [];
  double totalSpending = 0;
  late ValueNotifier<List<Event>> _selectedEvents;
  Map<DateTime, List<Event>> _events = {
    DateTime.now(): [Event('Event 1')]
  };
  DateTime _selectedDay = DateTime.now();

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
    _selectedEvents.value = _getEventsForDay(selectedDay);
  }

  void _addEvent() {
    final event = Event('New Event');
    if (_events[_selectedDay] == null) {
      _events[_selectedDay] = [];
    }
    setState(() {
      _events[_selectedDay]!.add(event);
    });
    _selectedEvents.value = _getEventsForDay(_selectedDay!);
  }

  Future<void> getExpenses() async {
    for (Expense expense in widget.expenses) {
      types.add(expense.name);
      totalSpending += expense.amount;
    }
    for (Expense expense in widget.expenses) {
      percentage.add((expense.amount / totalSpending) * 100);
    }
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
    super.initState();
    // Access widget fields in initState
    netCash = widget.startingBalance;
    formattedDate = DateFormat('MMM d, y').format(now);
    getProgress();
    getExpenses();
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
                height: screenHeightUnit * 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(screenWidthUnit * 25,
                            screenHeightUnit * 24, 0, screenWidthUnit * 8),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: screenWidthUnit * 32,
                          color: Colors.black,
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: screenWidthUnit * 6),
                        child: Text(
                          'Quit ${widget.name}',
                          style: GoogleFonts.baloo2(
                              fontSize: screenWidthUnit * 28,
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
                  height: screenHeight - (screenHeightUnit * 90),
                  color: Color.fromRGBO(135, 206, 235, 1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeightUnit * 25,
                      ),
                      Center(
                        child: Container(
                            width: screenWidthUnit * 1871,
                            height: screenHeightUnit * 120,
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
                                      screenHeightUnit: screenHeightUnit,
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
                        height: screenHeightUnit * 1132,
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
                              height: screenHeightUnit * 1122,
                              width: screenWidthUnit * 1360,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: screenHeightUnit * 55,
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
                                              height: screenHeightUnit * 16,
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
                                              top: screenHeightUnit * 25),
                                          child: Container(
                                            width: screenWidthUnit * 195,
                                            height: screenHeightUnit * 68,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color.fromRGBO(
                                                  79, 195, 247, 1),
                                            ),
                                            child: GestureDetector(
                                                onTap: () {},
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
                                                          screenWidthUnit * 14,
                                                      color: Colors.white,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size:
                                                          screenWidthUnit * 14,
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
                                          top: screenHeightUnit * 16),
                                      child: Center(
                                        child: Container(
                                          width: screenWidthUnit * 1290,
                                          height: screenHeightUnit * 65,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Color.fromRGBO(79, 195, 247, 1),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "MO",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "TUES",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "WED",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "THURS",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "FRI",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "SAT",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "SUN",
                                                style: GoogleFonts.baloo2(
                                                  fontSize:
                                                      screenWidthUnit * 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: screenHeightUnit * 870,
                                      width: screenWidthUnit * 1500,
                                      child: TableCalendar(
                                        firstDay: DateTime.utc(2025, 1, 1),
                                        lastDay: DateTime.utc(2025, 1, 31),
                                        focusedDay: _focusedDay,
                                        selectedDayPredicate: (day) =>
                                            isSameDay(_selectedDay, day),
                                        onDaySelected: _onDaySelected,
                                        eventLoader: _getEventsForDay,
                                        headerStyle: HeaderStyle(
                                          formatButtonVisible:
                                              false, // Hides the header format button
                                          titleCentered:
                                              true, // Centers the title
                                          leftChevronVisible:
                                              false, // Hides the left chevron button
                                          rightChevronVisible:
                                              false, // Hides the right chevron button
                                        ),
                                        calendarStyle: CalendarStyle(
                                          outsideDaysVisible:
                                              false, // Hides the outside days of the current month
                                        ),
                                        daysOfWeekStyle: DaysOfWeekStyle(
                                          weekdayStyle: TextStyle(
                                            color: Colors
                                                .transparent, // Makes weekday names invisible
                                          ),
                                        ),
                                      ),
                                    )
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
