import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/AcademicServices.dart';
import 'package:money_monkey/Backend/Services/DirectFirebaseService.dart';
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/PlaceHolderTab.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonManagement extends StatefulWidget {
  const LessonManagement({super.key});

  @override
  State<LessonManagement> createState() => _LessonManagementState();
}

class _LessonManagementState extends State<LessonManagement> {
  final DirectFirebaseService localAcademicService = DirectFirebaseService();
  final TeacherDashboardController teacherDashboardController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchURL(String driveLink) async {
    final Uri url = Uri.parse(driveLink);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $driveLink";
    }
  }

  String getActionForStatus(Status status) {
    switch (status) {
      case Status.Completed:
        return "Review";
      case Status.Active:
        return "Review";
      case Status.Inactive:
        return "Begin";
      default:
        return "View";
    }
  }

  Widget getProgressIndicator(Status status) {
    switch (status) {
      case Status.Completed:
        return Image.network(
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FCheck%20circle.png?alt=media&token=52726418-7a0a-4b6c-9207-1efa735199af",
        );
      case Status.Active:
        return CircularProgressIndicator(
          value: 0.5, // Use a fixed value or calculate based on actual progress
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

  // Helper function to handle component status updates
  Future<void> handleComponentStatusUpdate(Component component, int currentIndex) async {
    // Check if the component can be activated
    bool canActivate = false;
    if (currentIndex == 0) {
      // First component can always be activated
      canActivate = true;
    } else if (currentIndex > 0) {
      // Check if the previous component is active
      Component prevComponent = teacherDashboardController.childComponents.value[currentIndex - 1];
      if (prevComponent.componentStatus == Status.Active || 
          prevComponent.componentStatus == Status.Completed) {
        canActivate = true;
      }
    }

    try {
      // Handle different status transitions
      if (component.componentStatus == Status.Inactive && canActivate) {
        // Inactive -> Active (only if previous component is active or it's the first component)
        await localAcademicService.updateComponentStatus(
            component.componentId, Status.Active);

        // Update local state
        setState(() {
          Component updatedComponent = Component(
            componentId: component.componentId,
            title: component.title,
            type: component.type,
            componentStatus: Status.Active,
            questionData: component.questionData,
            performanceTrends: component.performanceTrends,
            discussionQuestions: component.discussionQuestions,
            progress: component.progress,
          );
          
          List<Component> updatedComponents = List.from(
              teacherDashboardController.childComponents.value);
          updatedComponents[currentIndex] = updatedComponent;
          teacherDashboardController.childComponents.value = updatedComponents;
        });

        Get.snackbar('Component Activated',
            'The component "${component.title}" has been activated.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } 
      else if (component.componentStatus == Status.Inactive && !canActivate) {
        // Cannot activate - previous component must be active first
        Get.snackbar('Cannot Activate',
            'Please activate the previous component first.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white);
      } 
      else if (component.componentStatus == Status.Active) {
        // Active -> Show review dialog
        Get.snackbar('Reviewing Component', 
            'Reviewing "${component.title}"',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white);
            
        // Option to complete the component after review
        Get.dialog(
          AlertDialog(
            title: Text('Review Component'),
            content: Text('Would you like to mark "${component.title}" as completed?'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close dialog
                },
                child: Text('Not Yet'),
              ),
              TextButton(
                onPressed: () async {
                  Get.back(); // Close dialog
                  
                  // Mark as completed
                  await localAcademicService.updateComponentStatus(
                      component.componentId, Status.Completed);

                  // Update local state
                  setState(() {
                    Component updatedComponent = Component(
                      componentId: component.componentId,
                      title: component.title,
                      type: component.type,
                      componentStatus: Status.Completed,
                      questionData: component.questionData,
                      performanceTrends: component.performanceTrends,
                      discussionQuestions: component.discussionQuestions,
                      progress: component.progress,
                    );
                    
                    List<Component> updatedComponents = List.from(
                        teacherDashboardController.childComponents.value);
                    updatedComponents[currentIndex] = updatedComponent;
                    teacherDashboardController.childComponents.value = updatedComponents;
                  });
                  
                  Get.snackbar('Component Completed',
                      'The component "${component.title}" has been marked as completed.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white);
                },
                child: Text('Mark as Completed'),
              ),
              TextButton(
                onPressed: () async {
                  Get.back(); // Close dialog
                  
                  // Reset to inactive
                  Map<String, Status> updates = {};
                  
                  // Set current and all following components to Inactive
                  for (int i = currentIndex; 
                      i < teacherDashboardController.childComponents.value.length; 
                      i++) {
                    Component componentToReset = teacherDashboardController.childComponents.value[i];
                    updates[componentToReset.componentId] = Status.Inactive;
                  }
                  
                  // Update all statuses in Firebase
                  await localAcademicService.updateMultipleComponentStatuses(updates);
                  
                  // Update local state
                  setState(() {
                    List<Component> updatedComponents = List.from(
                        teacherDashboardController.childComponents.value);
                        
                    // Update current and all following components to Inactive
                    for (int i = currentIndex; i < updatedComponents.length; i++) {
                      Component componentToReset = updatedComponents[i];
                      updatedComponents[i] = Component(
                        componentId: componentToReset.componentId,
                        title: componentToReset.title,
                        type: componentToReset.type,
                        componentStatus: Status.Inactive,
                        questionData: componentToReset.questionData,
                        performanceTrends: componentToReset.performanceTrends,
                        discussionQuestions: componentToReset.discussionQuestions,
                        progress: componentToReset.progress,
                      );
                    }
                    
                    teacherDashboardController.childComponents.value = updatedComponents;
                  });
                  
                  Get.snackbar('Components Reset',
                      'The component "${component.title}" and following components have been reset.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white);
                },
                child: Text('Reset Component'),
              ),
            ],
          ),
        );
      } 
      else if (component.componentStatus == Status.Completed) {
        // Completed -> Show review dialog with option to reset
        Get.dialog(
          AlertDialog(
            title: Text('Completed Component'),
            content: Text('This component "${component.title}" is already completed.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close dialog
                },
                child: Text('OK'),
              ),
              TextButton(
                onPressed: () async {
                  Get.back(); // Close dialog
                  
                  // Reset to inactive
                  Map<String, Status> updates = {};
                  
                  // Set current and all following components to Inactive
                  for (int i = currentIndex; 
                      i < teacherDashboardController.childComponents.value.length; 
                      i++) {
                    Component componentToReset = teacherDashboardController.childComponents.value[i];
                    updates[componentToReset.componentId] = Status.Inactive;
                  }
                  
                  // Update all statuses in Firebase
                  await localAcademicService.updateMultipleComponentStatuses(updates);
                  
                  // Update local state
                  setState(() {
                    List<Component> updatedComponents = List.from(
                        teacherDashboardController.childComponents.value);
                        
                    // Update current and all following components to Inactive
                    for (int i = currentIndex; i < updatedComponents.length; i++) {
                      Component componentToReset = updatedComponents[i];
                      updatedComponents[i] = Component(
                        componentId: componentToReset.componentId,
                        title: componentToReset.title,
                        type: componentToReset.type,
                        componentStatus: Status.Inactive,
                        questionData: componentToReset.questionData,
                        performanceTrends: componentToReset.performanceTrends,
                        discussionQuestions: componentToReset.discussionQuestions,
                        progress: componentToReset.progress,
                      );
                    }
                    
                    teacherDashboardController.childComponents.value = updatedComponents;
                  });
                  
                  Get.snackbar('Components Reset',
                      'The component "${component.title}" and following components have been reset.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orange,
                      colorText: Colors.white);
                },
                child: Text('Reset Component'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update component status: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    if (teacherDashboardController.selectedClassId.isEmpty)
      return TeacherDashoardPlaceHolderPage();
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
                        teacherDashboardController.presentLesson.title,
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
                        teacherDashboardController.presentLesson.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                ...teacherDashboardController.childComponents.value.map(
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
                            child:
                                getProgressIndicator(component.componentStatus),
                          ),
                        ),
                        //Component Name
                        Text(
                          component.title,
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
                          onTap: () async {
                            // Get the index of the current component
                            int currentIndex = teacherDashboardController
                                .childComponents.value
                                .indexOf(component);
                            
                            // Handle the component status update
                            await handleComponentStatusUpdate(component, currentIndex);
                          },
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
                                getActionForStatus(component.componentStatus),
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ).marginSymmetric(
                      vertical: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Lesson Resources Row
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
                      for (String iaLink in teacherDashboardController
                          .presentLesson.interactiveActivityLinks)
                        GestureDetector(
                          onTap: () {
                            if (iaLink.isNotEmpty) _launchURL(iaLink);
                          },
                          child: ColoredPaddedContainer(
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
                        ),
                      GestureDetector(
                        onTap: () {
                          if (teacherDashboardController
                              .presentLesson.teachersGuideLink.isNotEmpty)
                            _launchURL(teacherDashboardController
                                .presentLesson.teachersGuideLink);
                        },
                        child: ColoredPaddedContainer(
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
                      ),
                      GestureDetector(
                        onTap: () {
                          if (teacherDashboardController.presentLesson
                              .studentWorkshopTemplateLinks.isNotEmpty)
                            _launchURL(teacherDashboardController
                                .presentLesson.studentWorkshopTemplateLinks);
                        },
                        child: ColoredPaddedContainer(
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
          // Upcoming Lesson Row
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
  child: FutureBuilder<String>(
    future: localAcademicService.getNextLessonId(
      teacherDashboardController.presentLesson.lessonId
    ),
    builder: (context, nextLessonIdSnapshot) {
      if (nextLessonIdSnapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (nextLessonIdSnapshot.hasError) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Error loading next lesson: ${nextLessonIdSnapshot.error}'),
        );
      } else if (nextLessonIdSnapshot.hasData) {
        final nextLessonId = nextLessonIdSnapshot.data!;
        
        // Now that we have the next lesson ID, we can fetch the actual lesson
        return FutureBuilder<Lesson>(
          future: localAcademicService.getLesson(nextLessonId),
          builder: (context, lessonSnapshot) {
            if (lessonSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (lessonSnapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Error loading lesson details: ${lessonSnapshot.error}'),
              );
            } else if (lessonSnapshot.hasData) {
              final nextLesson = lessonSnapshot.data!;
              
              // Now we can safely access the lesson properties
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nextLesson.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      nextLesson.description,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('No lesson data available'),
              );
            }
          },
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('No next lesson found'),
        );
      }
    },
  ),
)],
            ),
          ),
        ],
      ),
    );
  }
}