import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/custom_row_tile_button.dart';

class FriendsSettingsPage extends StatelessWidget {
  const FriendsSettingsPage({super.key});

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
                        title: "Friends Activity",
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
