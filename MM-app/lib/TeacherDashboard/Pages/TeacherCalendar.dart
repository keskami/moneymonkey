import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_monkey/Backend/Models/CalendarEvent.dart';
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/PlaceHolderTab.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';


class TeacherCalendar extends StatefulWidget {
  const TeacherCalendar({Key? key}) : super(key: key);

  @override
  State<TeacherCalendar> createState() => _TeacherCalendarState();
}

class _TeacherCalendarState extends State<TeacherCalendar> {
  String activeView = 'calendar'; // 'calendar' or 'list'
  DateTime viewDate = DateTime.now();
  bool isModalOpen = false;
  CalendarEvent? selectedEvent;
  bool isEditMode = false;
  
  final TeacherDashboardController teacherDashboardController = Get.find();
  
  List<CalendarEvent> events = [
    CalendarEvent(
      id: '1',
      title: 'Math Assignment 3.2',
      date: DateTime(2025, 3, 5),
      dueDate: DateTime(2025, 3, 28),
      classId: 'tempClassId1_2025',
      className: 'Gold Period 1',
      description: 'Complete problems 1-15 on page 45',
      status: EventStatus.visible,
      type: EventType.assignment,
    ),
    CalendarEvent(
      id: '2',
      title: 'History Essay',
      date: DateTime(2025, 3, 10),
      dueDate: DateTime(2025, 3, 21),
      classId: 'tempClassId2_2025',
      className: 'Blue Period 1',
      description: 'Write a 500-word essay on the Industrial Revolution',
      status: EventStatus.visible,
      type: EventType.assignment,
    ),
    CalendarEvent(
      id: '3',
      title: 'Science Lab Report',
      date: DateTime(2025, 3, 15),
      dueDate: DateTime(2025, 3, 23),
      classId: 'tempClassId3_2025',
      className: 'Gold Period 2',
      description: 'Complete the lab report for the photosynthesis experiment',
      status: EventStatus.visible,
      type: EventType.activity,
    ),
    CalendarEvent(
      id: '4',
      title: 'Utilities Due',
      date: DateTime(2025, 3, 10),
      dueDate: DateTime(2025, 3, 10),
      classId: 'tempClassId4_2025',
      className: 'Personal Finance',
      description: 'Utility bill assignment due',
      status: EventStatus.visible,
      type: EventType.deadline,
    ),
    CalendarEvent(
      id: '5',
      title: 'CC Min. Due',
      date: DateTime(2025, 3, 25),
      dueDate: DateTime(2025, 3, 25),
      classId: 'tempClassId4_2025',
      className: 'Personal Finance',
      description: 'Credit card minimum payment calculation due',
      status: EventStatus.visible,
      type: EventType.deadline,
    ),
    CalendarEvent(
      id: '6',
      title: 'Parent-Teacher Conference',
      date: DateTime(2025, 3, 18),
      dueDate: DateTime(2025, 3, 18),
      classId: 'tempClassId1_2025',
      className: 'Gold Period 1',
      description: 'Meeting with parents to discuss student progress',
      status: EventStatus.visible,
      type: EventType.meeting,
    ),
    CalendarEvent(
      id: '7',
      title: 'Submit Grades',
      date: DateTime(2025, 3, 30),
      dueDate: DateTime(2025, 3, 30),
      classId: 'tempClassId1_2025',
      className: 'Gold Period 1',
      description: 'End of month grades submission deadline',
      status: EventStatus.draft,
      type: EventType.reminder,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // loadEventsFromFirebase();
  }

  List<CalendarEvent> get filteredEvents {
    if (teacherDashboardController.selectedClassId.isEmpty) {
      return events;
    }
    
    String selectedClassName = teacherDashboardController.classes[teacherDashboardController.selectedClassId.value] ?? '';
    return selectedClassName.isEmpty
        ? events
        : events.where((event) => event.className == selectedClassName).toList();
  }

  void handlePrevMonth() {
    setState(() {
      viewDate = DateTime(viewDate.year, viewDate.month - 1, 1);
    });
  }

  void handleNextMonth() {
    setState(() {
      viewDate = DateTime(viewDate.year, viewDate.month + 1, 1);
    });
  }

  void handleAddEvent() {
    String classId = teacherDashboardController.selectedClassId.value;
    String className = teacherDashboardController.classes[classId] ?? '';
    
    setState(() {
      selectedEvent = CalendarEvent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: '',
        date: DateTime.now(),
        dueDate: DateTime.now().add(const Duration(days: 7)),
        classId: classId,
        className: className,
        description: '',
        status: EventStatus.draft,
        type: EventType.assignment,
      );
      isEditMode = false;
      isModalOpen = true;
    });
    
    _showEventDialog();
  }

