import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_monkey/BudgetSimulator/landingPage.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page1.dart';
import 'package:money_monkey/LessonPages/Pages/LessonOne.dart';
import 'package:money_monkey/LessonPages/Pages/PeerReflection.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page1.dart';
import 'package:money_monkey/LoginPages/login.dart';
import 'package:money_monkey/PortfolioPages/portfolio_screen.dart';
import 'package:money_monkey/themes/color_themes.dart';

import 'GettingStarted/Pages/sf_home.dart';
import 'firebase_options.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: LightTheme().primaryGreen,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return SafeArea(
      child: MaterialApp(
        darkTheme: AppThemes.darkTheme,
        theme: AppThemes.lightTheme,
        themeMode: ThemeMode.light,
        home: Scaffold(
          body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                User? user = FirebaseAuth.instance.currentUser;
                String userId = user?.uid ?? '';
                if (userId.isEmpty) {
                  return PeerReflection();
                } else {
                  return PeerReflection();
                }
              } else {
                return PeerReflection();
              }
            },
          ),
        ),
      ),
    );
  }
}
