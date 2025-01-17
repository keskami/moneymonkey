import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Pages_Story/ImpactPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/IntroPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/ProblemPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/SolutionPage.dart';
import 'package:money_monkey/LessonPages/Pages_Story/newlanding.dart';

class StoryController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxBool toSolution = false.obs;
  RxBool toImpact = false.obs;
  var pages = <Widget>[
    NewStoryLanding(),
    IntroPage(),
    ProblemPage(),
    SolutionPage(),
    ImpactPage(),
  ];
}
