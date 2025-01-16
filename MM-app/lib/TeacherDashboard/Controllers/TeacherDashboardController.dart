import 'package:get/get.dart';
import 'package:money_monkey/TeacherDashboard/Pages/Overview.dart';

class TeacherDashboardController extends GetxController {
  RxInt pageIndex = 0.obs;
  var pages = [
    DashboardOverview(),
  ];
}
