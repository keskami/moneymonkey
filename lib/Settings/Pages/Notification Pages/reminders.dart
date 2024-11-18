import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/themes/color_themes.dart';

import '../../../Backend/Models/settings.dart';
import '../../../Backend/Services/settings_service.dart';
import '../../Widgets/custom_row_tile_button.dart';

class RemindersSettingsPage extends StatefulWidget {
  const RemindersSettingsPage({super.key});

  @override
  State<RemindersSettingsPage> createState() => _RemindersSettingsPageState();
}

class _RemindersSettingsPageState extends State<RemindersSettingsPage> {
  final SettingsService settingsService = SettingsService();
  String? userId;

  TimeOfDay? practiceTime;
  bool isPracticePhoneEnabled = false;
  bool isPracticeEmailEnabled = false;
  bool isReminderEnabled = false;
  bool isWeeklyProgressEnabled = false;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    print("User ID: $userId");
    if (userId != null) {
      final settings = await settingsService.getRemindersNotifications(userId!);

      setState(() {
        practiceTime = _parseTimeOfDay(settings.reminderTime);
        isPracticeEmailEnabled = settings.practiceEmail;
        isPracticePhoneEnabled = settings.practicePhone;
        isWeeklyProgressEnabled = settings.weeklyProgress;
      });

      print("Practice Time: ${practiceTime?.format(context)}");
      print("Is Practice Phone Enabled: $isPracticePhoneEnabled");
      print("Is Practice Email Enabled: $isPracticeEmailEnabled");
      print("Is Weekly Progress Enabled: $isWeeklyProgressEnabled");
    }
  }

  TimeOfDay _parseTimeOfDay(String time) {
    try {
      final format = time.split(' ');
      if (format.length != 2) {
        throw FormatException("Invalid time format");
      }

      final isPm = format[1] == 'PM';
      final hourMinute = format[0].split(':');
      if (hourMinute.length != 2) {
        throw FormatException("Invalid time format");
      }
      int hour = int.parse(hourMinute[0]);
      final int minute = int.parse(hourMinute[1]);

      if (isPm && hour != 12) hour += 12;
      if (!isPm && hour == 12) hour = 0;

      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      // Handle the error gracefully
      print("Error parsing time: $e");
      return TimeOfDay(hour: 8, minute: 0);
    }
  }

  Future<void> _selectPracticeTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: practiceTime ?? TimeOfDay(hour: 8, minute: 0),
    );
    if (picked != null && picked != practiceTime) {
      setState(() {
        practiceTime = picked;
      });
      await settingsService.updateRemindersNotifications(
        userId: userId!,
        settings: RemindersNotifications(
          reminderTime: "${picked.format(context)}",
          practiceEmail: isPracticeEmailEnabled,
          practicePhone: isPracticePhoneEnabled,
          weeklyProgress: isWeeklyProgressEnabled,
        ),
      );
    }
  }

  Future<void> updateReminderSettings() async {
    await settingsService.updateRemindersNotifications(
      userId: userId!,
      settings: RemindersNotifications(
        reminderTime: "${practiceTime!.format(context)}",
        practiceEmail: isPracticeEmailEnabled,
        practicePhone: isPracticePhoneEnabled,
        weeklyProgress: isWeeklyProgressEnabled,
      ),
    );
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
                        title: "Reminder Time",
                        rowChildren: [
                          TextButton(
                            onPressed: _selectPracticeTime,
                            child: Text(
                              practiceTime!.format(context),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        onTap: () {},
                      ),
                      Divider(),
                      CustomRowTileButton(
                        title: "Practice Message",
                        rowChildren: [
                          IconButton(
                            onPressed: () async {
                              setState(() => isPracticePhoneEnabled =
                                  !isPracticePhoneEnabled);
                              await updateReminderSettings();
                            },
                            icon: Icon(
                              Platform.isAndroid
                                  ? Icons.phone_android
                                  : Icons.phone_iphone,
                              color: isPracticePhoneEnabled
                                  ? Colors.black
                                  : Colors.grey,
                              size: screenHeight * 0.05,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              setState(() => isPracticeEmailEnabled =
                                  !isPracticeEmailEnabled);
                              await updateReminderSettings();
                            },
                            icon: Icon(
                              Icons.mail_outlined,
                              color: isPracticeEmailEnabled
                                  ? Colors.black
                                  : Colors.grey,
                              size: screenHeight * 0.05,
                            ),
                          ),
                        ],
                        onTap: () {},
                      ),
                      Divider(),
                      CustomRowTileButton(
                        title: "Weekly progress",
                        rowChildren: [
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                isWeeklyProgressEnabled =
                                    !isWeeklyProgressEnabled;
                              });
                              await updateReminderSettings();
                            },
                            icon: Icon(
                              Icons.mail_outlined,
                              color: isWeeklyProgressEnabled
                                  ? Colors.black
                                  : Colors.grey,
                              size: screenHeight * 0.05,
                            ),
                          ),
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
                    onPressed: () {
                      // Implement restore default functionality
                    },
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
