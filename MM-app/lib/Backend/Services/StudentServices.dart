import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';

class StudentService {
  StudentService({required this.student});
  final Student student;
  List<String> progress = [];
  LocalAcademicService _localAcademicService = LocalAcademicService();
  void initializeProgress() {
    progress = student.progress.split(".");
  }

  double getOverallProgress() {
    int totalComponents = _localAcademicService
        .getUnitTotalComponents("${progress[0]}.${progress[1]}");
    int completedComponents = 0;
    int currentUnit = int.parse(progress[1]);
    int currentLesson = int.parse(progress[2]);
    //Iterate through all previous lessons to get their total components.
    for (int i = 1; i <= currentUnit; i++) {
      Unit _u = _localAcademicService.getUnit("${progress[0]}.$i");
      if (i != currentUnit) {
        for (int j = 1; j < _u.totalLessons; j++) {
          Lesson _l = _localAcademicService.getLesson("${progress[0]}.$i.$j");
          completedComponents += _l.totalComponents;
        }
      } else {
        //Goign through all lessons in current unit but before current lesson.
        for (int j = 1; j < currentLesson; j++) {
          Lesson _l = _localAcademicService.getLesson("${progress[0]}.$i.$j");
          completedComponents += _l.totalComponents;
        }
      }
    }
    //Add current lesson's completed
    completedComponents += int.parse(progress[3]);
    return completedComponents / totalComponents;
  }

  double getLessonProgress() {
    //Getting current Lesson
    Lesson _currentLesson = _localAcademicService
        .getLesson("${progress[0]}.${progress[1]}.${progress[2]}");
    //Dividing the current progress from total number of Components in that particular lesson
    return int.parse(progress[3]) / _currentLesson.totalComponents;
  }
}
