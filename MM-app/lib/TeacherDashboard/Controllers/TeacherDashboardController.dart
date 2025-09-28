import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/Backend/Services/DirectFirebaseService.dart';
import 'package:money_monkey/Backend/Services/StudentServices.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';
import 'package:money_monkey/TeacherDashboard/Pages/ClassroomPreferences.dart';
import 'package:money_monkey/TeacherDashboard/Pages/LessonManagement.dart';
import 'package:money_monkey/TeacherDashboard/Pages/Overview.dart';
import 'package:money_monkey/TeacherDashboard/Pages/StudentPerformance.dart';
import 'package:money_monkey/TeacherDashboard/Pages/TeacherCalendar.dart'; // Import the new calendar page
import 'package:money_monkey/TeacherDashboard/Widgets/PlaceHolderTab.dart';

class TeacherDashboardController extends GetxController {
  // Direct Firebase service for real-time data access
  final DirectFirebaseService _firebaseService = DirectFirebaseService();

  List<Widget> pages = [
    DashboardOverview(),
    LessonManagement(),
    StudentPerformance(),
    TeacherCalendar(), // Add the new calendar tab
    ClassroomPreferences(),
  ];

  // Observable properties
  Rx<Widget> currentPage = Rx<Widget>(TeacherCalendar());
  RxInt pageIndex = 0.obs;
  RxString lessonId = "".obs;
  Rx<List<Student>> classRoomStudents = Rx<List<Student>>([]);
  Rx<List<Student>> topPerformers = Rx<List<Student>>([]);
  Rx<List<Student>> supportStudents = Rx<List<Student>>([]);
  Rx<List<Component>> childComponents = Rx<List<Component>>([]);
  Rx<List<String>> componentNames = Rx<List<String>>([]);
  Rx<Teacher> teacher = Rx<Teacher>(sampleTeacher);

  // Current selection state
  RxString selectedClassId = "".obs;
  late Classroom selectedClass;
  late Lesson presentLesson;
  late Component selectedComponent;
  late Student selectedStudent;
  Map<String, String> classes = {};
  late StudentService studentService;

  // Loading state
  RxBool isLoading = true.obs;

  // Component status helper methods
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

  @override
  void onInit() {
    super.onInit();
    // Initialize controller with Firebase data
    initialize();
  }

