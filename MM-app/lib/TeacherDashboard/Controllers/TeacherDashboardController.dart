import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/Backend/Services/StudentServices.dart';
import 'package:money_monkey/Backend/Services/TeacherServices.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';

class TeacherDashboardController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxString classId = "".obs;
  RxString lessonId = "".obs;
  Rx<List<Student>> classRoomStudents = Rx<List<Student>>([]);
  Rx<List<Student>> topPerformers = Rx<List<Student>>([]);
  Rx<List<Student>> supportStudents = Rx<List<Student>>([]);
  String selectedClassId = "";
  Teacher loggedInTeacher = sampleTeacher;
  late Classroom selectedClass;
  late Lesson presentLesson;
  late Map<String, String> classes;
  Rx<List<Component>> childComponents = Rx<List<Component>>([]);
  late TeacherService teacherService;
  LocalAcademicService localAcademicService = LocalAcademicService();
  
  final String overviewMessage1 = "Financial Responsibility Over a Lifetime ";
  final String overviewMessage2 =
      "Making informed decisions about earning, saving, spending, and investing ";
      
  String lessonManagementMessage1 = "";
  String lessonManagementMessage2 = "";
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
  
  @override
  void onInit() {
    super.onInit();
    teacherService = TeacherService();
    getClasses();
  }

  String getClassId(String className) {
    return classes.entries.firstWhere((tr) => tr.value == className).key;
  }

  Future<void> refreshClassData() async {
    try {
      classRoomStudents.value = [];
      childComponents.value = [];
      topPerformers.value = [];
      supportStudents.value = [];
      
      // Get the updated classroom data
      selectedClass = localAcademicService.getClassRoom(selectedClassId);
      presentLesson = localAcademicService.getLesson(selectedClass.lessonId);
      lessonId.value = selectedClass.lessonId;

      // Create new lists to ensure reference changes are detected
      final List<Student> students =
          teacherService.getClassStudents(loggedInTeacher.id, selectedClassId);
          
      // Get component IDs
      final List<String> componentIds = List<String>.from(
          localAcademicService.getLessonComponents(selectedClass.lessonId));
          
      // Convert component IDs to Component objects
      List<Component> components = [];
      for (var id in componentIds) {
        Component component = localAcademicService.getComponent(id);
        components.add(component);
      }

      // Update state with new data
      classRoomStudents.value = students;
      childComponents.value = components;

      // Categorize students after state update
      if (classRoomStudents.value.isNotEmpty) {
        getCategorizedStudents();
      }

      // Debug output
      print('refreshClassData: Updated components: ${childComponents.value}');
    } catch (e) {
      print('Error refreshing class data: $e');
    }
  }

  Future<void> onClassPicked(String? className) async {
    if (className != null) {
      // Update the selected class ID
      selectedClassId = getClassId(className);
      classId.value = selectedClassId;

      // Refresh class data with proper state management
      await refreshClassData();
    }
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