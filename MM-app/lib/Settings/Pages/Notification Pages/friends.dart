import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Models/Settings.dart';

import '../../../Backend/Services/settings_service.dart';
import '../../Widgets/custom_row_tile_button.dart';

class FriendsSettingsPage extends StatefulWidget {
  const FriendsSettingsPage({super.key});

  @override
  State<FriendsSettingsPage> createState() => _FriendsSettingsPageState();
}

class _FriendsSettingsPageState extends State<FriendsSettingsPage> {
  final SettingsService settingsService = SettingsService();
  String? userId;

  bool friendsActivityEmail = false;
  bool friendsActivityPhone = false;
  bool newFollowerPhone = false;
  bool newFollowerEmail = false;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    print("User ID: $userId");
    if (userId != null) {
      final settings = await settingsService.getFriendsNotifications(userId!);

      setState(() {
        friendsActivityEmail = settings.friendActivityEmail;
        friendsActivityPhone = settings.friendActivityPhone;
        newFollowerEmail = settings.newFollowerEmail;
        newFollowerPhone = settings.newFollowerPhone;
      });

      print("Is new Follower Phone Enabled: $newFollowerPhone");
      print("Is newFollower Email Enabled: $newFollowerEmail");
      print("Is friends Activity phone Enabled: $friendsActivityPhone");
      print("Is friends Activity email Enabled: $friendsActivityEmail");
    }
  }

  Future<void> updateFriendsSettings() async {
    await settingsService.updateFriendsNotifications(
        userId!,
        FriendsNotifications(
          friendActivityEmail: friendsActivityEmail,
          friendActivityPhone: friendsActivityPhone,
          newFollowerEmail: newFollowerEmail,
          newFollowerPhone: newFollowerPhone,
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
                        title: "New Followers",
                        rowChildren: [
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                newFollowerPhone = !newFollowerPhone;
                              });
                              await updateFriendsSettings();
                            },
                            icon: Icon(
                              Platform.isAndroid
                                  ? Icons.phone_android
                                  : Icons.phone_iphone,
                              color:
                                  newFollowerPhone ? Colors.black : Colors.grey,
                              size: screenHeight * 0.05,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  newFollowerEmail = !newFollowerEmail;
                                });
                                await updateFriendsSettings();
                              },
                              icon: Icon(
                                Icons.mail_outlined,
                                color: newFollowerEmail
                                    ? Colors.black
                                    : Colors.grey,
                                size: screenHeight * 0.05,
                              )),
                        ],
                        onTap: () {},
                      ),
                      Divider(),
                      CustomRowTileButton(
                        title: "Friends Activity",
                        rowChildren: [
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                friendsActivityPhone = !friendsActivityPhone;
                              });
                              await updateFriendsSettings();
                            },
                            icon: Icon(
                              Platform.isAndroid
                                  ? Icons.phone_android
                                  : Icons.phone_iphone,
                              color: friendsActivityPhone
                                  ? Colors.black
                                  : Colors.grey,
                              size: screenHeight * 0.05,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                setState(() {
                                  friendsActivityEmail = !friendsActivityEmail;
                                });
                                await updateFriendsSettings();
                              },
                              icon: Icon(
                                Icons.mail_outlined,
                                color: friendsActivityEmail
                                    ? Colors.black
                                    : Colors.grey,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
