import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; // Add this for kIsWeb
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
      child: GetMaterialApp(
        darkTheme: AppThemes.darkTheme,
        theme: AppThemes.lightTheme,
        themeMode: ThemeMode.light,
        home: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              // Check if running on web and screen is desktop-sized
              final isWebDesktop = kIsWeb && constraints.maxWidth >= 1024;
              
              if (!isWebDesktop) {
                // Show message for non-desktop web or mobile platforms
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.desktop_windows, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Desktop Only',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'This app is only available on desktop web browsers in full screen.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                );
              }
              
              // Full screen content for desktop web
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 1920, // Maximum width for ultra-wide screens
                    minWidth: 1024, // Minimum desktop width
                  ),
                  child: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      // Show loading while checking auth
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      
                      // User is logged in
                      if (snapshot.hasData && snapshot.data != null) {
                        return HomePage();
                      }
                      
                      // User not logged in
                      return GettingStartedHome();
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}