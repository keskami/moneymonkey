import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/expenseLabel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class BudgetSimulatorCalender extends StatefulWidget {
  final double screenWidthUnit;
  final double screenHeightUnit;
  DateTime focusedDay;
  DateTime now;
  DateTime selectedDay;
  List<Expense> expenses;
  String formattedDate;
  bool smallBoxes;

  BudgetSimulatorCalender(
      {super.key,
      required this.screenWidthUnit,
      required this.screenHeightUnit,
      required this.focusedDay,
      required this.now,
      required this.selectedDay,
      required this.expenses,
      required this.formattedDate,
      required this.smallBoxes});

  @override
  _BudgetSimulatorCalenderState createState() =>
      _BudgetSimulatorCalenderState();
}

class _BudgetSimulatorCalenderState extends State<BudgetSimulatorCalender> {
  Map<DateTime, List<Expense>> expensesMapped = {};
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

  @override
  Widget build(BuildContext context) {
    mapExpenses();
    return Center(
      child: Container(
        height: widget.screenHeightUnit * 830,
        width: widget.screenWidthUnit * 1290,
        child: TableCalendar(
          focusedDay: widget.focusedDay,
          firstDay: DateTime.utc(2022, 01, 01),
          lastDay: DateTime.utc(2026, 01, 01),
          calendarFormat: CalendarFormat.month,
          daysOfWeekVisible: false,
          selectedDayPredicate: (day) {
            return isSameDay(widget.selectedDay, day);
          },
          eventLoader: (day) {
            final normalizdDay = normalizeDate(day);
            return expensesMapped[normalizdDay] ?? [];
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              widget.selectedDay = selectedDay;
              widget.focusedDay = focusedDay;
              widget.formattedDate =
                  DateFormat('MMM d, y').format(widget.selectedDay);
            });
          },
          headerVisible: false,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: true,
            cellMargin: EdgeInsets.all(2),
            defaultTextStyle: TextStyle(color: Colors.black),
            outsideTextStyle: TextStyle(color: Colors.grey),
          ),
          rowHeight: widget.smallBoxes
              ? widget.screenHeightUnit * 135
              : widget.screenHeightUnit * 165,
          calendarBuilders: CalendarBuilders(
            outsideBuilder: (context, day, focusedDay) {
              return Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(192, 192, 192, .5),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              );
            },
            defaultBuilder: (context, day, focusedDay) {
              final bool isToday = isSameDay(day, widget.now);
              final bool isSelected = isSameDay(widget.selectedDay, day);
              final bool isFocused = isSameDay(day, widget.focusedDay);

              Color fillColor = Colors.white;
              Color borderColor = Colors.grey;

              if (isSelected) {
                borderColor = const Color(0xFF51A4F1);
              } else if (isFocused) {
                borderColor = Colors.blueAccent;
              }

              return isSameDay(day, widget.now)
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                  width: widget.screenHeightUnit * 50,
                                  height: widget.screenHeightUnit * 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isToday
                                        ? Color.fromRGBO(0, 127, 255, 1)
                                        : Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${day.day}',
                                      style: GoogleFonts.baloo2(
                                        fontSize: widget.screenWidthUnit * 25,
                                        fontWeight: FontWeight.bold,
                                        color: isToday
                                            ? Color.fromRGBO(255, 255, 255, 1)
                                            : Color.fromRGBO(108, 108, 108, 1),
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
                          width: (isSelected || isFocused ? 1 : 1),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Text(
                              '${day.day}',
                              style: GoogleFonts.baloo2(
                                fontSize: widget.screenWidthUnit * 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(108, 108, 108, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            },
            todayBuilder: (context, day, focusedDay) {
              final bool isToday = isSameDay(day, widget.now);
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                            width: widget.screenHeightUnit * 50,
                            height: widget.screenHeightUnit * 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isToday
                                  ? Color.fromRGBO(0, 127, 255, 1)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                '${day.day}',
                                style: GoogleFonts.baloo2(
                                  fontSize: widget.screenWidthUnit * 25,
                                  fontWeight: FontWeight.bold,
                                  color: isToday
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(108, 108, 108, 1),
                                ),
                              ),
                            ))),
                  ],
                ),
              );
            },
            markerBuilder: (context, day, events) {
              if (events.isEmpty) {
                return const SizedBox.shrink(); // No events, no markers
              }

              return Positioned(
                bottom: 2,
                left: 5,
                right: 5,
                child: SizedBox(
                    height: widget.smallBoxes
                        ? widget.screenHeightUnit *
                            70 
                        : widget.screenHeightUnit * 85,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: events.map((e) {
                            final myExpense = e as Expense;
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      widget.screenHeightUnit * 5),
                              child: Expenselabel(
                                expense: myExpense,
                                screenHeightUnit: widget.screenHeightUnit,
                                screenWidthUnit: widget.screenWidthUnit,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )),
              );
            },
            selectedBuilder: (context, day, focusedDay) {
              return day.month != widget.now.month
                  ? Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(192, 192, 192, .5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    )
                  : isSameDay(day, widget.now)
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF51A4F1), width: 2),
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Container(
                                      width: widget.screenHeightUnit * 50,
                                      height: widget.screenHeightUnit * 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(0, 127, 255, 1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${day.day}',
                                          style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenWidthUnit * 25,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                          ),
                                        ),
                                      ))),
                            ],
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF51A4F1), width: 2),
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Text(
                                  '${day.day}',
                                  style: GoogleFonts.baloo2(
                                    fontSize: widget.screenWidthUnit * 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(108, 108, 108, 1),
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
    );
  }
}
