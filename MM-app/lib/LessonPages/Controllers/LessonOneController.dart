import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page1.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page2.dart';

class LessonOneController extends GetxController {
  RxInt pageIndex = 1.obs;
  var pages = [
    L1Page1(),
    L1Page2(),
  ];
}
