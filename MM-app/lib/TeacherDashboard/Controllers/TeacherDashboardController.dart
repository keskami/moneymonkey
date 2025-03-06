import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/Backend/Services/CacheServices.dart';
import 'package:money_monkey/Backend/Services/StudentServices.dart';
import 'package:money_monkey/Backend/Services/TeacherServices.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/TeacherDashboard/Pages/ClassroomPreferences.dart';
import 'package:money_monkey/TeacherDashboard/Pages/LessonManagement.dart';
import 'package:money_monkey/TeacherDashboard/Pages/Overview.dart';
import 'package:money_monkey/TeacherDashboard/Pages/StudentPerformance.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/PlaceHolderTab.dart';

class TeacherDashboardController extends GetxController {
  // Cache management
  final TeacherDashboardCache _cache = TeacherDashboardCache();
  List<Widget> pages = [
    DashboardOverview(),
    LessonManagement(),
    StudentPerformance(),
    ClassroomPreferences(),
  ];
  // Observable properties
  Rx<Widget> currentPage = Rx<Widget>(TeacherDashoardPlaceHolderPage());
  RxInt pageIndex = 0.obs;
  RxString lessonId = "".obs;
  Rx<List<Student>> classRoomStudents = Rx<List<Student>>([]);
  Rx<List<Student>> topPerformers = Rx<List<Student>>([]);
  Rx<List<Student>> supportStudents = Rx<List<Student>>([]);
  Rx<List<Component>> childComponents = Rx<List<Component>>([]);
  Rx<List<String>> componentNames = Rx<List<String>>([]);
  Rx<Teacher> teacher = Rx<Teacher>(Teacher(name: "", id: "", classRooms: [], profilePictureLink: ""));
  
  // Services
  late TeacherService teacherService;
  LocalAcademicService localAcademicService = LocalAcademicService();
  late StudentService studentService;
  
  // Current selection state
  String selectedClassId = "";
  late Classroom selectedClass;
  late Lesson presentLesson;
  late Component selectedComponent;
  late Student selectedStudent;
  Map<String, String> classes = {};

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

  // Initialize from cache
  Future<void> initializeFromCache() async {
    try {
      // Initialize the cache
      await _cache.initialize();
      
      // Set the teacher data
      teacher.value = _cache.teacher;
      
      // Get available classes
      getClasses();
      
      // If we have classes, select the first one by default
      if (teacher.value.classRooms.isNotEmpty && selectedClassId.isEmpty) {
        selectedClassId = teacher.value.classRooms.first;
      }
      
      // Refresh all data with the cache
      if (selectedClassId.isNotEmpty) {
        await refreshAllData();
      }
      
      print('TeacherDashboardController initialized with cache data');
    } catch (e) {
      print('Error initializing TeacherDashboardController from cache: $e');
      // Fallback to services if cache fails
      teacherService = TeacherService();
      if (teacher.value.classRooms.isNotEmpty && selectedClassId.isNotEmpty) {
        refreshAllData();
      } else {
        getClasses();
      }
    }
  }

  // Get page by index
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

  // Set current page
  void setCurrentPage(int index) {
    pageIndex.value = index;
    // Create a fresh instance of the page with the latest data
    currentPage.value = getPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    teacherService = TeacherService();
    // Note: We don't call refreshAllData here anymore
    // It will be called after cache initialization
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

      if (selectedClassId.isEmpty && teacher.value.classRooms.isNotEmpty) {
        selectedClassId = teacher.value.classRooms.first;
      }

      if (selectedClassId.isNotEmpty) {
        // Try to get data from cache first
        try {
          // Get classroom from cache
          selectedClass = _cache.getClassroom(selectedClassId) ?? 
                         localAcademicService.getClassRoom(selectedClassId);
          
          // Get lesson from cache
          presentLesson = _cache.getLesson(selectedClass.lessonId) ??
                         localAcademicService.getLesson(selectedClass.lessonId);
          
          lessonId.value = selectedClass.lessonId;

          // Get students from cache
          List<Student> students = _cache.getStudentsInClassroom(selectedClassId);
          if (students.isEmpty) {
            // Fallback to service
            students = teacherService.getClassStudents(teacher.value.id, selectedClassId);
          }
          
          if (students.isNotEmpty) {
            selectedStudent = students[0];
            studentService = StudentService(student: selectedStudent);
          }

          // Get components
          List<Component> components = _cache.getComponentsForLesson(selectedClass.lessonId);
          if (components.isEmpty) {
            // Fallback to service
            final List<String> componentIds = localAcademicService.getLessonComponents(selectedClass.lessonId);
            for (var id in componentIds) {
              Component component = localAcademicService.getComponent(id);
              components.add(component);
            }
          }

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
            getCategorizedStudents();
          }
        } catch (e) {
          print('Error getting data from cache, falling back to services: $e');
          
          // Fallback to services
          selectedClass = localAcademicService.getClassRoom(selectedClassId);
          presentLesson = localAcademicService.getLesson(selectedClass.lessonId);
          lessonId.value = selectedClass.lessonId;

          final List<Student> students = teacherService.getClassStudents(
              teacher.value.id, selectedClassId);
          selectedStudent = students[0];
          studentService = StudentService(student: selectedStudent);

          final List<String> componentIds = List<String>.from(
              localAcademicService.getLessonComponents(selectedClass.lessonId));

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

          classRoomStudents.value = students;
          childComponents.value = components;
          componentNames.value = compNames;

          if (classRoomStudents.value.isNotEmpty) {
            getCategorizedStudents();
          }
        }
      }
      
      if (classRoomStudents.value.isNotEmpty &&
          childComponents.value.isNotEmpty) setCurrentPage(pageIndex.value);

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
    // First try to get from cache
    try {
      final cachedClassrooms = _cache.getTeacherClassrooms();
      if (cachedClassrooms.isNotEmpty) {
        classes = Map.fromEntries(
          cachedClassrooms.map((classroom) => MapEntry(classroom.classId, classroom.name)),
        );
        return;
      }
    } catch (e) {
      print('Error getting classes from cache: $e');
    }
    
    // Fallback to direct access
    classes = Map.fromEntries(
      _cache.classrooms.entries
          .where((entry) => teacher.value.classRooms.contains(entry.key))
          .map((entry) => MapEntry(entry.key, entry.value.name)),
    );
  }
}

// Import the cache management