import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Pages/IntroPages/gs_page1.dart';
import 'package:money_monkey/GettingStarted/Pages/IntroPages/gs_page2.dart';
import 'package:money_monkey/GettingStarted/Pages/IntroPages/gs_page3.dart';
import 'package:money_monkey/GettingStarted/Pages/IntroPages/gs_page4.dart';
import 'package:money_monkey/GettingStarted/Pages/IntroPages/gs_page5.dart';
import 'package:money_monkey/GettingStarted/Pages/IntroPages/gs_page6.dart';

class GettingStartedController extends GetxController {
  RxInt pageIndex = 0.obs;
  var pages = [
    const GettingStartedPage1(),
    const GettingStartedPage2(),
    const GettingStartedPage3(),
    const GettingStartedPage4(),
    GettingStartedPage5(),
    const GettingStartedPage6(),
  ];
  RxInt age = 0.obs;
}
