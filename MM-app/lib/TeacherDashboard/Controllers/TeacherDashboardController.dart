import 'package:get/get.dart';

class TeacherDashboardController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxString classId = "".obs;
  RxString lessonId = "".obs;

  String getProgress(String num) {
    double percentage = double.parse(num);
    if (percentage == 100) {
      return "Completed";
    } else if (percentage > 0 && percentage < 100) {
      return "In Progress";
    } else {
      return "Pending";
    }
  }

  String getStudentStatus(String progress) {
    double percentage = double.parse(progress);
    if (percentage >= 80) {
      return 'Ahead';
    } else if (percentage >= 60) {
      return 'On-Track';
    } else {
      return 'Behind';
    }
  }

  String getLessonAction(String num) {
    double percentage = double.parse(num);
    if (percentage == 100) {
      return "Review";
    } else if (percentage > 0 && percentage < 100) {
      return "In Progress";
    } else {
      return "Start";
    }
  }
}
