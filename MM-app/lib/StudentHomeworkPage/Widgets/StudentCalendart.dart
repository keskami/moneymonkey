import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/CalendarEvent.dart';
import 'package:intl/intl.dart';
import 'package:money_monkey/LessonPages/Controllers/HomePagesController.dart';
import 'package:money_monkey/themes/color_themes.dart';

class StudentCalendar extends StatefulWidget {
  final List<CalendarEvent> events;
  final Function(CalendarEvent)? onEventSelected;
  final double screenHeight;
  final double screenWidth;

  const StudentCalendar({
    Key? key,
    required this.events,
    this.onEventSelected,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  State<StudentCalendar> createState() => _StudentCalendarState();
}

class _StudentCalendarState extends State<StudentCalendar> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  List<CalendarEvent> _upcomingEvents = [];
  String _formattedMonth = '';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedDay = now;
    _selectedDay = now;
    _formattedMonth = DateFormat('MMMM yyyy').format(now);
    _updateUpcomingEvents();
  }

  void _updateUpcomingEvents() {
    // Sort events by due date (nearest first)
    final sortedEvents = [...widget.events];
    sortedEvents.sort((a, b) => a.dueDate.compareTo(b.dueDate));

    // Get events that are due today or in the future
    final now = DateTime.now();
    _upcomingEvents = sortedEvents
        .where((event) =>
            event.dueDate.isAfter(now) ||
            (event.dueDate.day == now.day &&
                event.dueDate.month == now.month &&
                event.dueDate.year == now.year))
        .take(3)
        .toList();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  void _onDaySelected(DateTime date) {
    setState(() {
      _selectedDay = date;
    });
  }

  List<CalendarEvent> _getEventsForDay(int day) {
    return widget.events
        .where((event) =>
            event.date.day == day &&
            event.date.month == _focusedDay.month &&
            event.date.year == _focusedDay.year)
        .toList();
  }

  // Get background color for event tag
  Color _getEventBgColor(EventType type) {
    switch (type) {
      case EventType.assignment:
        return Colors.red.shade100;
      case EventType.activity:
        return Colors.green.shade100;
      case EventType.deadline:
        return Colors.blue.shade100;
      case EventType.meeting:
        return Colors.purple.shade100;
      case EventType.reminder:
        return Colors.amber.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  // Get text color for event tag
  Color _getEventTextColor(EventType type) {
    switch (type) {
      case EventType.assignment:
        return Colors.red.shade700;
      case EventType.activity:
        return Colors.green.shade700;
      case EventType.deadline:
        return Colors.blue.shade700;
      case EventType.meeting:
        return Colors.purple.shade700;
      case EventType.reminder:
        return Colors.amber.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  final HomePagesController homePagesController =
      Get.find<HomePagesController>();

  @override
  Widget build(BuildContext context) {
    // Apply responsive sizing factors
    final double fontSizeFactor = widget.screenHeight * 0.002;
    final double paddingFactor = widget.screenHeight * 0.004;

    // Calculate calendar data
    final year = _focusedDay.year;
    final month = _focusedDay.month;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstDayOfMonth = DateTime(year, month, 1).weekday % 7;

    // Create calendar days list
    final calendarDays = <int?>[];

    // Add empty cells for days before the first day of month
    for (int i = 0; i < firstDayOfMonth; i++) {
      calendarDays.add(null);
    }

    // Add cells for days of month
    for (int day = 1; day <= daysInMonth; day++) {
      calendarDays.add(day);
    }

    return Obx(() {
      // Calculate dynamic widths based on sidebar state
      bool isSidebarExpanded = homePagesController.isSidebarExpanded.value;
      double calendarWidth = isSidebarExpanded 
          ? widget.screenWidth * 0.55 
          : widget.screenWidth * 0.7;
      double tasksWidth =widget.screenWidth * 0.18;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calendar Section
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOutQuad,
                width: calendarWidth,
                height: widget.screenHeight * 0.59,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Month navigation row remains the same
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: () {
                              setState(() {
                                _focusedDay = DateTime(
                                    _focusedDay.year, _focusedDay.month - 1, 1);
                                _formattedMonth =
                                    DateFormat('MMMM yyyy').format(_focusedDay);
                                _updateUpcomingEvents();
                              });
                            },
                          ),
                          Text(
                            _formattedMonth,
                            style: TextStyle(
                              fontSize: 18 * fontSizeFactor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () {
                              setState(() {
                                _focusedDay = DateTime(
                                    _focusedDay.year, _focusedDay.month + 1, 1);
                                _formattedMonth =
                                    DateFormat('MMMM yyyy').format(_focusedDay);
                                _updateUpcomingEvents();
                              });
                            },
                          ),
                        ],
                      ),

                      // Rest of the grid remains unchanged
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1.6,
                        ),
                        itemCount: calendarDays.length,
                        itemBuilder: (context, index) {
                          final day = calendarDays[index];
                          // Return empty cell for days outside the month
                          if (day == null) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                            );
                          }
                          // Current date for this cell
                          final date = DateTime(year, month, day);

                          // Check if this is the selected day or today
                          final isSelected = isSameDay(date, _selectedDay);
                          final isTodayDate = isToday(date);

                          // Special events based on the day of month
                          final List<Widget> eventTags = [];

                          // Pay Day (1st and 15th)
                          if (day == 1 || day == 15) {
                            eventTags.add(_buildEventTag(
                                'Pay Day!',
                                Colors.green.shade100,
                                Colors.green.shade700,
                                fontSizeFactor));
                          }

                          // Math Assignment (day 5)
                          if (day == 5) {
                            eventTags.add(_buildEventTag(
                                'Math 3.2',
                                Colors.red.shade100,
                                Colors.red.shade700,
                                fontSizeFactor));
                          }

                          // Utilities Due (day 10)
                          if (day == 10) {
                            eventTags.add(_buildEventTag(
                                'Utilities Due',
                                Colors.blue.shade100,
                                Colors.blue.shade700,
                                fontSizeFactor));
                          }

                          // Credit Card Minimum Due (day 25)
                          if (day == 25) {
                            eventTags.add(_buildEventTag(
                                'CC Min. Due',
                                Colors.grey.shade300,
                                Colors.grey.shade700,
                                fontSizeFactor));
                          }

                          // Add events from the events list
                          final events = _getEventsForDay(day);
                          if (events.isNotEmpty && eventTags.isEmpty) {
                            // Only add from real events if we don't already have a hardcoded event
                            for (final event in events.take(1)) {
                              eventTags.add(_buildEventTag(
                                  event.title,
                                  _getEventBgColor(event.type),
                                  _getEventTextColor(event.type),
                                  fontSizeFactor));
                            }
                          }

                          return GestureDetector(
                            onTap: () => _onDaySelected(date),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                                color: isSelected
                                    ? LightTheme().pastelBlue.withValues(alpha: 0.4)
                                    : Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Day number (with special style for today)
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 3 * paddingFactor),
                                    child: Text(
                                      day.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12 * fontSizeFactor,
                                        color: isTodayDate
                                            ? Colors.blue
                                            : Colors.grey.shade800,
                                      ),
                                    ),
                                  ),

                                  // Event tags
                                  ...eventTags,
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 10 * paddingFactor),

              // Upcoming tasks
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOutQuad,
                width: tasksWidth,
                padding: EdgeInsets.all(8 * paddingFactor),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming Tasks',
                      style: TextStyle(
                        fontSize: 15 * fontSizeFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8 * paddingFactor),

                    // Container for tasks list
                    Container(
                      height: widget.screenHeight * 0.4,
                      child: _upcomingEvents.isEmpty
                          ? Container(
                              padding: EdgeInsets.all(8 * paddingFactor),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16 * paddingFactor),
                                  child: Text(
                                    'No upcoming tasks',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12 * fontSizeFactor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemCount: _upcomingEvents.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 8 * paddingFactor),
                              itemBuilder: (context, index) {
                                final event = _upcomingEvents[index];
                                return Container(
                                  padding: EdgeInsets.all(paddingFactor * 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        if (widget.onEventSelected != null) {
                                          widget.onEventSelected!(event);
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            event.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13 * fontSizeFactor,
                                            ),
                                          ),
                                          Text(
                                            'Due ${DateFormat('M/d').format(event.dueDate)} @ ${DateFormat('h:mm a').format(event.dueDate)}',
                                            style: TextStyle(
                                              fontSize: 11 * fontSizeFactor,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  
  Widget _buildEventTag(
    String text, 
    Color bgColor, 
    Color textColor, 
    double fontSizeFactor
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 2, left: 2, right: 2),
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9 * fontSizeFactor,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}