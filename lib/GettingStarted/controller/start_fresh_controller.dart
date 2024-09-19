import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:money_monkey/GettingStarted/Pages/StartFreshPages/sf_page1.dart';
import 'package:money_monkey/GettingStarted/Pages/StartFreshPages/sf_page2.dart';
import 'package:money_monkey/GettingStarted/Pages/StartFreshPages/sf_page3.dart';
import 'package:money_monkey/GettingStarted/Pages/StartFreshPages/sf_page4.dart';

class StartFreshController extends GetxController {
  RxInt pageIndex = 0.obs;
  var pages = [
    const StartFreshPage1(),
    const StartFreshPage2(),
    StartFreshPage3(),
    const StartFreshPage4(),
  ];
}
