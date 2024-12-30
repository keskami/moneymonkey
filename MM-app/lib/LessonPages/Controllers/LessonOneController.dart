import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page1.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page2.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page3.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page4.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page5.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page6.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page7.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page8.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Reflection.dart';

class LessonOneController extends GetxController {
  RxInt pageIndex = 0.obs;
  var pages = [
    L1Page1(),
    L1Page2(),
    L1Page3(),
    L1Page4(),
    L1Page5(),
    L1Page6(),
    L1Page7(),
    L1Page8(),
    L1Reflection(),
  ];
}
