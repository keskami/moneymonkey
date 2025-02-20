import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';

class LessonManagement extends StatefulWidget {
  const LessonManagement({
    super.key,
    required this.components,
    required this.currentLessonId,
  });
  final List<String> components;
  final String currentLessonId;

  @override
  State<LessonManagement> createState() => _LessonManagementState();
}

class _LessonManagementState extends State<LessonManagement> {
  final LocalAcademicService localAcademicService = LocalAcademicService();
  final TeacherDashboardController teacherDashboardController = Get.find();
  
  String message1 = "";
  String message2 = "";
  
  // Store component data
  Map<String, String> componentMap = {}; // ID to Name mapping
  List<String> componentIds = [];
  List<Map<String, dynamic>> lessonComponentsList = [];

  final String nextLessonTitle = "Smart Spending Decisions";
  final String nextLessonDescription =
      "Learning to make informed purchase decisions and understanding the value of money through practical exercises and real-world scenarios.";

  @override
  void initState() {
    super.initState();
    initializeData();
    // Listen to class changes
    ever(teacherDashboardController.classId, (_) {
      initializeData();
    });
  }

  void initializeData() {
    print("LessonManagement: initializeData called with components: ${widget.components}");
    
    if (widget.components.isNotEmpty) {
      // Clear previous data
      componentMap.clear();
      lessonComponentsList.clear();

      setState(() {
        // Get lesson information
        try {
          Lesson currentLesson = localAcademicService.getLesson(widget.currentLessonId);
          message1 = currentLesson.title;
          message2 = currentLesson.description;
        } catch (e) {
          print('Error getting lesson info: $e');
          message1 = "Financial Responsibility Over a Lifetime";
          message2 = "Making informed decisions about earning, saving, spending, and investing";
        }

        // Process components
        for (String componentId in widget.components) {
          try {
            Component component = localAcademicService.getComponent(componentId);
            String componentName = component.title;
            Status componentStatus = component.componentStatus;
            
            componentMap[componentId] = componentName;
            lessonComponentsList.add({
              "name": componentName,
              "status": componentStatus
            });
          } catch (e) {
            print('Error getting component data for $componentId: $e');
          }
        }
        
        // Keep track of component IDs
        componentIds = List<String>.from(widget.components);
      });
      
      print("LessonManagement: Components initialized: $componentIds");
      print("LessonManagement: Component list: $lessonComponentsList");
    } else {
      print("LessonManagement: Warning: Received empty components list");
      // Set defaults if no components
      setState(() {
        message1 = "Financial Responsibility Over a Lifetime";
        message2 = "Making informed decisions about earning, saving, spending, and investing";
        // Default components with Status enum values
        
      });
    }
  }

  @override
  void didUpdateWidget(LessonManagement oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Debug prints
    print("LessonManagement: didUpdateWidget called");
    print("LessonManagement: Old components: ${oldWidget.components}");
    print("LessonManagement: New components: ${widget.components}");
    
    // More thorough comparison to detect changes
    bool componentsChanged = false;
    if (oldWidget.components.length != widget.components.length) {
      componentsChanged = true;
    } else {
      // Check each element
      for (int i = 0; i < oldWidget.components.length; i++) {
        if (i >= widget.components.length || oldWidget.components[i] != widget.components[i]) {
          componentsChanged = true;
          break;
        }
      }
    }
    
    if (componentsChanged || oldWidget.currentLessonId != widget.currentLessonId) {
      print("LessonManagement: Change detected - reinitializing data");
      initializeData();
    }
  }

  @override
  void dispose() {
    // Clean up
    componentMap.clear();
    lessonComponentsList.clear();
    componentIds.clear();
    super.dispose();
  }

  // Helper method to get appropriate action based on component status
  String getActionForStatus(Status status) {
    switch (status) {
      case Status.Completed:
        return "Review";
      case Status.InProgress:
        return "Continue";
      case Status.Active:
        return "In Progress";
      case Status.Inactive:
        return "Preview";
      default:
        return "View";
    }
  }

  // Helper method to determine progress indicator appearance
  Widget getProgressIndicator(Status status) {
    switch (status) {
      case Status.Completed:
        return Image.network(
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FCheck%20circle.png?alt=media&token=52726418-7a0a-4b6c-9207-1efa735199af",
        );
      case Status.InProgress:
        return CircularProgressIndicator(
          value: 0.5, // Use a fixed value or calculate based on actual progress
          strokeWidth: 2,
        );
      case Status.Active:
        return CircularProgressIndicator(
          value: 0.1,
          strokeWidth: 2,
        );
      case Status.Inactive:
      default:
        return CircularProgressIndicator(
          value: 1,
          strokeWidth: 2,
          color: Colors.grey,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          //Lesson Actions Container
          ShadowedContainer(
            margin: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lesson Management",
                  style: TextStyles.containerTitle,
                ),
                ColoredPaddedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message1,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        message2,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                ...lessonComponentsList.map(
                  (component) => ColoredPaddedContainer(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.01,
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                    ),
                    color: Colors.grey.shade100,
                    child: Row(
                      children: [
                        //Completion Reflection Icon
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.transparent,
                          child: Container(
                            width: 20,
                            height: 20,
                            child: getProgressIndicator(component["status"]),
                          ),
                        ),
                        //Component Name
                        Text(
                          component["name"],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ).marginOnly(
                          left: 10,
                        ),
                        const Spacer(),
                        //Action Button
                        GestureDetector(
                          child: Container(
                            width: screenWidth * 0.1,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                getActionForStatus(component["status"]),
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).marginSymmetric(
                      vertical: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Rest of your code remains the same
          //Resources Row
          ShadowedContainer(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lesson Resources",
                  style: TextStyles.containerTitle,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ColoredPaddedContainer(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: screenHeight * 0.02,
                        ),
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                AppResources.interactiveAtivityGuide,
                              ),
                            ),
                            Text(
                              "Interactive Activity Guide",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ColoredPaddedContainer(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: screenHeight * 0.02,
                        ),
                        color: Color.fromARGB(255, 239, 246, 255),
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                AppResources.teachersGuide,
                              ),
                            ),
                            Text(
                              "Teacher's Guide",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ColoredPaddedContainer(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: screenHeight * 0.02,
                        ),
                        color: Color.fromARGB(255, 250, 245, 255),
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                AppResources.studentWorkshopTemplate,
                              ),
                            ),
                            Text(
                              "Student Worksheet Template",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ColoredPaddedContainer(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: screenHeight * 0.02,
                        ),
                        color: Color.fromARGB(255, 255, 236, 213),
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FTeacher%20Dashboard%2FLesson%20management%2FIcon4.png?alt=media&token=aabe9c04-773a-4e47-af73-25aedd6a3612",
                              ),
                            ),
                            Text(
                              "Teacher's Guide",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Upcoming Lesson Row
          ShadowedContainer(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upcoming Lesson",
                  style: TextStyles.containerTitle,
                ),
                ColoredPaddedContainer(
                  margin: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade100,
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nextLessonTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        nextLessonDescription,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}