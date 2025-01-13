import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page1.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page2.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page3.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page4.dart';


class PeerReflectioncontroller  extends GetxController{

   RxInt pageIndex = 0.obs;

   var pages = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
    
   ];



}