import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/themes/color_themes.dart';

import '../../../Backend/Models/settings.dart';
import '../../../Backend/Services/settings_service.dart';
import '../../Widgets/custom_row_tile_button.dart';

class AnnouncementsSettingsPage extends StatefulWidget {
  const AnnouncementsSettingsPage({super.key});

  @override
  State<AnnouncementsSettingsPage> createState() =>
      _AnnouncementsSettingsPageState();
}

class _AnnouncementsSettingsPageState extends State<AnnouncementsSettingsPage> {
  final SettingsService settingsService = SettingsService();
  String? userId;

  bool marketingNotificationPhone = false;
  bool marketingNotificationEmail = false;
  bool eduTipsPhone = false;
  bool eduTipsEmail = false;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    print("User ID: $userId");
    if (userId != null) {
      final settings =
          await settingsService.getAnnouncementsNotifications(userId!);

      setState(() {
        marketingNotificationPhone = settings.marketingNotificationsPhone;
        marketingNotificationEmail = settings.marketingNotificationsEmail;
        eduTipsPhone = settings.educationalTipsPhone;
        eduTipsEmail = settings.educationalTipsEmail;
      });

      print("marketing noti phone: $marketingNotificationPhone");
      print("Marketing noti mail: $marketingNotificationEmail");
      print("Edu Phone$eduTipsPhone");
      print("edu Email  $eduTipsEmail");
    }
  }

  Future<void> updateAnnouncementSettings() async {
    await settingsService.updateAnnouncementsNotifications(
        userId!,
        AnnouncementsNotifications(
          educationalTipsEmail: eduTipsEmail,
          educationalTipsPhone: eduTipsPhone,
          marketingNotificationsEmail: marketingNotificationEmail,
          marketingNotificationsPhone: marketingNotificationPhone,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Reminders",
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
                const SizedBox(
                  height: 40,
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
                      CustomRowTileButton(
                        title: "Marketing Notifications",
                        rowChildren: [
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                marketingNotificationPhone =
                                    !marketingNotificationPhone;
                              });
                              await updateAnnouncementSettings();
                            },
                            icon: Icon(
                              Platform.isAndroid
                                  ? Icons.phone_android
                                  : Icons.phone_iphone,
                              color: marketingNotificationPhone
                                  ? Colors.black
                                  : Colors.grey,
                              size: screenHeight * 0.05,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  marketingNotificationEmail =
                                      !marketingNotificationEmail;
                                });
                                await updateAnnouncementSettings();
                              },
                              icon: Icon(
                                Icons.mail_outlined,
                                color: marketingNotificationEmail
                                    ? Colors.black
                                    : Colors.grey,
                                size: screenHeight * 0.05,
                              )),
                        ],
                        onTap: () {},
                      ),
                      Divider(),
                      CustomRowTileButton(
                        title: "Educational tips +\nProduct Updates",
                        rowChildren: [
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                eduTipsPhone = !eduTipsPhone;
                              });
                              await updateAnnouncementSettings();
                            },
                            icon: Icon(
                              Platform.isAndroid
                                  ? Icons.phone_android
                                  : Icons.phone_iphone,
                              color: eduTipsPhone ? Colors.black : Colors.grey,
                              size: screenHeight * 0.05,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  eduTipsEmail = !eduTipsEmail;
                                });
                                await updateAnnouncementSettings();
                              },
                              icon: Icon(
                                Icons.mail_outlined,
                                color:
                                    eduTipsEmail ? Colors.black : Colors.grey,
                                size: screenHeight * 0.05,
                              )),
                        ],
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Restore Default",
                      style: GoogleFonts.baloo2(
                        color: LightTheme().primaryBlue,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
