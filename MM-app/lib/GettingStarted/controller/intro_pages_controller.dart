import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Pages/IntroPages/gs_page1.dart';
import 'package:money_monkey/GettingStarted/Pages/IntroPages/gs_page2.dart';
import 'package:money_monkey/GettingStarted/Pages/IntroPages/gs_page3.dart';
import 'package:money_monkey/GettingStarted/Pages/IntroPages/gs_page4.dart';

class GettingStartedController extends GetxController {
  RxInt pageIndex = 0.obs;
  var pages = [
    const GettingStartedPage1(),
    const GettingStartedPage2(),
    const GettingStartedPage3(),
    const GettingStartedPage4(),
  ];
  RxInt age = 0.obs;
  RxInt knowledgeLevel = 6.obs;
}
