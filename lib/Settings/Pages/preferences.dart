import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Settings/Widgets/custom_list_tile.dart';

class PreferencesSettingsPage extends StatelessWidget {
  const PreferencesSettingsPage({super.key});

  // Define common text style to avoid repetition
  TextStyle _sectionTitleStyle() {
    return GoogleFonts.baloo2(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

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
            padding: const EdgeInsets.all(8.0),
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
                      CustomListTile(
                        title: "Difficulty Level",
                        isToggle: false,
                        onTap: () {},
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Sound Effects",
                        isToggle: true,
                        onTap: () {},
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Audio",
                        isToggle: true,
                        onTap: () {},
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
                      CustomListTile(
                        title: "Dark Mode",
                        isToggle: true,
                        onTap: () {},
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
