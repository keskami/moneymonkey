import 'package:get/get.dart';
import 'package:money_monkey/TeacherDashboard/Pages/LessonManagement.dart';
import 'package:money_monkey/TeacherDashboard/Pages/Overview.dart';

class TeacherDashboardController extends GetxController {
  RxInt pageIndex = 1.obs;
  var pages = [
    DashboardOverview(),
    LessonManagement(),
  ];
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
