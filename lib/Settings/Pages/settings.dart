import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Profile/profile_page.dart';
import 'package:money_monkey/Settings/Pages/Account Pages/privacy_settings.dart';
import 'package:money_monkey/Settings/Pages/Account Pages/subscription.dart';
import 'package:money_monkey/Settings/Pages/Account%20Pages/preferences.dart';
import 'package:money_monkey/Settings/Pages/Account%20Pages/profile.dart';
import 'package:money_monkey/Settings/Pages/Account%20Pages/social_accounts.dart';
import 'package:money_monkey/Settings/Pages/Notification%20Pages/notification.dart';
import 'package:money_monkey/Settings/Pages/Support%20Pages/help_center.dart';
import 'package:money_monkey/Settings/Widgets/custom_list_button_tile.dart';
import 'package:money_monkey/routing_page.dart';
import 'package:money_monkey/themes/color_themes.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  TextStyle _sectionTitleStyle() {
    return GoogleFonts.baloo2(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    void _launchEmail() async {
      final Uri emailLaunchUri = Uri.parse(
          "mailto:moneymonkeyinqueries@gmail.com?subject=Feedback&body=Your feedback is very precious to us. We go bananas for them!");

      try {
        bool canLaunchResult = await canLaunchUrl(emailLaunchUri);
        print('Can launch: $canLaunchResult');

        if (canLaunchResult) {
          await launchUrl(emailLaunchUri);
        } else {
          print('No app found to handle mailto scheme');
        }
      } catch (e) {
        print('Error launching email: $e');
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: LightTheme().primaryBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          backgroundColor: LightTheme().primaryBackgroundColor,
          centerTitle: true,
          title: Text(
            "Settings",
            style: GoogleFonts.inter(
              color: Colors.black,
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
                        CustomListButtonTile(
                          title: "Preferences",
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
                        CustomListButtonTile(
                          title: "Profile",
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
                        CustomListButtonTile(
                          title: "Notifications",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NotificationSettingsPage(),
                              ),
                            );
                          },
                        ),
                        Divider(),
                        CustomListButtonTile(
                          title: "Privacy Settings",
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
                        CustomListButtonTile(
                          title: "Subscription",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SubscriptionSettingsPage(),
                              ),
                            );
                          },
                        ),
                        Divider(),
                        CustomListButtonTile(
                          title: "Social Accounts",
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
                        CustomListButtonTile(
                          title: "Help Center",
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
                        CustomListButtonTile(
                          title: "Feedback",
                          onTap: () async {
                            _launchEmail();
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
                    padding: const EdgeInsets.symmetric(vertical: 5),
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
                      child: TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => MainPage()),
                            (Route<dynamic> route) => false,
                          );
                        },
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
      ),
    );
  }
}
