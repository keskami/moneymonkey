import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/routing_page.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'package:moneymonkey/firebase_options.dart';
import 'package:moneymonkey/pages/LoginPages/login.dart';

//import 'package:moneymonkey/pages/LoginPages/login.dart';
import 'routes/app_routes.dart';
import 'package:get/get.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "com.example.moneyMonkey",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Money Monkey',
      theme: ThemeData(
        fontFamily: "Baloo2"
      ),
      debugShowCheckedModeBanner: false,


      home: LoginScreen(),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.routes,
      scaffoldMessengerKey: globalMessengerKey
    );
  }
}
