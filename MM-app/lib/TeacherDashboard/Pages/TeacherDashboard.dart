import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Services/CacheServices.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/CustomDropDownMenu.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/PlaceHolderTab.dart';
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
      teacherDashboardController.selectedClassId = teacherDashboardController
          .classes.entries
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
      await TeacherCacheBuilder().buildTeacherCache(sampleTeacher.id);
      // Initialize the controller with cached data
      await teacherDashboardController.initializeFromCache();
      
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
          Text(
            "Teacher Dashboard",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: screenHeight * 0.04),
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: LightTheme().primaryBlue,
                child: Obx(() {
                  String profileUrl = teacherDashboardController.teacher.value.profilePictureLink;
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
            child: 
             Obx(() => teacherDashboardController.currentPage.value,),
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