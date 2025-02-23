import 'package:get/get.dart';

/// Base controller that all lesson controllers should extend.
/// Provides a common [isLoading] flag and can be expanded with shared logic.
abstract class BaseLessonController extends GetxController {
  /// Indicates whether the controller is still loading data.
  RxBool isLoading = true.obs;

  // You can add shared properties or helper methods here.
}
