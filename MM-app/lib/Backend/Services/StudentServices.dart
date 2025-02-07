import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';

class StudentService {
  StudentService({
    required this.student,
  });
  final Student student;
  List<String> progress = [];
  LocalAcademicService _localAcademicService = LocalAcademicService();

  void init() {
    progress = student.progress.split(".");
  }

  double getOverallProgress() {
    init();
    int totalComponents = _localAcademicService
        .getUnitTotalComponents("${progress[0]}.${progress[1]}");
    int completedComponents = 0;
    int currentUnit = int.parse(progress[1]);
    int currentLesson = int.parse(progress[2]);

    for (int i = 1; i <= currentUnit; i++) {
      Unit _u = _localAcademicService.getUnit("${progress[0]}.$i");
      if (i != currentUnit) {
        for (int j = 1; j < _u.totalLessons; j++) {
          Lesson _l = _localAcademicService.getLesson("${progress[0]}.$i.$j");
          completedComponents += _l.totalComponents;
        }
      } else {
        for (int j = 1; j < currentLesson; j++) {
          Lesson _l = _localAcademicService.getLesson("${progress[0]}.$i.$j");
          completedComponents += _l.totalComponents;
        }
      }
    }
    completedComponents += int.parse(progress[3]);
    return completedComponents / totalComponents;
  }

  double getLessonProgressForStudent(Student student) {
    List<String> studentProgress = student.progress.split(".");
    Lesson currentLesson = _localAcademicService.getLesson(
        "${studentProgress[0]}.${studentProgress[1]}.${studentProgress[2]}");
    return (int.parse(studentProgress[3]) / currentLesson.totalComponents);
  }

  double getLessonProgress() {
    init();
    return getLessonProgressForStudent(student);
  }

  StudentStatus getStatusFromProgress() {
    double progress = getLessonProgress();
    if (progress > 1) {
      return StudentStatus.Ahead;
    } else if (progress > 0.6) {
      return StudentStatus.On_Track;
    } else {
      return StudentStatus.Behind;
    }
  }

  Map<String, List<Student>> getCategorizedStudents(
      List<Student> classStudents) {
    Map<String, List<Student>> categorizedSt = {
      'topPeformers': [],
      'needSupport': [],
    };

    for (Student st in classStudents) {
      // Use the student-specific progress checker for each student
      double studentProgress = getLessonProgressForStudent(st);

      if (studentProgress > 0.9) {
        categorizedSt['topPeformers']?.add(st);
      } else if (studentProgress <= 0.6) {
        categorizedSt['needSupport']?.add(st);
      }
    }

    return categorizedSt;
  }
}
