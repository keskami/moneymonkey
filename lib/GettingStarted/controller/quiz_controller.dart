import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Pages/QuizPages/q_1.dart';

class QuizController extends GetxController {
  RxInt pageIndex = 0.obs;
  var Pages = [
    Question1(),
  ];
  RxInt result = 0.obs;
}
