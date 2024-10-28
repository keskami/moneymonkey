import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Settings/Pages/feedback.dart';
import 'package:money_monkey/Settings/Pages/help_center.dart';
import 'package:money_monkey/Settings/Pages/notification.dart';
import 'package:money_monkey/Settings/Pages/preferences.dart';
import 'package:money_monkey/Settings/Pages/privacy_settings.dart';
import 'package:money_monkey/Settings/Pages/profile.dart';
import 'package:money_monkey/Settings/Pages/social_accounts.dart';
import 'package:money_monkey/Settings/Pages/subscription.dart';
import 'package:money_monkey/Settings/Widgets/custom_list_tile.dart';
import 'package:money_monkey/themes/color_themes.dart';

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
                        title: "Preferences",
                        isToggle: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PreferencesSettingsPage(),
                            ),
                          );
                        },
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Profile",
                        isToggle: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileSettingsPage(),
                            ),
                          );
                        },
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Notifications",
                        isToggle: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationSettingsPage(),
                            ),
                          );
                        },
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Privacy Settings",
                        isToggle: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrivacySettingsPage(),
                            ),
                          );
                        },
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Subscription",
                        isToggle: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubscriptionSettingsPage(),
                            ),
                          );
                        },
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Social Accounts",
                        isToggle: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SocialAccountsSettingsPage(),
                            ),
                          );
                        },
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
                      borderRadius: BorderRadius.circular(30),
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
                        title: "Help Center",
                        isToggle: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpCenter(),
                            ),
                          );
                        },
                      ),
                      Divider(),
                      CustomListTile(
                        title: "Feedback",
                        isToggle: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FeedbackPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
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
                  child: Center(
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        color: LightTheme().primaryBlue,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: LightTheme().primaryBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Acknowledgements",
                  style: TextStyle(
                    color: LightTheme().primaryBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Terms and Conditions",
                  style: TextStyle(
                    color: LightTheme().primaryBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
