import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Pages/PlaceHolderTab.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/CustomDropDownMenu.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/SubPageSelectorRow.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  Teacher _sampleTeacher = sampleTeacher;
  String currentPage = "OverView";
  String selectedClassId = "";
  final String teacherName = "Mrs. Anderson";
  final String progressStatus = "In-Progress";
  Map<String, String> classes = {};
  final TeacherDashboardController teacherDashboardController =
      Get.put(TeacherDashboardController());

  void onClassPicked(String? className) {
    if (className != null) {
      setState(() {
        selectedClassId =
            classes.entries.firstWhere((entry) => entry.value == className).key;
      });
    }
  }

  void getClasses() {
    classes = _sampleTeacher.getClasses();
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
              width: screenWidth * 0.3,
              items: classes.values.toList(),
              onChanged: onClassPicked,
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
          child: selectedClassId == ""
              ? TeacherDashoardPlaceHolderPage()
              : Obx(
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
