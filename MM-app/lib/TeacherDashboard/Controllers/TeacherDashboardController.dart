import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/Backend/Services/StudentServices.dart';
import 'package:money_monkey/Backend/Services/TeacherServices.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';
import 'package:money_monkey/TeacherDashboard/Pages/ClassroomPreferences.dart';
import 'package:money_monkey/TeacherDashboard/Pages/LessonManagement.dart';
import 'package:money_monkey/TeacherDashboard/Pages/Overview.dart';
import 'package:money_monkey/TeacherDashboard/Pages/StudentPerformance.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/PlaceHolderTab.dart';

class TeacherDashboardController extends GetxController {
  Rx<Widget> currentPage = Rx<Widget>(TeacherDashoardPlaceHolderPage());
  List<Widget> pages = [
    DashboardOverview(),
    LessonManagement(),
    StudentPerformance(),
    ClassroomPreferences(),
  ];
  late TeacherService teacherService;
  LocalAcademicService localAcademicService = LocalAcademicService();
  String selectedClassId = "";
  late StudentService studentService;
  RxInt pageIndex = 0.obs;
  RxString lessonId = "".obs;
  Rx<List<Student>> classRoomStudents = Rx<List<Student>>([]);
  Rx<List<Student>> topPerformers = Rx<List<Student>>([]);
  Rx<List<Student>> supportStudents = Rx<List<Student>>([]);
  Rx<List<Component>> childComponents = Rx<List<Component>>([]);
  Rx<List<String>> componentNames = Rx<List<String>>([]);
  Teacher loggedInTeacher = sampleTeacher;
  late Classroom selectedClass;
  late Lesson presentLesson;
  late Component selectedComponent;
  late Student selectedStudent;
  late Map<String, String> classes;

  

 
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

  // Remove the static pages list
// List<Widget> pages = [...];

// Instead, add a method to get pages dynamically
  Widget getPage(int index) {
    switch (index) {
      case 0:
        return DashboardOverview();
      case 1:
        return LessonManagement();
      case 2:
        return StudentPerformance();
      case 3:
        return ClassroomPreferences();
      default:
        return TeacherDashoardPlaceHolderPage();
    }
  }

// Update how the current page is set
  void setCurrentPage(int index) {
    pageIndex.value = index;
    // Create a fresh instance of the page with the latest data
    currentPage.value = getPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    teacherService = TeacherService();
    if (loggedInTeacher.classRooms.isNotEmpty && selectedClassId.isNotEmpty) {
      refreshAllData();
    } else {
      getClasses();
    }
  }

  /// Refreshes and initializes all dashboard data
  /// This function can be triggered from other pages to ensure data is up-to-date

  Future<void> refreshAllData() async {
    try {
      // Reset all data collections
      classRoomStudents.value = [];
      childComponents.value = [];
      topPerformers.value = [];
      supportStudents.value = [];

      // Refresh class list
      getClasses();

      if (selectedClassId.isEmpty && loggedInTeacher.classRooms.isNotEmpty) {
        selectedClassId = loggedInTeacher.classRooms.first;
        selectedClassId = selectedClassId;
      }

      if (selectedClassId.isNotEmpty) {
        // Or, if you're recreating the pages with fresh data:
        // Get the updated classroom data
        selectedClass = localAcademicService.getClassRoom(selectedClassId);
        presentLesson = localAcademicService.getLesson(selectedClass.lessonId);
        lessonId.value = selectedClass.lessonId;

        // Create new lists to ensure reference changes are detected
        final List<Student> students = teacherService.getClassStudents(
            loggedInTeacher.id, selectedClassId);
        selectedStudent = students[0];
        studentService = StudentService(student: selectedStudent);

        // Get component IDs
        final List<String> componentIds = List<String>.from(
            localAcademicService.getLessonComponents(selectedClass.lessonId));

        // Convert component IDs to Component objects
        List<Component> components = [];
        List<String> compNames = [];
        for (var id in componentIds) {
          Component component = localAcademicService.getComponent(id);
          if (componentIds.indexOf(id) == 0) {
            selectedComponent = component;
          }
          components.add(component);
          compNames.add(component.title);
        }

        // Update state with new data
        classRoomStudents.value = students;
        childComponents.value = components;
        componentNames.value = compNames;
        print("*************Comp Names: ${componentNames.value}");

        // Categorize students after state update
        if (classRoomStudents.value.isNotEmpty) {
          getCategorizedStudents();
        }
      }
      if (classRoomStudents.value.isNotEmpty &&
          childComponents.value.isNotEmpty) setCurrentPage(pageIndex.value);

      // Debug output
      print('refreshAllData: Data refresh complete');
    } catch (e) {
      print('Error refreshing dashboard data: $e');
    }
  }

  String getClassId(String className) {
    return classes.entries.firstWhere((tr) => tr.value == className).key;
  }

  void getCategorizedStudents() {
    if (classRoomStudents.value.isEmpty) return;

    final categorizedSt = StudentService(student: classRoomStudents.value[0])
        .getCategorizedStudents(classRoomStudents.value);

    topPerformers.value = categorizedSt['topPerformers'] ?? [];
    supportStudents.value = categorizedSt['needSupport'] ?? [];
  }

  void getClasses() {
    classes = Map.fromEntries(
      sampleClassrooms.entries
          .where((entry) => loggedInTeacher.classRooms.contains(entry.key))
          .map((entry) => MapEntry(entry.key, entry.value.name)),
    );
  }
}
