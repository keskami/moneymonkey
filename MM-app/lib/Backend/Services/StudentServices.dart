import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/AcademicServices.dart';

import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/DirectFirebaseService.dart';

class StudentService {
  StudentService({
    required this.student,
  });
  
  final Student student;
  List<String> progress = [];
  DirectFirebaseService _firebaseService = DirectFirebaseService();

  void init() {
    progress = student.progress.split(".");
  }

  Future<double> getOverallProgress() async {
    init();
    
    try {
      // Get the unit to calculate total components
      Unit unit = await _firebaseService.getUnit("${progress[0]}.${progress[1]}");
      
      int totalComponents = 0;
      int completedComponents = 0;
      int currentUnit = int.parse(progress[1]);
      int currentLesson = int.parse(progress[2]);

      // Calculate total components for the unit
      for (String lessonId in unit.lessonIds) {
        Lesson lesson = await _firebaseService.getLesson(lessonId);
        totalComponents += lesson.totalComponents;
      }

      // Calculate completed components
      for (int i = 1; i <= currentUnit; i++) {
        Unit u = await _firebaseService.getUnit("${progress[0]}.$i");
        
        if (i != currentUnit) {
          // All lessons in previous units are completed
          for (String lessonId in u.lessonIds) {
            Lesson l = await _firebaseService.getLesson(lessonId);
            completedComponents += l.totalComponents;
          }
        } else {
          // For current unit, count lessons up to current one
          for (int j = 1; j < currentLesson; j++) {
            try {
              Lesson l = await _firebaseService.getLesson("${progress[0]}.$i.$j");
              completedComponents += l.totalComponents;
            } catch (e) {
              print('Error getting lesson ${progress[0]}.$i.$j: $e');
              // Continue with next lesson
            }
          }
        }
      }
      
      // Add components from current lesson
      completedComponents += int.parse(progress[3]);
      
      return totalComponents > 0 ? completedComponents / totalComponents : 0.0;
    } catch (e) {
      print('Error calculating overall progress: $e');
      return 0.0;
    }
  }

  Future<double> getLessonProgressForStudent(Student student) async {
    try {
      List<String> studentProgress = student.progress.split(".");
      
      // Get the current lesson for this student
      Lesson currentLesson = await _firebaseService.getLesson(
          "${studentProgress[0]}.${studentProgress[1]}.${studentProgress[2]}");
      
      // Calculate the progress as a ratio of completed components
      return currentLesson.totalComponents > 0 
          ? (int.parse(studentProgress[3]) / currentLesson.totalComponents)
          : 0.0;
    } catch (e) {
      print('Error calculating lesson progress for student: $e');
      return 0.0;
    }
  }

  Future<double> getLessonProgress() async {
    init();
    return getLessonProgressForStudent(student);
  }

  Future<StudentStatus> getStatusFromProgress() async {
    double progress = await getLessonProgress();
    
    if (progress > 1) {
      return StudentStatus.Ahead;
    } else if (progress > 0.6) {
      return StudentStatus.OnTrack;
    } else {
      return StudentStatus.Behind;
    }
  }

  Future<Map<String, List<Student>>> getCategorizedStudents(List<Student> classStudents) async {
    Map<String, List<Student>> categorizedSt = {
      'topPeformers': [],
      'needSupport': [],
    };

    for (Student st in classStudents) {
      // Use the student-specific progress checker for each student
      double studentProgress = await getLessonProgressForStudent(st);

      if (studentProgress > 0.9) {
        categorizedSt['topPeformers']?.add(st);
      } else if (studentProgress <= 0.6) {
        categorizedSt['needSupport']?.add(st);
      }
    }

    return categorizedSt;
  }
}
//Local Student Service:

// class StudentService {
//   StudentService({
//     required this.student,
//   });
//   final Student student;
//   List<String> progress = [];
//   LocalAcademicService _localAcademicService = LocalAcademicService();

//   void init() {
//     progress = student.progress.split(".");
//   }

//   double getOverallProgress() {
//     init();
//     int totalComponents = _localAcademicService
//         .getUnitTotalComponents("${progress[0]}.${progress[1]}");
//     int completedComponents = 0;
//     int currentUnit = int.parse(progress[1]);
//     int currentLesson = int.parse(progress[2]);

//     for (int i = 1; i <= currentUnit; i++) {
//       Unit _u = _localAcademicService.getUnit("${progress[0]}.$i");
//       if (i != currentUnit) {
//         for (int j = 1; j < _u.totalLessons; j++) {
//           Lesson _l = _localAcademicService.getLesson("${progress[0]}.$i.$j");
//           completedComponents += _l.totalComponents;
//         }
//       } else {
//         for (int j = 1; j < currentLesson; j++) {
//           Lesson _l = _localAcademicService.getLesson("${progress[0]}.$i.$j");
//           completedComponents += _l.totalComponents;
//         }
//       }
//     }
//     completedComponents += int.parse(progress[3]);
//     return completedComponents / totalComponents;
//   }

//   double getLessonProgressForStudent(Student student) {
//     List<String> studentProgress = student.progress.split(".");
//     Lesson currentLesson = _localAcademicService.getLesson(
//         "${studentProgress[0]}.${studentProgress[1]}.${studentProgress[2]}");
//     return (int.parse(studentProgress[3]) / currentLesson.totalComponents);
//   }

//   double getLessonProgress() {
//     init();
//     return getLessonProgressForStudent(student);
//   }

//   StudentStatus getStatusFromProgress() {
//     double progress = getLessonProgress();
//     if (progress > 1) {
//       return StudentStatus.Ahead;
//     } else if (progress > 0.6) {
//       return StudentStatus.On_Track;
//     } else {
//       return StudentStatus.Behind;
//     }
//   }

//   Map<String, List<Student>> getCategorizedStudents(
//       List<Student> classStudents) {
//     Map<String, List<Student>> categorizedSt = {
//       'topPeformers': [],
//       'needSupport': [],
//     };

//     for (Student st in classStudents) {
//       // Use the student-specific progress checker for each student
//       double studentProgress = getLessonProgressForStudent(st);

//       if (studentProgress > 0.9) {
//         categorizedSt['topPeformers']?.add(st);
//       } else if (studentProgress <= 0.6) {
//         categorizedSt['needSupport']?.add(st);
//       }
//     }

//     return categorizedSt;
//   }
// }
