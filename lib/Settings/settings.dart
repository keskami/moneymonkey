import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Settings/Widgets/custom_list_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          "Settings",
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
                  "Account",
                  style: _sectionTitleStyle(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 250, 250, 250),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          spreadRadius: BorderSide.strokeAlignOutside,
                          offset: Offset(2, 2),
                          color: Colors.grey,
                        )
                      ]),
                  child: const Column(
                    children: [
                      CustomListTile(
                        title: "Preferences",
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Profile",
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Notifications",
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Privacy Settings",
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Subscription",
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Social Accounts",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Support",
                  style: _sectionTitleStyle(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 250, 250, 250),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          offset: Offset(2, 2),
                          color: Colors.grey,
                        )
                      ]),
                  child: const Column(
                    children: [
                      CustomListTile(
                        title: "Help Center",
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Feedback",
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
