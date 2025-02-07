import 'package:flutter/material.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/StudentServices.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class StudentPerformance extends StatefulWidget {
  const StudentPerformance({
    super.key,
    required this.classStudents,
  });
  final List<Student> classStudents;
  @override
  State<StudentPerformance> createState() => _StudentPerformanceState();
}

class _StudentPerformanceState extends State<StudentPerformance> {
  // State variables
  Map<String, List<Student>> categorizedStudents = {};
  final Map<String, String> actions = {
    "What about those \$150 sneakers?": "Wait for next paycheck",
    "Planning for Emergencies": "Set aside \$150",
    "What about those \$120 sneakers?": "Wait for next paycheck",
  };

  int selectedStudentIndex = 0;
  List<Student> topPerformers = [];
  List<Student> supportStudents = [];
  List<Student> studentList = [];
  String currentFilter = 'allStudents';
  late Student selectedStudent;
  late StudentService studentService;
  final LocalAcademicService localAcademicService = LocalAcademicService();

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  void didUpdateWidget(StudentPerformance oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.classStudents != oldWidget.classStudents) {
      initializeData();
    }
  }

  void initializeData() {
    if (widget.classStudents.isNotEmpty) {
      setState(() {
        currentFilter = 'allStudents';
        studentList = widget.classStudents;
        selectedStudent = widget.classStudents[0];
        selectedStudentIndex = 0;
        studentService = StudentService(student: selectedStudent);
        getCategorizedStudents();
      });
    } else {
      setState(() {
        currentFilter = 'allStudents';
        studentList = [];
        topPerformers = [];
        supportStudents = [];
      });
    }
  }

  void getCategorizedStudents() {
    Map<String, List<Student>> categorizedSt =
        StudentService(student: selectedStudent)
            .getCategorizedStudents(widget.classStudents);
    setState(() {
      topPerformers = categorizedSt['topPeformers']?.toList() ?? [];
      supportStudents = categorizedSt['needSupport']?.toList() ?? [];
    });
  }

  void setSelectedStudent(int index) {
    if (index >= 0 && index < studentList.length) {
      setState(() {
        selectedStudentIndex = index;
        selectedStudent = studentList[index];
        studentService = StudentService(student: selectedStudent);
      });
    }
  }

  Color getFilterButtonColor(String filter) {
    if (currentFilter == filter) {
      return LightTheme().primaryBlue.withValues(alpha: 0.2);
    }
    return Colors.transparent;
  }

  Color getFilterTextColor(String filter) {
    if (currentFilter == filter) {
      return LightTheme().primaryBlue;
    }
    return Colors.grey.shade500;
  }

  void filterStudents(String category) {
    setState(() {
      currentFilter = category;
      switch (category) {
        case 'allStudents':
          studentList = widget.classStudents;
          break;
        case 'topPerformers':
          studentList = topPerformers;
          break;
        case 'needSupport':
          studentList = supportStudents;
          break;
      }
      // Reset selection to first student in filtered list if list is not empty
      if (studentList.isNotEmpty) {
        setSelectedStudent(0);
      }
    });
  }

  Color getStatusColor(StudentStatus status) {
    switch (status) {
      case StudentStatus.Ahead:
        return LightTheme().primaryBlue;
      case StudentStatus.On_Track:
        return LightTheme().pastelGreen;
      case StudentStatus.Behind:
        return LightTheme().pastelRed;
      default:
        return Colors.grey;
    }
  }

  StudentStatus getStudentStatus(double progress) {
    if (progress > 1) {
      return StudentStatus.Ahead;
    } else if (progress > 0.6) {
      return StudentStatus.On_Track;
    } else {
      return StudentStatus.Behind;
    }
  }

  Widget _buildProgressSection(String title, String subtitle, double progress) {
    Color progressColor =
        progress > 0.6 ? LightTheme().pastelGreen : LightTheme().pastelRed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.containerTitle.copyWith(
            fontSize: 20,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade400,
          ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            LinearProgressIndicator(
              backgroundColor: Colors.grey.shade300,
              color: progressColor,
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
              value: progress.clamp(0.0, 1.0),
            ),
            Positioned(
              right: 8,
              top: -4,
              child: Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: progressColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.classStudents.isEmpty) {
      return const SizedBox(
        child: Text("Either there are no students, or they're being loaded."),
      );
    }

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Panel - Student List
        Expanded(
          flex: 2,
          child: ShadowedContainer(
            height: screenHeight * 0.85,
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Students",
                  style: TextStyles.containerTitle,
                ),
                const SizedBox(height: 8),
                // Filter Buttons with improved highlighting
                FilterStudentsButton(
                  filter: "All Students",
                  onPressed: () => filterStudents('allStudents'),
                  backgroundColor: getFilterButtonColor('allStudents'),
                  textColor: getFilterTextColor('allStudents'),
                ),
                FilterStudentsButton(
                  filter: "Top Performers",
                  onPressed: () => filterStudents('topPerformers'),
                  backgroundColor: getFilterButtonColor('topPerformers'),
                  textColor: getFilterTextColor('topPerformers'),
                ),
                FilterStudentsButton(
                  filter: "Needs Support",
                  onPressed: () => filterStudents('needSupport'),
                  backgroundColor: getFilterButtonColor('needSupport'),
                  textColor: getFilterTextColor('needSupport'),
                ),
                const SizedBox(height: 8),
                // Scrollable Student List
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: studentList.isEmpty
                          ? [const Text("No students in Class")]
                          : List.generate(studentList.length, (index) {
                              final student = studentList[index];
                              final studentService =
                                  StudentService(student: student);
                              final lessonProgress =
                                  studentService.getLessonProgress();
                              final status = getStudentStatus(lessonProgress);
                              final statusColor = getStatusColor(status);

                              return GestureDetector(
                                onTap: () => setSelectedStudent(index),
                                child: ColoredPaddedContainer(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  color: selectedStudentIndex == index
                                      ? LightTheme()
                                          .primaryBlue
                                          .withValues(alpha: 0.2)
                                      : Colors.transparent,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          student.profile.fullName,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey.shade500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ColoredPaddedContainer(
                                        width: screenWidth * 0.06,
                                        margin: EdgeInsets.zero,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        color:
                                            statusColor.withValues(alpha: 0.3),
                                        child: Text(
                                          status.name.replaceAll('_', ' '),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: statusColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Right Panel - Student Details
        Expanded(
          flex: 5,
          child: studentList.isEmpty
              ? const Center(child: Text("No student selected"))
              : ShadowedContainer(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.02,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Student Header with dynamic status color
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedStudent.profile.fullName,
                                    style: TextStyles.containerTitle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Current Lesson: ${localAcademicService.getLessonName(selectedStudent.progress.substring(0, 5))}",
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            ColoredPaddedContainer(
                              width: screenWidth * 0.08,
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              color: getStatusColor(
                                      studentService.getStatusFromProgress())
                                  .withValues(alpha: 0.3),
                              child: Text(
                                studentService
                                    .getStatusFromProgress()
                                    .name
                                    .replaceAll('_', ' '),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: getStatusColor(
                                      studentService.getStatusFromProgress()),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        // Progress sections with improved visual feedback
                        Row(
                          children: [
                            Expanded(
                              child: _buildProgressSection(
                                "Lesson Progress",
                                "Current Lesson",
                                studentService.getLessonProgress(),
                              ),
                            ),
                            const SizedBox(width: 50),
                            Expanded(
                              child: _buildProgressSection(
                                "Overall Progress",
                                "Course Completion",
                                studentService.getOverallProgress(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        // Recent Progress Section
                        Text(
                          "Recent Progress",
                          style: TextStyles.containerTitle,
                        ),
                        ...actions.entries.map(
                          (entry) => ColoredPaddedContainer(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        entry.key,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(entry.value),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.transparent,
                                  child: Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FCheck%20circle.png?alt=media&token=52726418-7a0a-4b6c-9207-1efa735199af",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("See more"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class FilterStudentsButton extends StatelessWidget {
  const FilterStudentsButton({
    super.key,
    required this.filter,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
  });

  final String filter;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        child: Text(
          filter,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
