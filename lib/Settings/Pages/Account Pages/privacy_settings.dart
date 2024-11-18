import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Services/settings_service.dart';
import 'package:money_monkey/Settings/Widgets/custom_container.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({super.key});

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  bool isPublic = true;
  String? userId;
  final SettingsService settingsService = SettingsService();

  Future<void> fetchUserId() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final settings = await settingsService.getPrivacySettings(userId!);
      print(settings);
      setState(() {
        isPublic = settings['Public Profile'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Privacy Settings",
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
                  height: 20,
                ),
                Column(
                  children: [
                    CustomContainer(
                      child: ListTile(
                        title: Text(
                          "Public Profile",
                          style: GoogleFonts.baloo2(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Others will be able to find your profile and follow you. You will now be in public leaderboards.",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        trailing: Switch(
                          value: isPublic,
                          activeColor: Colors.grey,
                          onChanged: (value) async {
                            await settingsService.updatePrivacySettings(
                                userId: userId!, public: !isPublic);
                            setState(() {
                              isPublic = !isPublic;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
