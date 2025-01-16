import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/SubPageSelectorRow.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  String currentPage = "OverView";
  String selectedClass = "All Classes";
  final String teacherName = "Mrs. Anderson";
  final String progressStatus = "In-Progress";
  final List<String> classes = [
    'All Classes',
    'Batch 1',
    'Batch 2',
    'Batch 3',
    'Batch 4',
  ];
  final TeacherDashboardController teacherDashboardController =
      Get.put(TeacherDashboardController());

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
              left: screenWidth * 0.02,
            ),
            const Spacer(),
            DropdownMenu(
              width: screenWidth * 0.4,
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors
                        .grey.shade500, // Set your desired border color here
                    width: 2.0, // Set border width here
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors
                        .grey.shade500, // Set your desired border color here
                    width: 2.0,
                  ),
                ),
              ),
              menuStyle: MenuStyle(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(
                    vertical: 2,
                  ),
                ),
                visualDensity:
                    VisualDensity.compact, // Reduce space between items
              ),
              initialSelection: selectedClass,
              onSelected: (value) {
                setState(() {
                  selectedClass = value.toString();
                });
              },
              dropdownMenuEntries: [
                ...classes.map(
                  (className) => DropdownMenuEntry(
                    value: className,
                    label: className,
                  ),
                ),
              ],
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
          height: screenHeight * 0.7,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
            ),
            child: Obx(
              () => teacherDashboardController
                  .pages[teacherDashboardController.pageIndex.value],
            ),
          ),
        ),
      ],
    )
        .marginSymmetric(
          horizontal: screenWidth * 0.1,
        )
        .marginOnly(
          top: screenHeight * 0.06,
        );
  }
}
