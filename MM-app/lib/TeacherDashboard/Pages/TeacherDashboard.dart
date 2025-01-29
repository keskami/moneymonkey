import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/CustomDropDownMenu.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/SubPageSelectorRow.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  Teacher currentTeacher = Teacher(
    name: "Mrs. Anderson",
    id: "temporaryTeacherId2025",
    classRooms: [
      Classroom(
        classId: 'tempClassId2025',
        name: "Class1",
        teacherId: 'temporaryTeacherId2025',
        studentIds: [],
        lessonId: 'tempLessonId2025',
        upcomingLessonId: 'tempUpcomingLessonId2025',
        performanceData: PerformanceTrends(
          classAverage: 76,
          participationRate: 56.5,
          lessonCompletion: 87.7,
        ),
      ),
    ],
  );
  String currentPage = "OverView";
  String selectedClass = "All Classes";
  final String teacherName = "Mrs. Anderson";
  final String progressStatus = "In-Progress";
  Map<String, String> classes = {};
  final List<String> Tclasses = [
    'All Classes',
    'Batch 1',
    'Batch 2',
    'Batch 3',
    'Batch 4',
  ];
  final TeacherDashboardController teacherDashboardController =
      Get.put(TeacherDashboardController());

  void onClassPicked(String? className) {
    if (className != null)
      setState(() {
        selectedClass = className;
      });
  }

  void getClasses() {
    classes = currentTeacher.getClasses();
    ;
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
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.04,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 25,
            ),
            Text(
              "Welcome,\n $teacherName",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ).marginOnly(
              left: screenWidth * 0.01,
            ),
            const Spacer(),
            CustomDropDownContainer(
              width: screenWidth * 0.4,
              items: classes.entries.map((entry) {
                return entry.value;
              }).toList(),
              onChanged: onClassPicked,
              initialSelection: selectedClass,
            ),
          ],
        ).marginSymmetric(
          horizontal: screenWidth * 0.05,
        ),
        DashboardSubPageSelector().marginSymmetric(
          vertical: screenHeight * 0.02,
          horizontal: screenWidth * 0.05,
        ),
        Container(
          height: screenHeight * 0.65,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ),
          child: Obx(
            () => teacherDashboardController
                .pages[teacherDashboardController.pageIndex.value],
          ),
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
