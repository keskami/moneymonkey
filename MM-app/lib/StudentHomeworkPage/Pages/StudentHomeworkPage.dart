import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:money_monkey/Backend/Models/CalendarEvent.dart';
import 'package:money_monkey/StudentHomeworkPage/Widgets/StudentCalendart.dart';
import 'package:money_monkey/themes/color_themes.dart';

// Import the StudentCalendar widget
// import 'package:money_monkey/StudentHomeworkPage/Widgets/StudentCalendar.dart';

class StudentHomeworkPage extends StatefulWidget {
  const StudentHomeworkPage({Key? key}) : super(key: key);

  @override
  _StudentHomeworkPageState createState() => _StudentHomeworkPageState();
}

class _StudentHomeworkPageState extends State<StudentHomeworkPage> {
  // Sample events for the calendar
  final List<CalendarEvent> events = [
    CalendarEvent(
      id: '1',
      title: 'Math Assignment 3.2',
      date: DateTime.now().add(const Duration(days: 7)),
      dueDate:
          DateTime.now().add(const Duration(days: 7, hours: 23, minutes: 59)),
      classId: 'math101',
      className: 'Mathematics',
      description: 'Complete problems 1-15 from Chapter 3',
      status: EventStatus.visible,
      type: EventType.assignment,
    ),
    CalendarEvent(
      id: '2',
      title: 'History Essay',
      date: DateTime.now().add(const Duration(days: 19)),
      dueDate:
          DateTime.now().add(const Duration(days: 19, hours: 23, minutes: 59)),
      classId: 'hist101',
      className: 'History',
      description: 'Write a 500-word essay on the Industrial Revolution',
      status: EventStatus.visible,
      type: EventType.assignment,
    ),
    CalendarEvent(
      id: '3',
      title: 'Science Lab Report',
      date: DateTime.now().add(const Duration(days: 30)),
      dueDate:
          DateTime.now().add(const Duration(days: 30, hours: 23, minutes: 59)),
      classId: 'sci101',
      className: 'Science',
      description: 'Complete lab report for the photosynthesis experiment',
      status: EventStatus.visible,
      type: EventType.assignment,
    ),
    CalendarEvent(
      id: '4',
      title: 'Utilities Due',
      date: DateTime(DateTime.now().year, DateTime.now().month, 10),
      dueDate: DateTime(DateTime.now().year, DateTime.now().month, 10),
      classId: 'finance101',
      className: 'Personal Finance',
      description: 'Pay utility bills',
      status: EventStatus.visible,
      type: EventType.deadline,
    ),
    CalendarEvent(
      id: '5',
      title: 'CC Min. Due',
      date: DateTime(DateTime.now().year, DateTime.now().month, 25),
      dueDate: DateTime(DateTime.now().year, DateTime.now().month, 25),
      classId: 'finance101',
      className: 'Personal Finance',
      description: 'Pay credit card minimum payment',
      status: EventStatus.visible,
      type: EventType.deadline,
    ),
  ];

