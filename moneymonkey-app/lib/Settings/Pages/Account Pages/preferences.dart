import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Friends/comingSoonPage.dart';

import '../../../Backend/Services/settings_service.dart';
import '../../Widgets/custom_list_button_tile.dart';
import '../../Widgets/custom_list_switch_tile.dart';

class PreferencesSettingsPage extends StatefulWidget {
  const PreferencesSettingsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PreferencesSettingsPageState();
  }
}

class _PreferencesSettingsPageState extends State<PreferencesSettingsPage> {
  TextStyle _sectionTitleStyle() {
    return GoogleFonts.baloo2(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  bool audio = true;
  bool darkMode = true;
  bool soundEffect = true;
  String? userId;
  final SettingsService settingsService = SettingsService();

  Future<void> fetchUserId() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final settings = await settingsService.getPreferences(userId!);
      print(settings);
      setState(() {
        audio = settings['Audio'] ?? true;
        darkMode = settings['Dark Mode'] ?? true;
        soundEffect = settings['Sound Effects'] ?? true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserId(); // Call fetchUserId() during initialization
  }

  @override
  Widget build(BuildContext context) {
    print(userId); // This should now print the correct userId once it's loaded

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Preferences",
          style: GoogleFonts.inter(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lesson Preferences",
                  style: _sectionTitleStyle(),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 250, 250, 250),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: BorderSide.strokeAlignOutside,
                        offset: Offset(2, 2),
                        color: Colors.grey,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      CustomListButtonTile(
                        title: "Difficulty Level",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComingSoonPage(),
                            ),
                          );
                        },
                      ),
                      Divider(),
                      CustomListSwitchTile(
                        title: "Sound Effects",
                        val: soundEffect,
                        onTap: () async {
                          if (userId != null) {
                            await settingsService.updatePreferences(
                              userId: userId!,
                              audio: audio,
                              soundEffects: !soundEffect,
                              darkMode: darkMode,
                            );
                            setState(() {
                              soundEffect = !soundEffect;
                            });
                          }
                        },
                      ),
                      Divider(),
                      CustomListSwitchTile(
                        title: "Audio",
                        val: audio,
                        onTap: () async {
                          if (userId != null) {
                            await settingsService.updatePreferences(
                              userId: userId!,
                              audio: !audio,
                              soundEffects: soundEffect,
                              darkMode: darkMode,
                            );
                          }
                          setState(() {
                            audio = !audio;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Appearance",
                  style: _sectionTitleStyle(),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: const Color.fromARGB(255, 250, 250, 250),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        offset: Offset(2, 2),
                        color: Colors.grey,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      CustomListSwitchTile(
                        title: "Dark Mode",
                        val: darkMode,
                        onTap: () async {
                          if (userId != null) {
                            await settingsService.updatePreferences(
                              userId: userId!,
                              audio: audio,
                              soundEffects: soundEffect,
                              darkMode: !darkMode,
                            );
                          }
                          setState(() {
                            darkMode = !darkMode;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
