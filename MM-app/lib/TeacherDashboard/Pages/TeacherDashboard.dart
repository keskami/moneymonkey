import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/CustomDropDownMenu.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/SubPageSelectorRow.dart';
import 'package:money_monkey/themes/color_themes.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final TeacherDashboardController teacherDashboardController =
      Get.put(TeacherDashboardController());
  bool isLoading = true;

  void onClassPicked(String? classId) {
    if (classId != null) {
      teacherDashboardController.selectedClassId.value =
          teacherDashboardController.classes.entries
              .firstWhere((entry) => entry.value == classId)
              .key;
      teacherDashboardController.refreshAllData();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      setState(() {
        isLoading = true;
      });

      //Initialize cache file
      // await TeacherCacheBuilder().buildTeacherCache(sampleTeacher.id);
      // // Initialize the controller with cached data
      // await teacherDashboardController.initializeFromCache();
      await teacherDashboardController.initializeFromLocalFile();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading dashboard data: $e');
      setState(() {
        isLoading = false;
      });

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error Loading Data'),
          content: Text('Failed to load dashboard data. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading dashboard data...'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Teacher Dashboard",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Obx(() => IconButton(
                    onPressed: () {
                      showAlignedDialog(
                        context: context,
                        builder: (context) => Container(
                          width: screenWidth * 0.4,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Student Requests",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              if (teacherDashboardController
                                      .selectedClassId.isEmpty ||
                                  teacherDashboardController
                                      .selectedClass.studentRequests.isEmpty)
                                Text(
                                  "No pending requests",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                )
                              else
                                ...teacherDashboardController
                                    .selectedClass.studentRequests.entries
                                    .map((entry) {
                                  final studentName = entry.value;

                                  return GestureDetector(
                                    onTap: () {
                                      // Handle student selection here
                                      Navigator.pop(context);
                                    },
                                    child: ColoredPaddedContainer(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 10),
                                      color: Colors.transparent,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              studentName,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey.shade700,
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
                                              vertical: 8,
                                            ),
                                            color: LightTheme()
                                                .primaryBlue
                                                .withOpacity(0.2),
                                            child: Text(
                                              "PENDING",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: LightTheme().primaryBlue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              SizedBox(height: 8),
                              if (teacherDashboardController
                                      .selectedClassId.isNotEmpty &&
                                  teacherDashboardController
                                      .selectedClass.studentRequests.isNotEmpty)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Close"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      teacherDashboardController.selectedClassId.isNotEmpty &&
                              teacherDashboardController
                                  .selectedClass.studentRequests.isNotEmpty
                          ? Icons.notifications_active
                          : Icons.notifications,
                    ),
                  ))
            ],
          ),
          SizedBox(height: screenHeight * 0.04),
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: LightTheme().primaryBlue,
                child: Obx(() {
                  String profileUrl = teacherDashboardController
                      .teacher.value.profilePictureLink;
                  return profileUrl.isNotEmpty
                      ? Image.network(profileUrl)
                      : Icon(Icons.person, color: Colors.white);
                }),
              ),
              Obx(() {
                return Text(
                  "Welcome,\n${teacherDashboardController.teacher.value.name}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                );
              }).marginOnly(left: screenWidth * 0.01),
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
            child: Obx(
              () => teacherDashboardController.currentPage.value,
            ),
          ),
        ],
      )
          .marginSymmetric(
            horizontal: screenWidth * 0.1,
          )
          .marginOnly(
            top: screenHeight * 0.04,
          ),
    );
  }
}
