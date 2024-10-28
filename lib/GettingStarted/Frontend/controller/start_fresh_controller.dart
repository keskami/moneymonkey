import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/StartFreshPages/sf_page1.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/StartFreshPages/sf_page2.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/StartFreshPages/sf_page3.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/StartFreshPages/sf_page4.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/StartFreshPages/sf_page5.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/StartFreshPages/sf_page6.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/StartFreshPages/sf_page7.dart';

class StartFreshController extends GetxController {
  RxInt pageIndex = 0.obs;
  var pages = [
    const StartFreshPage1(),
    const StartFreshPage2(),
    const StartFreshPage3(),
    const StartFreshPage4(),
    StartFreshPage5(),
    const StartFreshPage6(),
    const StartFreshPage7(),
  ];
  RxInt learningGoal = 25.obs;
  RxInt startingFresh = 0.obs;
}