  Future<void> refreshAllData() async {
    try {
      isLoading.value = true;

      // Set currentPage to placeholder during loading
      currentPage.value = TeacherDashoardPlaceHolderPage();

      // Reset all data collections
      classRoomStudents.value = [];
      childComponents.value = [];
      topPerformers.value = [];
      supportStudents.value = [];

      if (selectedClassId.isEmpty && teacher.value.classRooms.isNotEmpty) {
        selectedClassId.value = teacher.value.classRooms.first;
      }

      if (selectedClassId.isNotEmpty) {
        // Get classroom from Firebase
        selectedClass =
            await _firebaseService.getClassroom(selectedClassId.value);

        // Get lesson from Firebase
        presentLesson =
            await _firebaseService.getLesson(selectedClass.lessonId);
        lessonId.value = selectedClass.lessonId;

        // Get students from Firebase
        List<Student> students = await _firebaseService
            .getStudentsInClassroom(selectedClassId.value);

        if (students.isNotEmpty) {
          selectedStudent = students[0];
          studentService = StudentService(student: selectedStudent);
        }

        // Get components from Firebase
        List<Component> components = await _firebaseService
            .getComponentsForLesson(selectedClass.lessonId);

        // Prepare component names
        List<String> compNames = components.map((comp) => comp.title).toList();

        if (components.isNotEmpty) {
          selectedComponent = components.first;
        }

        // Update state with new data
        classRoomStudents.value = students;
        childComponents.value = components;
        componentNames.value = compNames;

        // Categorize students after state update
        if (classRoomStudents.value.isNotEmpty) {
          await getCategorizedStudents();
        }
      }

      // Only update the current page if we have all required data
      if (classRoomStudents.value.isNotEmpty &&
          childComponents.value.isNotEmpty) {
        setCurrentPage(pageIndex.value);
      } else {
        // Keep the placeholder if we don't have complete data
        currentPage.value = TeacherDashoardPlaceHolderPage();
      }

      print('refreshAllData: Firebase data refresh complete');
    } catch (e) {
      print('Error refreshing dashboard data: $e');
      Get.snackbar('Error', 'Failed to refresh dashboard data: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);

      // Set to placeholder on error
      currentPage.value = TeacherDashoardPlaceHolderPage();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> initialize() async {
    try {
      isLoading.value = true;

      // Set currentPage to placeholder during loading
      currentPage.value = TeacherDashoardPlaceHolderPage();

      // Use a teacher ID that should be obtained from authentication
      const String teacherId = "temporaryTeacherId2025";

      // Fetch teacher data from Firebase
      teacher.value = await _firebaseService.getTeacher(teacherId);

      // Get available classes
      await getClasses();

      // Set first classroom as selected if nothing is already selected
      if (selectedClassId.isEmpty && teacher.value.classRooms.isNotEmpty) {
        selectedClassId.value = teacher.value.classRooms.first;
        await refreshAllData();
      }

      print('TeacherDashboardController initialized with Firebase data');
    } catch (e) {
      print('Error initializing TeacherDashboardController: $e');
      Get.snackbar('Initialization Error', 'Failed to load dashboard data: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);

      // Keep placeholder on error
      currentPage.value = TeacherDashoardPlaceHolderPage();
    } finally {
      isLoading.value = false;
    }
  }

  void setCurrentPage(int index) {
    pageIndex.value = index;

    // Only create a new page instance if we have data
    if (classRoomStudents.value.isNotEmpty &&
        childComponents.value.isNotEmpty) {
      currentPage.value = getPage(index);
    } else {
      // Keep the placeholder if no data is available
      currentPage.value = TeacherDashoardPlaceHolderPage();
    }
  }

  // Get available classrooms for the teacher from Firebase
  Future<void> getClasses() async {
    try {
      isLoading.value = true;

      // Get classrooms from Firebase
      final Map<String, Classroom> classrooms =
          await _firebaseService.getClassroomsForTeacher(teacher.value.id);

      // Create a map of classroom IDs to names
      classes = Map.fromEntries(classrooms.entries
          .map((entry) => MapEntry(entry.key, entry.value.name)));

      print(
          'Loaded ${classes.length} classrooms for teacher ${teacher.value.id}');
    } catch (e) {
      print('Error getting classes: $e');
      Get.snackbar('Error', 'Failed to load classrooms: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // Categorize students based on performance
  Future<void> getCategorizedStudents() async {
    if (classRoomStudents.value.isEmpty) return;

    try {
      isLoading.value = true;

      // Get categorized students using the student service
      final categorizedSt =
          await StudentService(student: classRoomStudents.value[0])
              .getCategorizedStudents(classRoomStudents.value);

      // Update observable lists with results
      topPerformers.value = categorizedSt['topPerformers'] ?? [];
      supportStudents.value = categorizedSt['needSupport'] ?? [];
    } catch (e) {
      print('Error categorizing students: $e');
      Get.snackbar('Error', 'Failed to categorize students: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // Component status update methods
  Future<void> activateComponent(
      Component component, int componentIndex) async {
    try {
      // Check if component can be activated
      bool canActivate = false;
      if (componentIndex == 0) {
        // First component can always be activated
        canActivate = true;
      } else if (componentIndex > 0) {
        // Check if previous component is active or completed
        Component prevComponent = childComponents.value[componentIndex - 1];
        if (prevComponent.componentStatus == Status.Active ||
            prevComponent.componentStatus == Status.Completed) {
          canActivate = true;
        }
      }

      if (!canActivate) {
        Get.snackbar(
            'Cannot Activate', 'Please activate the previous component first.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white);
        return;
      }

      // Show loading indicator
      isLoading.value = true;

      // Update component status in Firebase
      await _firebaseService.updateComponentStatus(
          component.componentId, Status.Active);

      // Update local component list
      List<Component> updatedComponents = List.from(childComponents.value);
      updatedComponents[componentIndex] =
          _createUpdatedComponent(component, Status.Active);
      childComponents.value = updatedComponents;

      Get.snackbar('Component Activated',
          'The component "${component.title}" has been activated.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      print('Error activating component: $e');
      Get.snackbar('Error', 'Failed to activate component: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> completeComponent(
      Component component, int componentIndex) async {
    try {
      // Show loading indicator
      isLoading.value = true;

      // Update component status in Firebase
      await _firebaseService.updateComponentStatus(
          component.componentId, Status.Completed);

      // Update local component list
      List<Component> updatedComponents = List.from(childComponents.value);
      updatedComponents[componentIndex] =
          _createUpdatedComponent(component, Status.Completed);
      childComponents.value = updatedComponents;

      Get.snackbar('Component Completed',
          'The component "${component.title}" has been marked as completed.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } catch (e) {
      print('Error completing component: $e');
      Get.snackbar('Error', 'Failed to complete component: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetComponents(int startIndex) async {
    try {
      if (startIndex >= childComponents.value.length) {
        return;
      }

      // Show loading indicator
      isLoading.value = true;

      // Create updates map
      Map<String, Status> updates = {};
      for (int i = startIndex; i < childComponents.value.length; i++) {
        Component component = childComponents.value[i];
        updates[component.componentId] = Status.Inactive;
      }

      // Update component statuses in Firebase
      await _firebaseService.updateMultipleComponentStatuses(updates);

      // Update local component list
      List<Component> updatedComponents = List.from(childComponents.value);
      for (int i = startIndex; i < updatedComponents.length; i++) {
        Component component = updatedComponents[i];
        updatedComponents[i] =
            _createUpdatedComponent(component, Status.Inactive);
      }
      childComponents.value = updatedComponents;

      Get.snackbar('Components Reset',
          'The component and following components have been reset.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white);
    } catch (e) {
      print('Error resetting components: $e');
      Get.snackbar('Error', 'Failed to reset components: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method to create updated component
  Component _createUpdatedComponent(Component original, Status newStatus) {
    return Component(
      componentId: original.componentId,
      title: original.title,
      type: original.type,
      componentStatus: newStatus,
      questionData: original.questionData,
      performanceTrends: original.performanceTrends,
      discussionQuestions: original.discussionQuestions,
      progress: original.progress,
    );
  }

  // Handle component status change
  Future<void> handleComponentStatusChange(
      Component component, int componentIndex) async {
    if (component.componentStatus == Status.Inactive) {
      await activateComponent(component, componentIndex);
    } else if (component.componentStatus == Status.Active) {
      // Show dialog with options
      Get.dialog(
        AlertDialog(
          title: Text('Review Component'),
          content: Text('What would you like to do with "${component.title}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close dialog
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () async {
                Get.back(); // Close dialog
                await completeComponent(component, componentIndex);
              },
              child: Text('Mark as Completed'),
            ),
            TextButton(
              onPressed: () async {
                Get.back(); // Close dialog
                await resetComponents(componentIndex);
              },
              child: Text('Reset Component'),
            ),
          ],
        ),
      );
    } else if (component.componentStatus == Status.Completed) {
      // Show dialog for completed component
      Get.dialog(
        AlertDialog(
          title: Text('Completed Component'),
          content:
              Text('This component "${component.title}" is already completed.'),
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
                await resetComponents(componentIndex);
              },
              child: Text('Reset Component'),
            ),
          ],
        ),
      );
    }
  }

  // Other dashboard data
  Map<String, List<Student>> categorizedStudents = {};
  final Map<String, String> actions = {
    "What about those \$150 sneakers?": "Wait for next paycheck",
    "Planning for Emergencies": "Set aside \$150",
    "What about those \$120 sneakers?": "Wait for next paycheck",
  };
  final List<String> quickActionsSuggestions = [
    "Launch Jordan's Journey Scenario",
    "Start Emergency Fun Challenge",
    "Begin Spending Decisions Quiz",
  ];

  // Get page by index
  Widget getPage(int index) {
    if (index < 0 || index >= pages.length) {
      return TeacherDashoardPlaceHolderPage();
    }
    return pages[index];
  }

  String getClassId(String className) {
    try {
      return classes.entries.firstWhere((tr) => tr.value == className).key;
    } catch (e) {
      print('Error getting class ID for $className: $e');
      return '';
    }
  }

  // Helper methods for StudentService operations with error handling
  Future<StudentStatus> getStudentStatusSafely(Student student) async {
    try {
      final service = StudentService(student: student);
      return await service.getStatusFromProgress();
    } catch (e) {
      print('Error getting student status: $e');
      return StudentStatus.OnTrack; // Default fallback
    }
  }

  Future<double> getStudentLessonProgressSafely(Student student) async {
    try {
      final service = StudentService(student: student);
      return await service.getLessonProgress();
    } catch (e) {
      print('Error getting student lesson progress: $e');
      return 0.0; // Default fallback
    }
  }

  Future<double> getStudentOverallProgressSafely(Student student) async {
    try {
      final service = StudentService(student: student);
      return await service.getOverallProgress();
    } catch (e) {
      print('Error getting student overall progress: $e');
      return 0.0; // Default fallback
    }
  }
} 