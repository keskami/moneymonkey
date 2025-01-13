import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:money_monkey/LessonPages/Toolkit/page5.dart';
import 'package:money_monkey/LessonPages/Toolkit/page6.dart';
import 'package:money_monkey/LessonPages/Toolkit/page7.dart';
import 'package:money_monkey/LessonPages/Toolkit/page8.dart';

class Toolkitcontroller extends GetxController {
  RxInt pageIndex = 0.obs;

  var pages = [
    Page5(),
    Page6(),
    Page7(),
    Page8(),
  ];
}
