import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Loading%20Widgets/LoadingOverlay.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
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
  // Initialize controller with Get.put to ensure it's properly registered
  late TeacherDashboardController controller;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize the controller properly
    controller = Get.put(TeacherDashboardController());
    
    // Wait for the next frame to ensure widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initialize controller properly - let it fetch data from Firebase
      controller.initialize();
    });
  }

  void onClassPicked(String? className) {
    if (className != null && controller.classes.isNotEmpty) {
      try {
        // Find the class ID for the selected class name
        final classId = controller.classes.entries
            .firstWhere((entry) => entry.value == className)
            .key;
            
        controller.selectedClassId.value = classId;
        controller.refreshAllData();
      } catch (e) {
        print('Error selecting class: $e');
        Get.snackbar(
          'Error',
          'Could not select class: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Obx(() => LoadingOverlay(
        isLoading: controller.isLoading.value,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Teacher Dashboard",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Obx(() {
                    // Safely check if selected class exists and has student requests
                    bool hasSelectedClass = controller.selectedClassId.isNotEmpty;
                    bool hasRequests = false;
                    
                    try {
                      if (hasSelectedClass) {
                        hasRequests = controller.selectedClass.studentRequests.isNotEmpty;
                      }
                    } catch (e) {
                      print('Error checking student requests: $e');
                    }
                        
                    return IconButton(
                      onPressed: () {
                        if (!hasSelectedClass) {
                          Get.snackbar(
                            'No Class Selected',
                            'Please select a class first',
                            snackPosition: SnackPosition.BOTTOM
                          );
                          return;
                        }
                        
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
                                if (!hasSelectedClass || !hasRequests)
                                  Text(
                                    "No pending requests",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  )
                                else
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: screenHeight * 0.4,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: controller.selectedClass.studentRequests.entries
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
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 8),
                                if (hasSelectedClass && hasRequests)
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
                        hasRequests
                            ? Icons.notifications_active
                            : Icons.notifications,
                      ),
                    );
                  })
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: LightTheme().primaryBlue,
                    child: Obx(() {
                      // Safely access profile picture
                      String profileUrl = '';
                      try {
                        profileUrl = controller.teacher.value.profilePictureLink;
                      } catch (e) {
                        print('Error accessing profile picture: $e');
                      }
                      
                      return profileUrl.isNotEmpty
                          ? Image.network(profileUrl)
                          : Icon(Icons.person, color: Colors.white);
                    }),
                  ),
                  Obx(() {
                    // Safely access teacher name
                    String teacherName = '';
                    try {
                      teacherName = controller.teacher.value.name;
                    } catch (e) {
                      print('Error accessing teacher name: $e');
                    }
                    
                    return Text(
                      "Welcome,\n${teacherName}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    );
                  }).marginOnly(left: screenWidth * 0.01),
                  const Spacer(),
                  // Class dropdown
                  Obx(() => controller.classes.isEmpty
                    ? Text("Loading classes...", style: TextStyle(fontSize: 16, color: Colors.grey))
                    : CustomDropDownContainer(
                        width: screenWidth * 0.3,
                        items: controller.classes.values.toList(),
                        initialSelection: controller.selectedClassId.isEmpty 
                          ? null 
                          : controller.classes[controller.selectedClassId.value],
                        onChanged: onClassPicked,
                      ),
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
                  // Safely render current page or fallback to placeholder
                  Widget pageToShow;
                  try {
                    pageToShow = controller.currentPage.value;
                  } catch (e) {
                    print('Error rendering current page: $e');
                    pageToShow = TeacherDashoardPlaceHolderPage();
                  }
                  return pageToShow;
                }),
              ),
            ],
          )
              .marginSymmetric(
                horizontal: screenWidth * 0.1,
              )
              .marginOnly(
                top: screenHeight * 0.04,
              ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh data from Firebase
          controller.refreshAllData();
        },
        tooltip: 'Refresh Data',
        child: Icon(Icons.refresh),
      ),
    );
  }
}