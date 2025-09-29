import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/StudentServices.dart';
import 'package:money_monkey/Backend/Services/DirectFirebaseService.dart'; // Updated import
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/PlaceHolderTab.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class StudentPerformance extends StatefulWidget {
  const StudentPerformance({super.key});
  @override
  State<StudentPerformance> createState() => _StudentPerformanceState();
}

class _StudentPerformanceState extends State<StudentPerformance> {
  // State variables
  String currentFilter = 'allStudents';
  int selectedStudentIndex = 0;
  List<Student> studentList = [];
  final DirectFirebaseService _firebaseService = DirectFirebaseService(); // Updated service
  TeacherDashboardController teacherDashboardController = Get.find<TeacherDashboardController>();
  
  // Add loading indicators for asynchronous operations
  bool isLoadingStatus = false;
  bool isLoadingProgress = false;
  
  // Cache for student statuses and progress to avoid repeated Firebase calls
  Map<String, StudentStatus> studentStatusCache = {};
  Map<String, double> lessonProgressCache = {};
  Map<String, double> overallProgressCache = {};

  @override
  void initState() {
    super.initState();
    initializeStudents();
  }

  void initializeStudents() {
    studentList = teacherDashboardController.classRoomStudents.value;
    // Preload progress and status for visible students
    if (studentList.isNotEmpty) {
      _preloadStudentData();
    }
  }
  
  // Preload data for visible students to improve UI responsiveness
  Future<void> _preloadStudentData() async {
    setState(() {
      isLoadingProgress = true;
    });
    
    try {
      for (final student in studentList.take(10)) { // Only preload first 10 for performance
        await _getStudentStatus(student);
        await _getLessonProgress(student);
      }
    } catch (e) {
      print('Error preloading student data: $e');
    } finally {
      setState(() {
        isLoadingProgress = false;
      });
    }
  }

  void setSelectedStudent(int index) {
    if (index >= 0 && index < teacherDashboardController.classRoomStudents.value.length) {
      setState(() {
        selectedStudentIndex = index; // Update the selected index
        teacherDashboardController.selectedStudent = teacherDashboardController.classRoomStudents.value[index];
      });
      
      // Preload data for the selected student
      _getStudentStatus(teacherDashboardController.selectedStudent);
      _getLessonProgress(teacherDashboardController.selectedStudent);
      _getOverallProgress(teacherDashboardController.selectedStudent);
    }
  }

  Color getFilterButtonColor(String filter) {
    if (currentFilter == filter) {
      return LightTheme().primaryBlue.withOpacity(0.2);
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
          studentList = teacherDashboardController.classRoomStudents.value;
          break;
        case 'topPerformers':
          studentList = teacherDashboardController.topPerformers.value;
          break;
        case 'needSupport':
          studentList = teacherDashboardController.supportStudents.value;
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
      case StudentStatus.OnTrack:
        return LightTheme().pastelGreen;
      case StudentStatus.Behind:
        return LightTheme().pastelRed;
      default:
        return Colors.grey;
    }
  }

  // Get student status with caching to avoid repeated Firebase calls
  Future<StudentStatus> _getStudentStatus(Student student) async {
    if (studentStatusCache.containsKey(student.userId)) {
      return studentStatusCache[student.userId]!;
    }
    
    setState(() {
      isLoadingStatus = true;
    });
    
    try {
      final studentService = StudentService(student: student);
      final status = await studentService.getStatusFromProgress();
      
      // Cache the result
      studentStatusCache[student.userId] = status;
      return status;
    } catch (e) {
      print('Error getting student status: $e');
      return StudentStatus.OnTrack; // Default fallback
    } finally {
      setState(() {
        isLoadingStatus = false;
      });
    }
  }
  
  // Get lesson progress with caching
  Future<double> _getLessonProgress(Student student) async {
    if (lessonProgressCache.containsKey(student.userId)) {
      return lessonProgressCache[student.userId]!;
    }
    
    try {
      final studentService = StudentService(student: student);
      final progress = await studentService.getLessonProgress();
      
      // Cache the result
      lessonProgressCache[student.userId] = progress;
      return progress;
    } catch (e) {
      print('Error getting lesson progress: $e');
      return 0.0; // Default fallback
    }
  }
  
