import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/Teacher.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';

class TeacherService {
  const TeacherService({
    required this.currentTeacher,
  });
  final Teacher currentTeacher;
  List<Student> getClassStudents(String classId) {
    return sampleStudents
        .where((st) => st.classRooms.contains(classId))
        .toList();
  }
}
