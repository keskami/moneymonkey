import 'package:get/get.dart';

class ProgressController extends GetxController {
  var progress = 0.2.obs;  // Initial progress value
  
  void incrementProgress() {
    if (progress.value < 1) {
      progress.value += 0.2; // Increase progress by 20%
    }
  }
}