  // Get overall progress with caching
  Future<double> _getOverallProgress(Student student) async {
    if (overallProgressCache.containsKey(student.userId)) {
      return overallProgressCache[student.userId]!;
    }
    
    try {
      final studentService = StudentService(student: student);
      final progress = await studentService.getOverallProgress();
      
      // Cache the result
      overallProgressCache[student.userId] = progress;
      return progress;
    } catch (e) {
      print('Error getting overall progress: $e');
      return 0.0; // Default fallback
    }
  }

  Widget _buildProgressSection(String title, String subtitle, Future<double> progressFuture) {
    return FutureBuilder<double>(
      future: progressFuture,
      builder: (context, snapshot) {
        // Show loading indicator while waiting
        if (snapshot.connectionState == ConnectionState.waiting) {
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
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        }
        
        // Get progress value or default to 0
        final progress = snapshot.data ?? 0.0;
        
        // Determine color based on progress
        Color progressColor = progress > 0.6
            ? LightTheme().pastelGreen
            : LightTheme().pastelRed;

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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (teacherDashboardController.selectedClassId.isEmpty)
      return TeacherDashoardPlaceHolderPage();
    if (teacherDashboardController.classRoomStudents.value.isEmpty) {
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
                  child: isLoadingProgress 
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: studentList.isEmpty
                          ? [const Text("No students in Class")]
                          : List.generate(studentList.length, (index) {
                              final student = studentList[index];
                              
                              // Use FutureBuilder for status badge since it depends on async operation
                              return GestureDetector(
                                onTap: () => setSelectedStudent(index),
                                child: ColoredPaddedContainer(
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  color: selectedStudentIndex == index
                                      ? LightTheme()
                                          .primaryBlue
                                          .withOpacity(0.2)
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
                                      FutureBuilder<StudentStatus>(
                                        future: _getStudentStatus(student),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            );
                                          }
                                          
                                          final status = snapshot.data ?? StudentStatus.OnTrack;
                                          final statusColor = getStatusColor(status);
                                          
                                          return ColoredPaddedContainer(
                                            width: screenWidth * 0.06,
                                            margin: EdgeInsets.zero,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10,
                                            ),
                                            color: statusColor.withOpacity(0.3),
                                            child: Text(
                                              status.name.replaceAll('_', ' '),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: statusColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        },
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
                                    teacherDashboardController
                                        .selectedStudent.profile.fullName,
                                    style: TextStyles.containerTitle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  FutureBuilder<String>(
                                    future: _getLessonName(teacherDashboardController
                                        .selectedStudent.progress.substring(0, 5)),
                                    builder: (context, snapshot) {
                                      final lessonName = snapshot.data ?? "Loading...";
                                      return Text(
                                        "Current Lesson: $lessonName",
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            FutureBuilder<StudentStatus>(
                              future: _getStudentStatus(teacherDashboardController.selectedStudent),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                                
                                final status = snapshot.data ?? StudentStatus.OnTrack;
                                final statusColor = getStatusColor(status);
                                
                                return ColoredPaddedContainer(
                                  width: screenWidth * 0.08,
                                  margin: EdgeInsets.zero,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                  color: statusColor.withOpacity(0.3),
                                  child: Text(
                                    status.name.replaceAll('_', ' '),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
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
                                _getLessonProgress(teacherDashboardController.selectedStudent),
                              ),
                            ),
                            const SizedBox(width: 50),
                            Expanded(
                              child: _buildProgressSection(
                                "Overall Progress",
                                "Course Completion",
                                _getOverallProgress(teacherDashboardController.selectedStudent),
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
                        ...teacherDashboardController.actions.entries.map(
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
  
  // Helper method to get lesson name using DirectFirebaseService
  Future<String> _getLessonName(String lessonId) async {
    try {
      final lesson = await _firebaseService.getLesson(lessonId);
      return lesson.title;
    } catch (e) {
      print('Error getting lesson name: $e');
      return "Unknown Lesson";
    }
  }
}

extension ColorExtension on Color {
  Color withValues({required double alpha}) {
    return this.withOpacity(alpha);
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
          padding: const WidgetStatePropertyAll(
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