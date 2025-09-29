import 'package:get/get.dart';

class LessonRefreshController extends GetxController {
  final RxBool shouldRefresh = false.obs;
  
  void triggerRefresh() {
    shouldRefresh.value = !shouldRefresh.value;
  }
}