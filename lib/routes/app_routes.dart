// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymonkey/pages/LoginPages/login.dart';
import 'package:moneymonkey/screens/banknote.dart';
import 'package:moneymonkey/screens/lessoncomplete.dart';
import 'package:moneymonkey/screens/marketscreen.dart';
import 'package:moneymonkey/screens/questionpage.dart';

import '../screens/home.dart';
import '../screens/lessonpage.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {

  static const String lessonScreen = '/lesson_screen';
  static const String initialRoute = '/initialRoute';
  static const String bankPageRoute= "/bankPageRoute";
  static const String questionPageRoute= "/questionPageRoute";
  static const String lessonCompletePageRoute= "/lessonCompletePageRoute";
    static const String UserProfileScreenRoute= "/userProfile";
  static const String HomePageRoute= "/HomePage";
  static const String MarketScreenRoute="/MarketScreen";
  static List<GetPage> routes = [
  
    GetPage(name: lessonScreen, page: () => LessonPage()), 
    GetPage(name: initialRoute, page: () => LoginScreen()),
    GetPage(name: bankPageRoute, page: ()=> BankNotePage(),
    ),
     GetPage(name: questionPageRoute, page: ()=> QuestionPage(),
    ),
     GetPage(name: lessonCompletePageRoute, page: ()=>  LessonCompleteScreen(),
    ),
    GetPage(name: MarketScreenRoute, page: ()=>  MarketScreen(),
    ),
    GetPage(name: HomePageRoute, page: ()=>  HomePage()),
    
  ];
}
