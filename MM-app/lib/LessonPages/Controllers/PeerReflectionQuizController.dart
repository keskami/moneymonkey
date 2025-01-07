import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page1.dart';
import 'package:money_monkey/LessonPages/PeerReflection/QuizPages/page2.dart';


class PeerReflectionQuizcontroller  extends GetxController{

   RxInt pageIndex = 0.obs;

   var pages = [
    PeerReflectionQuizPage1(),
    PeerReflectionQuizPage2()
   ];



}