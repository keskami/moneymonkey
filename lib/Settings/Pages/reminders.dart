import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Settings/Widgets/custom_list_button_tile.dart';
import 'package:money_monkey/themes/color_themes.dart';

import '../Widgets/custom_row_tile_button.dart';

class RemindersSettingsPage extends StatelessWidget {
  const RemindersSettingsPage({super.key});

  // Define common text style to avoid repetition
  TextStyle _sectionTitleStyle() {
    return GoogleFonts.baloo2(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
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
                      CustomListButtonTile(
                        title: "Reminder Time",
                        onTap: () {},
                      ),
                      Divider(),
                      CustomRowTileButton(
                        title: "Practice Message",
                        rowChildren: [
                          IconButton(
                            onPressed: () {},
                            icon: Platform.isAndroid
                                ? Icon(
                                    Icons.phone_android,
                                    color: Colors.black,
                                    size: screenHeight * 0.05,
                                  )
                                : Icon(
                                    Icons.phone_iphone,
                                    color: Colors.black,
                                    size: screenHeight * 0.05,
                                  ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.mail_outlined,
                                color: Colors.black,
                                size: screenHeight * 0.05,
                              )),
                        ],
                        onTap: () {},
                      ),
                      Divider(),
                      CustomRowTileButton(
                        title: "Weekly progress",
                        rowChildren: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.mail_outlined,
                                color: Colors.black,
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
