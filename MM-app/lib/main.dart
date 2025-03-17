import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_monkey/BudgetSimulator/Pages/budgetSimulator.dart';
import 'package:money_monkey/BudgetSimulator/Pages/budgetSimulatorOnbording.dart';
import 'package:money_monkey/LoginPages/login.dart';
import 'package:money_monkey/TeacherDashboard/Pages/TeacherDashboard.dart';
import 'package:money_monkey/home.dart';
import 'package:money_monkey/themes/color_themes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // uploadDataToFirebase();
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
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 600, minHeight: 1000),
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
                    return BudgetSimulatorOnboarding();
                  } else {
                    return BudgetSimulatorOnboarding();
                  }
                } else {
                  return BudgetSimulatorOnboarding();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
