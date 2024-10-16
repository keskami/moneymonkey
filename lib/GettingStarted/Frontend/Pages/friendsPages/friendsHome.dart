// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LoginPages/login.dart';

class FriendsHome extends StatefulWidget {
  const FriendsHome({super.key});

  @override
  _FriendsHomeState createState() => _FriendsHomeState();
}

class _FriendsHomeState extends State<FriendsHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthUnit = MediaQuery.of(context).size.width / 390;
    double screenHeightUnit = MediaQuery.of(context).size.height / 844;
    List<Widget> friendsColumnWidgets = [
      friendsColumnWidget(
          image: "Test",
          words: "Choose from contacts",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
      friendsColumnWidget(
          image: "Test",
          words: "Enter Phone Number",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
      friendsColumnWidget(
          image: "Test",
          words: "Share your profile",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
    ];
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeightUnit * 57),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  screenHeightUnit * 4, screenHeightUnit * 4, 0, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: Icon(
                  Icons.arrow_back,
                  size: screenHeightUnit * 37,
                ),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(
                screenHeightUnit * 14, screenHeightUnit * 27, 0, 0),
            child: Text(
              "Find your friends",
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Column(
            children: [
              if (friendsColumnWidgets.isNotEmpty) ...friendsColumnWidgets
            ],
          )
        ],
      ),
    ));
  }

  Widget friendsColumnWidget({
    required String image,
    required String words,
    required double screenHeightUnit,
    required double screenWidthUnit,
  }) {
    return Center(
        child: Column(
      children: [
        SizedBox(height: screenHeightUnit * 39,),
        Container(
            height: screenHeightUnit * 97,
            width: screenWidthUnit * 357,
            decoration: BoxDecoration(
              color: Color.fromRGBO(246, 246, 246, 1),
              borderRadius: BorderRadius.circular(screenWidthUnit * 20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidthUnit * 12,
                ),
                Icon(
                  Icons.arrow_back,
                  size: screenHeightUnit * 50,
                ),
                SizedBox(
                  width: screenWidthUnit * 21,
                ),
                Text(
                  words,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )),
      ],
    ));
  }
}
