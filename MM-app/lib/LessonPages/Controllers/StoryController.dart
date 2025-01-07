import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Pages_Story/IntroPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/ProblemPage.dart';

class StoryController extends GetxController {
  RxInt pageIndex = 1.obs;
  var pages = <Widget>[
    IntroPage(),
    ProblemPage(),
  ];
}
