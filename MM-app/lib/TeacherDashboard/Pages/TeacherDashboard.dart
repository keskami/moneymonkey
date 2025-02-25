import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
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
  void onClassPicked(String? classId) {
    if (classId != null) {
      print("**********CLass id: $classId");
      teacherDashboardController.selectedClassId = teacherDashboardController.classes.entries.firstWhere((entry)=>entry.value==classId).key ;
      print(("***************Selected ID: ${teacherDashboardController.selectedClassId}"));
      teacherDashboardController.refreshAllData();
      
    }
  }

  @override
  void initState() {
    super.initState();
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
              items: teacherDashboardController.classes.values.toList(),
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
          child: Obx(() =>teacherDashboardController.currentPage.value),
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
