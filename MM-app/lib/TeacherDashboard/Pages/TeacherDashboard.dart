import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
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
  TeacherService _teacherService =
      TeacherService(currentTeacher: sampleTeacher);
  LocalAcademicService localAcademicService = LocalAcademicService();
  List<Student> classRoomStudents = [];
  List<Student> topPerformers = [];
  List<Student> supportStudents = [];
  String selectedClassId = "";
  late Classroom selectedClass;
  late Map<String, String> classes;
  //ids of all child Components
  late List<String> childComponents;

  String getClassId(String className) {
    if (classes.isNotEmpty) {
      return classes.entries
          .firstWhere(
            (tr) => tr.value == className,
          )
          .key;
    }
    throw Exception('Class not found');
  }

  void onClassPicked(String? className) {
    if (className != null) {
      selectedClassId = getClassId(className);
      teacherDashboardController.classId.value = selectedClassId;
      print("************Retrieved Id: $selectedClassId");
      setState(() {
        classRoomStudents = _teacherService.getClassStudents(selectedClassId);
        getCategorizedStudents();
        getClassroom();
        getComponents();
      });
    }
  }

  void getClassroom() {
    selectedClass = localAcademicService.getClassRoom(selectedClassId);
    print("******Retrieved Classroom ${selectedClass.lessonId}");
  }

  void getClasses() {
    classes = Map.fromEntries(
      sampleClassrooms.entries.map(
        (entry) => MapEntry(entry.key, entry.value.name),
      ),
    );
  }

  void getComponents() {
    if (selectedClassId.isNotEmpty) {
      childComponents =
          localAcademicService.getLessonComponents(selectedClass.lessonId);
    }
    print("********Components: $childComponents");
  }

  void getCategorizedStudents() {
    Map<String, List<Student>> categorizedSt =
        StudentService(student: classRoomStudents[0])
            .getCategorizedStudents(classRoomStudents);
    setState(() {
      topPerformers = categorizedSt['topPeformers']?.toList() ?? [];
      supportStudents = categorizedSt['needSupport']?.toList() ?? [];
      print("********Retrieved categorized students $topPerformers");
    });
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
