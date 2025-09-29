import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_monkey/GettingStarted/Pages/gs_home.dart';
import 'package:money_monkey/LessonPages/Controllers/Lesson_Refresh.dart';
import 'package:money_monkey/LoginPages/login.dart';
import 'package:money_monkey/home.dart';
import 'package:money_monkey/themes/color_themes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LessonRefreshController());

  // Initialize storage
  await GetStorage.init();
  
  // Initialize AI services
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
      child: GetMaterialApp(
        darkTheme: AppThemes.darkTheme,
        theme: AppThemes.lightTheme,
        themeMode: ThemeMode.light,
        home: Scaffold(
          body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // Show loading while checking auth
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              
              // User is logged in
              if (snapshot.hasData && snapshot.data != null) {
                return HomePage();  // ✅ Go to home when logged in
              }
              
              // User not logged in
              return GettingStartedHome();  // ✅ Go to getting started/login
            },
          ),
        ),
      ),
    ),
  );
}
}
