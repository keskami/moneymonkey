import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../themes/color_themes.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

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
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FSettings%2Fno_pfp.png?alt=media&token=183f93b2-ae78-470f-9935-b04c14180bbe",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Change Image",
                        style: TextStyle(
                          color: LightTheme().primaryBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Name",
                  style: _sectionTitleStyle(),
                ),
                Text(
                  "Username",
                  style: _sectionTitleStyle(),
                ),
                Text(
                  "Password",
                  style: _sectionTitleStyle(),
                ),
                Text(
                  "Email",
                  style: _sectionTitleStyle(),
                ),
                Text(
                  "Phone Number",
                  style: _sectionTitleStyle(),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 240, 240, 240),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          offset: Offset(2, 2),
                          color: Colors.grey,
                        )
                      ]),
                  child: Center(
                    child: Text(
                      "Delete Account",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 22,
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
