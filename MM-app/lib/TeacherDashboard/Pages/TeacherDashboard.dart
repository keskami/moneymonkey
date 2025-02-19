import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/Backend/Services/StudentServices.dart';
import 'package:money_monkey/Backend/Services/TeacherServices.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Pages/ClassroomPreferences.dart';
import 'package:money_monkey/TeacherDashboard/Pages/LessonManagement.dart';
import 'package:money_monkey/TeacherDashboard/Pages/Overview.dart';
import 'package:money_monkey/TeacherDashboard/Pages/PlaceHolderTab.dart';
import 'package:money_monkey/TeacherDashboard/Pages/StudentPerformance.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/CustomDropDownMenu.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/SubPageSelectorRow.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final TeacherDashboardController teacherDashboardController =
      Get.put(TeacherDashboardController());
  final TeacherService _teacherService =
      TeacherService(currentTeacher: sampleTeacher);
  final LocalAcademicService localAcademicService = LocalAcademicService();

  List<Student> classRoomStudents = [];
  List<Student> topPerformers = [];
  List<Student> supportStudents = [];
  String selectedClassId = "";
  Teacher loggedInTeacher = sampleTeacher;
  late Classroom selectedClass;
  late Map<String, String> classes;
  late List<String> childComponents;

  String getClassId(String className) {
    return classes.entries
        .firstWhere((tr) => tr.value == className)
        .key;
  }

  Future<void> onClassPicked(String? className) async {
  if (className != null) {
    // Update the selected class ID
    selectedClassId = getClassId(className);
    teacherDashboardController.classId.value = selectedClassId;
    
    // Refresh class data with proper state management
    await refreshClassData();
  }
}

Future<void> refreshClassData() async {
  try {
    // Get the updated classroom data
    selectedClass = localAcademicService.getClassRoom(selectedClassId);
    
    // Fetch students and components in a way that ensures proper state updates
    final students = _teacherService.getClassStudents(selectedClassId);
    final components = localAcademicService.getLessonComponents(selectedClass.lessonId);
    
    // Update state properly with setState to trigger UI updates
    setState(() {
      classRoomStudents = students;
      childComponents = components;
      
      // Clear and update categorized students lists within setState
      topPerformers = [];
      supportStudents = [];
    });
    
    // Categorize students after state update
    if (classRoomStudents.isNotEmpty) {
      getCategorizedStudents();
    }
  } catch (e) {
    // Handle potential errors
    print('Error refreshing class data: $e');
    // Could show a snackbar or dialog here to inform user
  }
}

void getCategorizedStudents() {
  if (classRoomStudents.isEmpty) return;
  
  try {
    final categorizedSt = StudentService(student: classRoomStudents[0])
        .getCategorizedStudents(classRoomStudents);
    
    setState(() {
      topPerformers = categorizedSt['topPeformers'] ?? [];
      supportStudents = categorizedSt['needSupport'] ?? [];
    });
  } catch (e) {
    print('Error categorizing students: $e');
  }
}
  void getClasses() {
    classes = Map.fromEntries(
      sampleClassrooms.entries
          .where((entry) => loggedInTeacher.classRooms.contains(entry.key))
          .map((entry) => MapEntry(entry.key, entry.value.name)),
    );
  }


  @override
  void initState() {
    super.initState();
    getClasses();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Teacher Dashboard",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenHeight * 0.04),
        Row(
          children: [
            CircleAvatar(radius: 25),
            Text(
              "Welcome,\n${sampleTeacher.name}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ).marginOnly(left: screenWidth * 0.01),
            const Spacer(),
            CustomDropDownContainer(
              width: screenWidth * 0.3,
              items: classes.values.toList(),
              onChanged: onClassPicked,
            ),
          ],
        ).marginSymmetric(horizontal: screenWidth * 0.05),
        DashboardSubPageSelector().marginSymmetric(
          vertical: screenHeight * 0.02,
          horizontal: screenWidth * 0.05,
        ),
        Container(
          height: screenHeight * 0.65,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Obx(() {
            if (teacherDashboardController.classId.value.isEmpty)
              return TeacherDashoardPlaceHolderPage();
            else {
              switch (teacherDashboardController.pageIndex.value) {
                case 0:
                  return DashboardOverview(
                    supportStudents: supportStudents,
                    topPerformers: topPerformers,
                    components: childComponents,
                    currentLessonId: selectedClass.lessonId,
                  );
                case 1:
                  return LessonManagement();
                case 2:
                  print("************Sending Students $classRoomStudents");
                  return StudentPerformance(
                    classStudents: classRoomStudents,
                    topPerformers: topPerformers,
                    supportStudents: supportStudents,
                  );
                default:
                  return ClassroomPreferences(
                    supportStudentsCount: supportStudents.length,
                    topPerformersCounts: topPerformers.length,
                    totalStudentsCount: classRoomStudents.length,
                  );
              }
            }
          }),
        ),
      ],
    )
        .marginSymmetric(
          horizontal: screenWidth * 0.1,
        )
        .marginOnly(
          top: screenHeight * 0.04,
        );
  }
}
