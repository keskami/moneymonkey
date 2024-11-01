import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Settings/Widgets/custom_list_button_tile.dart';
import 'package:money_monkey/Settings/Widgets/custom_list_switch_tile.dart';

class PreferencesSettingsPage extends StatefulWidget {
  const PreferencesSettingsPage({super.key});

  @override
  State<PreferencesSettingsPage> createState() =>
      _PreferencesSettingsPageState();
}

class _PreferencesSettingsPageState extends State<PreferencesSettingsPage> {
  // Define common text style to avoid repetition
  TextStyle _sectionTitleStyle() {
    return GoogleFonts.baloo2(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  bool audio = true;
  bool darkMode = true;
  bool soundEffect = true;

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(
                  height: 20,
                ),
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
                      ]),
                  child: Column(
                    children: [
                      CustomListButtonTile(
                        title: "Difficulty Level",
                        onTap: () {},
                      ),
                      Divider(),
                      CustomListSwitchTile(
                        title: "Sound Effects",
                        val: soundEffect,
                        onTap: () {
                          setState(() {
                            soundEffect = !soundEffect;
                          });
                        },
                      ),
                      Divider(),
                      CustomListSwitchTile(
                        title: "Audio",
                        val: audio,
                        onTap: () {
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
                const SizedBox(
                  height: 20,
                ),
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
                      ]),
                  child: Column(
                    children: [
                      CustomListSwitchTile(
                        title: "Dark Mode",
                        val: darkMode,
                        onTap: () {
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
