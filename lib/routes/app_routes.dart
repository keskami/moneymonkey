// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Invest/Screens/market_screen.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/banknote.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/lessoncomplete.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/lessonpage.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/questionpage.dart';
import 'package:money_monkey/LoginPages/login.dart';

import '../Lesson Flow/Screens/home.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  // static const String proSeventeenScreen = '/pro_seventeen_screen';
  static const String lessonScreen = '/lesson_screen';
  static const String initialRoute = '/initialRoute';
  static const String bankPageRoute = "/bankPageRoute";
  static const String questionPageRoute = "/questionPageRoute";
  static const String lessonCompletePageRoute = "/lessonCompletePageRoute";
  static const String UserProfileScreenRoute = "/userProfile";
  static const String HomePageRoute = "/HomePage";
  static const String MarketScreenRoute = "/MarketScreen";
  static List<GetPage> routes = [
    //  GetPage(name: proSeventeenScreen, page: () => HomePage()),
    GetPage(name: lessonScreen, page: () => LessonPage()), // Add Lesson Screen
    GetPage(name: initialRoute, page: () => LoginScreen()),
    GetPage(
      name: bankPageRoute,
      page: () => BankNotePage(),
    ),
    GetPage(
      name: questionPageRoute,
      page: () => QuestionPage(),
    ),
    GetPage(
      name: lessonCompletePageRoute,
      page: () => LessonCompleteScreen(),
    ),
    GetPage(
      name: MarketScreenRoute,
      page: () => MarketScreen(),
    ),
    // GetPage(name: HomePageRoute, page: () => HomeScreen()),
  ];
}
