import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_monkey/routing_page.dart';
import 'package:money_monkey/themes/color_themes.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'com.example.moneyMonkey',
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
        home: const MainPage(),
      ),
    );
  }
}