  void _handleEventSelected(CalendarEvent event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Class: ${event.className}'),
            const SizedBox(height: 8),
            Text(
                'Due: ${DateFormat('MMM d, yyyy - h:mm a').format(event.dueDate)}'),
            const SizedBox(height: 8),
            Text('Description: ${event.description}'),
            if (event.attachments.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text('Attachments:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ...event.attachments.map((url) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(event.getFileIcon(url)),
                    title: Text(event.getFileName(url)),
                    dense: true,
                  ))
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive sizing
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: LightTheme().primaryBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(screenHeight, screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _buildProgressCards(screenHeight, screenWidth)
                  .marginSymmetric(horizontal:  screenHeight * 0.015),
              Card(
                elevation: 2,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(5),
              ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  child: StudentCalendar(
                    events: events,
                    onEventSelected: _handleEventSelected,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                ),
              ).marginAll(screenHeight * 0.015),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double screenHeight, double screenWidth) {
    // Calculate size factors
    final double fontSize = screenHeight * 0.018;
    final double iconSize = screenHeight * 0.03;
    final double spacing = screenWidth * 0.02;

    return Container(
      height: screenHeight * 0.07,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Goals & Tasks',
            style: GoogleFonts.baloo2(
              fontSize: fontSize * 1.3,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              _buildAchievementBadge(
                  Icons.menu_book, 3, Colors.brown, iconSize, fontSize),
              SizedBox(width: spacing),
              _buildAchievementBadge(
                  Icons.note, 3, Colors.black, iconSize, fontSize),
              SizedBox(width: spacing),
              _buildAchievementBadge(
                  Icons.star, 3, Colors.amber, iconSize, fontSize),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(
      IconData icon, int count, Color color, double iconSize, double fontSize) {
    return Row(
      children: [
        Icon(icon, color: color, size: iconSize),
        SizedBox(width: 4),
        Text(
          '$count',
          style: GoogleFonts.baloo2(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
Widget _buildAssignmentStat(String value, String label, double fontSize,
      {required Alignment alignment, bool isGrade = false}) {
    return Container(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: GoogleFonts.baloo2(
              fontSize: fontSize * 5.0,
              fontWeight: FontWeight.w700,
              color: isGrade ? Colors.green : Colors.black,
              height: 1, // Reduce line height
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            label,
            style: GoogleFonts.baloo2(
              fontSize: fontSize * 1.8,
              color: Colors.grey.shade600,
              height: 0.8, // Reduce line height
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  } 
   Widget _buildProgressCards(double screenHeight, double screenWidth) {
    // Calculate sizing factors based on screen dimensions
    final double fontSize = screenHeight * 0.016;
    final double cardHeight =
        screenHeight * 0.20; // Reduced from 0.25 to 0.20
    final double progressBarHeight = screenHeight * 0.010; // Slightly smaller
    final double spacing = screenHeight * 0.008; // Reduced spacing

    return Container(
      height: cardHeight*1.21,
      width: screenWidth,
      child: Row(
        children: [
          // Course Completion Card
          Expanded(
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course Completion',
                      style: GoogleFonts.baloo2(
                        fontSize: fontSize * 1.5, // Slightly smaller
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spacing),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: 0.35,
                        minHeight: progressBarHeight,
                        backgroundColor: Colors.grey.shade300,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blue.shade300),
                      ),
                    ),
                    Text(
                      '35%',
                      style: GoogleFonts.baloo2(
                        fontSize: fontSize * 1.3, // Reduced
                        fontWeight: FontWeight.bold,
                        color: LightTheme().primaryBlue,
                      ),
                    ),
                    Text(
                      'Assignments & Grade',
                      style: GoogleFonts.baloo2(
                        fontSize: fontSize * 1.3, // Reduced
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildAssignmentStat(
                              '03',
                              'In progress',
                              fontSize * 0.7, // Reduced
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.05, // Reduced
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          Expanded(
                            child: _buildAssignmentStat(
                              '21',
                              'Completed',
                              fontSize * 0.7, // Reduced
                              alignment: Alignment.center,
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.05, // Reduced
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          Expanded(
                            child: _buildAssignmentStat(
                              'A',
                              'Current grade',
                              fontSize * 0.7, // Reduced
                              alignment: Alignment.centerRight,
                              isGrade: true,
                            ),
                          ),
                        ],
                      ),
                    ).paddingSymmetric(horizontal: screenWidth * 0.01),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          // Personal Goals Card
          Expanded(
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Goals',
                      style: GoogleFonts.baloo2(
                        fontSize: fontSize * 1.5, // Slightly smaller
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spacing),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.diamond,
                            color: Colors.blue.shade300,
                            size: fontSize * 1.8, // Reduced
                          ),
                          SizedBox(width: spacing),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Score 80% or higher in 2 lessons',
                                  style: GoogleFonts.baloo2(
                                    fontSize: fontSize * 1.3, // Reduced
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spacing),
                                SizedBox(
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: LinearProgressIndicator(
                                      value: 0.6,
                                      minHeight: progressBarHeight,
                                      backgroundColor: Colors.grey.shade300,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.blue.shade300),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } 
}

// StudentCalendar implementation
// In a real application, you would move this to a separate file