  void handleEditEvent(CalendarEvent event) {
    setState(() {
      selectedEvent = event.copy();
      isEditMode = true;
      isModalOpen = true;
    });
    
    _showEventDialog();
  }

  // Handle saving an event
  void handleSaveEvent() {
    setState(() {
      if (isEditMode) {
        // Update existing event
        final index = events.indexWhere((e) => e.id == selectedEvent!.id);
        if (index != -1) {
          events[index] = selectedEvent!;
        }
      } else {
        // Add new event
        events.add(selectedEvent!);
      }
      isModalOpen = false;
      selectedEvent = null;
    });
    
    // In a real implementation, we would save to Firebase here
    // saveEventsToFirebase();
    
    Get.snackbar(
      isEditMode ? 'Event Updated' : 'Event Added',
      isEditMode ? 'The event has been updated successfully' : 'The event has been added to the calendar',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // Handle deleting an event
  void handleDeleteEvent() {
    setState(() {
      events.removeWhere((e) => e.id == selectedEvent!.id);
      isModalOpen = false;
      selectedEvent = null;
    });
    
    // In a real implementation, we would delete from Firebase here
    // deleteEventFromFirebase(selectedEvent!.id);
    
    Get.snackbar(
      'Event Deleted',
      'The event has been removed from the calendar',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  // Get events for a specific day of the current month
  List<CalendarEvent> getEventsForDay(int? day) {
    if (day == null) return [];

    return filteredEvents.where((event) {
      return event.date.day == day &&
             event.date.month == viewDate.month &&
             event.date.year == viewDate.year;
    }).toList();
  }

  // Get color for event type
  Color getEventColor(EventType type) {
    switch (type) {
      case EventType.assignment:
        return LightTheme().primaryBlue;
      case EventType.activity:
        return LightTheme().pastelGreen;
      case EventType.deadline:
        return LightTheme().pastelRed;
      case EventType.meeting:
        return Colors.purple;
      case EventType.reminder:
        return Colors.amber.shade700;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (teacherDashboardController.selectedClassId.isEmpty)
      return TeacherDashoardPlaceHolderPage();
      
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    
    // Get current date info
    final today = DateTime.now();
    final currentYear = today.year;
    final currentMonth = today.month;
    final currentDay = today.day;
    
    // Build calendar days
    final List<int?> calendarDays = [];
    final year = viewDate.year;
    final month = viewDate.month;
    
    // Get the number of days in the month
    final daysInMonth = DateTime(year, month + 1, 0).day;
    
    // Get the first day of the month (0 = Monday, 6 = Sunday in Dart)
    final firstDayOfMonth = DateTime(year, month, 1).weekday % 7;
    
    // Add empty cells for days before the first day of the month
    for (int i = 0; i < firstDayOfMonth; i++) {
      calendarDays.add(null);
    }
    
    // Add cells for each day of the month
    for (int day = 1; day <= daysInMonth; day++) {
      calendarDays.add(day);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calendar Header section with action buttons
          ShadowedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Calendar",
                      style: TextStyles.containerTitle,
                    ),
                    ElevatedButton.icon(
                      onPressed: handleAddEvent,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Event'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LightTheme().primaryBlue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // View selector
                Row(
                  children: [
                    InkWell(
                      onTap: () => setState(() => activeView = 'calendar'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: activeView == 'calendar'
                              ? LightTheme().primaryBlue.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today, 
                              size: 16,
                              color: activeView == 'calendar'
                                  ? LightTheme().primaryBlue
                                  : Colors.grey.shade600,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Calendar View',
                              style: TextStyle(
                                color: activeView == 'calendar'
                                    ? LightTheme().primaryBlue
                                    : Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: () => setState(() => activeView = 'list'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: activeView == 'list'
                              ? LightTheme().primaryBlue.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.list, 
                              size: 16,
                              color: activeView == 'list'
                                  ? LightTheme().primaryBlue
                                  : Colors.grey.shade600,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'List View',
                              style: TextStyle(
                                color: activeView == 'list'
                                    ? LightTheme().primaryBlue
                                    : Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Calendar View
          if (activeView == 'calendar')
            ShadowedContainer(
              child: Column(
                children: [
                  // Month navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: handlePrevMonth,
                        icon: const Icon(Icons.chevron_left),
                        tooltip: 'Previous Month',
                      ),
                      Text(
                        DateFormat('MMMM yyyy').format(viewDate),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: handleNextMonth,
                        icon: const Icon(Icons.chevron_right),
                        tooltip: 'Next Month',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Calendar grid
                  Container(
                    height: screenHeight * 0.6,
                    child: Column(
                      children: [
                        // Day headers
                        Row(
                          children: const [
                            'Sun',
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat'
                          ].map((day) => Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              alignment: Alignment.center,
                              color: Colors.grey.shade100,
                              child: Text(
                                day,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )).toList(),
                        ),

                        // Calendar cells
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              childAspectRatio: 1,
                            ),
                            itemCount: calendarDays.length,
                            itemBuilder: (context, index) {
                              final day = calendarDays[index];
                              final events = getEventsForDay(day);

                              final isToday = day == currentDay && 
                                              month == currentMonth && 
                                              year == currentYear;

                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  color: day == null 
                                      ? Colors.grey.shade50 
                                      : isToday 
                                          ? LightTheme().primaryBlue.withOpacity(0.1)
                                          : Colors.white,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: day == null
                                    ? null
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: isToday ? LightTheme().primaryBlue : null,
                                            ),
                                            child: Text(
                                              day.toString(),
                                              style: TextStyle(
                                                color: isToday ? Colors.white : null,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Expanded(
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount: events.length > 3 ? 3 : events.length,
                                              itemBuilder: (context, idx) {
                                                final event = events[idx];
                                                return GestureDetector(
                                                  onTap: () => handleEditEvent(event),
                                                  child: Container(
                                                    margin: const EdgeInsets.only(bottom: 2),
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: getEventColor(event.type),
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                    child: Text(
                                                      event.title,
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white,
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          if (events.length > 3)
                                            Text(
                                              '+${events.length - 3} more',
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),
                                        ],
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
            ),

          // List View
          if (activeView == 'list')
            ShadowedContainer(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20,
                  columns: const [
                    DataColumn(label: Text('Title')),
                    DataColumn(label: Text('Class')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Due Date')),
                    DataColumn(label: Text('Type')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: filteredEvents.map((event) => DataRow(
                    cells: [
                      DataCell(
                        Container(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                event.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                event.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataCell(Text(event.className)),
                      DataCell(Text(DateFormat('MMM d, yyyy').format(event.date))),
                      DataCell(Text(DateFormat('MMM d, yyyy').format(event.dueDate))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: getEventColor(event.type).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            event.type.displayName,
                            style: TextStyle(
                              fontSize: 12,
                              color: getEventColor(event.type),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: event.status == EventStatus.draft
                                ? Colors.grey.withOpacity(0.1)
                                : event.status == EventStatus.visible
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            event.status.displayName,
                            style: TextStyle(
                              fontSize: 12,
                              color: event.status == EventStatus.draft
                                  ? Colors.grey
                                  : event.status == EventStatus.visible
                                      ? Colors.green
                                      : Colors.orange,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, size: 18),
                              onPressed: () => handleEditEvent(event),
                              color: LightTheme().primaryBlue,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 18),
                              onPressed: () {
                                setState(() {
                                  selectedEvent = event;
                                });
                                
                                // Show confirmation dialog
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text('Confirm Delete'),
                                    content: const Text('Are you sure you want to delete this event?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                          handleDeleteEvent();
                                        },
                                        child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              color: LightTheme().pastelRed,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )).toList(),
                ),
              ),
            ),
          
          // Event distribution summary
          if (filteredEvents.isNotEmpty)
            ShadowedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Event Summary",
                    style: TextStyles.containerTitle,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildEventSummaryCard(
                          'Assignments',
                          filteredEvents.where((e) => e.type == EventType.assignment).length,
                          LightTheme().primaryBlue
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildEventSummaryCard(
                          'Activities',
                          filteredEvents.where((e) => e.type == EventType.activity).length,
                          LightTheme().pastelGreen
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildEventSummaryCard(
                          'Deadlines',
                          filteredEvents.where((e) => e.type == EventType.deadline).length,
                          LightTheme().pastelRed
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildEventSummaryCard(
                          'Meetings',
                          filteredEvents.where((e) => e.type == EventType.meeting).length,
                          Colors.purple
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildEventSummaryCard(
                          'Reminders',
                          filteredEvents.where((e) => e.type == EventType.reminder).length,
                          Colors.amber.shade700
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          
          // Upcoming events
          ShadowedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upcoming Events",
                  style: TextStyles.containerTitle,
                ),
                const SizedBox(height: 16),
                
                // Show next 5 upcoming events
                ...filteredEvents
                  .where((e) => e.date.isAfter(DateTime.now()) || 
                                (e.date.day == DateTime.now().day && 
                                 e.date.month == DateTime.now().month && 
                                 e.date.year == DateTime.now().year))
                  .toList()
                  .take(5)
                  .map((event) => ColoredPaddedContainer(
                    color: getEventColor(event.type).withOpacity(0.1),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 50,
                          color: getEventColor(event.type),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${event.className} • ${DateFormat('MMM d, yyyy').format(event.date)}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: getEventColor(event.type).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      event.type.displayName,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: getEventColor(event.type),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => handleEditEvent(event),
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  )),
                
                if (filteredEvents.where((e) => e.date.isAfter(DateTime.now())).isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'No upcoming events',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventSummaryCard(String title, int count, Color color) {
    return ColoredPaddedContainer(
      color: color.withOpacity(0.1),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // Event Dialog
void _showEventDialog() {
  if (!isModalOpen || selectedEvent == null) return;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(isEditMode ? 'Edit Event' : 'Add New Event'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: selectedEvent!.title),
                onChanged: (value) {
                  setState(() {
                    selectedEvent = selectedEvent!.copyWith(title: value);
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Class',
                  border: OutlineInputBorder(),
                ),
                value: selectedEvent!.className.isEmpty ? null : selectedEvent!.className,
                items: [
                  ...teacherDashboardController.classes.values.map((className) => DropdownMenuItem(
                    value: className,
                    child: Text(className),
                  )),
                ],
                onChanged: (value) {
                  if (value != null) {
                    String classId = teacherDashboardController.getClassId(value);
                    setState(() {
                      selectedEvent = selectedEvent!.copyWith(
                        className: value,
                        classId: classId,
                      );
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<EventType>(
                decoration: const InputDecoration(
                  labelText: 'Event Type',
                  border: OutlineInputBorder(),
                ),
                value: selectedEvent!.type,
                items: EventType.values.map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type.displayName),
                )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedEvent = selectedEvent!.copyWith(type: value);
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: selectedEvent!.description),
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    selectedEvent = selectedEvent!.copyWith(description: value);
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        _selectDate(context, selectedEvent!.date, (date) {
                          setState(() {
                            selectedEvent = selectedEvent!.copyWith(date: date);
                          });
                        });
                      },
                      icon: Icon(Icons.calendar_today),
                      label: Text(
                        'Date: ${DateFormat('yyyy-MM-dd').format(selectedEvent!.date)}',
                      ),
                    ),
                  ),
                  if (selectedEvent!.type == EventType.assignment) 
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {
                          _selectDate(context, selectedEvent!.dueDate, (date) {
                            setState(() {
                              selectedEvent = selectedEvent!.copyWith(dueDate: date);
                            });
                          });
                        },
                        icon: Icon(Icons.event_busy),
                        label: Text(
                          'Due: ${DateFormat('yyyy-MM-dd').format(selectedEvent!.dueDate)}',
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<EventStatus>(
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                value: selectedEvent!.status,
                items: EventStatus.values.map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status.displayName),
                )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedEvent = selectedEvent!.copyWith(status: value);
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              
              // Attachments Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Attachments',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Current attachments
                  if (selectedEvent!.attachments.isNotEmpty) ...[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        children: selectedEvent!.attachments.map((url) {
                          final fileName = selectedEvent!.getFileName(url);
                          
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: Row(
                              children: [
                                Icon(
                                  selectedEvent!.getFileIcon(url),
                                  color: LightTheme().primaryBlue,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    fileName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      selectedEvent = selectedEvent!.removeAttachment(url);
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  
                  // Add attachment button
                  OutlinedButton.icon(
                    onPressed: () async {
                      // In a real app, this would open a file picker or URL input dialog
                      final TextEditingController urlController = TextEditingController();
                      
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Add Attachment'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Enter URL to a PDF, document, or other file:',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: urlController,
                                decoration: const InputDecoration(
                                  labelText: 'URL',
                                  border: OutlineInputBorder(),
                                  hintText: 'https://example.com/file.pdf',
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final url = urlController.text.trim();
                                if (url.isNotEmpty) {
                                  setState(() {
                                    selectedEvent = selectedEvent!.addAttachment(url);
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.attach_file),
                    label: const Text('Add Attachment'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              isModalOpen = false;
              selectedEvent = null;
            });
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        if (isEditMode)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              
              // Show confirmation dialog
              Get.dialog(
                AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: const Text('Are you sure you want to delete this event?'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        handleDeleteEvent();
                      },
                      child: const Text('Delete', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ElevatedButton(
          onPressed: selectedEvent!.title.isNotEmpty && selectedEvent!.className.isNotEmpty
              ? () {
                  Navigator.of(context).pop();
                  handleSaveEvent();
                }
              : null,
          child: Text(isEditMode ? 'Update' : 'Save'),
        ),
      ],
    ),
  );
}
  Future<void> _selectDate(
    BuildContext context, 
    DateTime initialDate, 
    Function(DateTime) onSelect
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    
    if (pickedDate != null && pickedDate != initialDate) {
      onSelect(pickedDate);
    }
  }
}
