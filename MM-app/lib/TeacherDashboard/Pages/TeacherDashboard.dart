import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
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
  List<Student> classRoomStudents = [];
  Map<String, List<Student>> categorizedStudents = {};
  String selectedClassId = "";
  late Map<String, String> classes;

  void getClassStudents() {
    classRoomStudents = sampleStudents
        .where(
          (student) => student.classRooms
              .contains(teacherDashboardController.classId.value),
        )
        .toList();
  }

  void onClassPicked(String? className) {
    if (className != null) {
      String selectedClassId =
          classes.entries.firstWhere((entry) => entry.value == className).key;
      print(selectedClassId);
      teacherDashboardController.classId.value = selectedClassId;
      print(teacherDashboardController.classId.value);

      teacherDashboardController.lessonId.value =
          sampleClassrooms[selectedClassId]?.lessonId ?? '';

      getClassStudents();
      categorizeStudents();
    }
  }

  void getClasses() {
    classes = Map.fromEntries(
      sampleClassrooms.entries.map(
        (entry) => MapEntry(entry.key, entry.value.name),
      ),
    );
  }

  void categorizeStudents() {
    String currentLessonId =
        sampleClassrooms[teacherDashboardController.classId.value]?.lessonId ??
            '';

    final topPerformers = <Student>[];
    final needsSupport = <Student>[];

    for (var student in classRoomStudents) {
      StudentStatus status = student.getCurrentLessonProgress(currentLessonId);
      double score = calculateStudentScore(student, status);

      if (score >= 85) {
        topPerformers.add(student);
      } else if (score <= 40 || status == StudentStatus.Behind) {
        needsSupport.add(student);
      }
    }

    topPerformers.sort(
        (a, b) => b.profile.portfolioScore.compareTo(a.profile.portfolioScore));
    needsSupport.sort(
        (a, b) => a.profile.portfolioScore.compareTo(b.profile.portfolioScore));

    categorizedStudents = {
      'topPerformers': topPerformers,
      'needsSupport': needsSupport,
    };
  }

  double calculateStudentScore(Student student, StudentStatus status) {
    double score = student.profile.portfolioScore * 0.4;
    score += (student.profile.streak / 60) * 25;

    switch (status) {
      case StudentStatus.Ahead:
        score += 35;
        break;
      case StudentStatus.On_Track:
        score += 25;
        break;
      case StudentStatus.Behind:
        score += 10;
        break;
    }

    final unitProgress = student.getCurrentUnitProgress(
      teacherDashboardController.lessonId.value,
    );

    if (unitProgress < 0) score *= 0.8;

    return score;
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
                  return DashboardOverview();
                case 1:
                  return LessonManagement();
                case 2:
                  return StudentPerformace(classStudents: classRoomStudents);
                default:
                  return ClassroomPreferences();
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
