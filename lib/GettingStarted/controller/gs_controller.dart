import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Pages/gs_page1.dart';
import 'package:money_monkey/GettingStarted/Pages/gs_page2.dart';

class GettingStartedController extends GetxController {
  RxInt pageIndex = 0.obs;
  var pages = [
    const GettingStartedPage1(),
    const GettingStartedPage2(),
  ];
}
