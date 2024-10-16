import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(133, 220, 64, 1),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthUnit = MediaQuery.of(context).size.width / 390;
    double screenHeightUnit = MediaQuery.of(context).size.height / 844;
    List<Widget> friendsColumnWidgets = [
      friendsColumnWidget(
          image: "assets/images/contacts.png",
          words: "Choose from contacts",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
      friendsColumnWidget(
          image: "assets/images/magGlass.png",
          words: "Enter Phone Number",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
      friendsColumnWidget(
          image: "assets/images/shareProfile.png",
          words: "Share your profile",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
    ];

    List<Widget> friendsRowWidgets = [
      friendsRowWidget(
          image: "assets/images/contacts.png",
          name: "Josh Feenberg",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
      friendsRowWidget(
          image: "assets/images/magGlass.png",
          name: "Daniel Lee",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
      friendsRowWidget(
          image: "",
          name: "",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
    ];
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeightUnit * 57),
          Padding(
              padding: EdgeInsets.fromLTRB(screenHeightUnit * 4, 0, 0, 0),
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
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(screenWidthUnit * 14,
                screenHeightUnit * 40, screenWidthUnit * 19, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Friends suggestions",
                  style: GoogleFonts.inter(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen(),));
                  },
                  child: Text(
                    "view all",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(135, 206, 235, 1)),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [if (friendsRowWidgets.isNotEmpty) ...friendsRowWidgets],
          ),
          SizedBox(
            height: screenHeightUnit * 40,
          )
        ],
      ),
    ));
  }

  Widget friendsRowWidget({
    required String image,
    required String name,
    required double screenHeightUnit,
    required double screenWidthUnit,
  }) {
    return Container(
      height: screenHeightUnit * 150,
      width: screenWidthUnit * 109,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 246, 246, 1),
        borderRadius: BorderRadius.circular(screenWidthUnit * 20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: name.isEmpty
          ? Column()
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, screenHeightUnit * 8, screenWidthUnit * 14, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("close");
                        },
                        child: Icon(
                          Icons.close,
                          size: screenHeightUnit * 21,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Center(
                      child: Container(
                    height: screenHeightUnit * 46,
                    width: screenHeightUnit * 46,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(200, 200, 200, 1),
                      shape: BoxShape.circle,
                    ),
                  )),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, screenHeightUnit * 7, 0, 0),
                    child: Center(
                      child: Text(name,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, screenHeightUnit * 3, 0, 0),
                    child: Center(
                      child: Text(
                        "You may know\neach other",
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, screenHeightUnit * 3, 0, 0),
                  child: Center(
                      child: GestureDetector(
                    child: Container(
                      height: 15 * screenHeightUnit,
                      width: 71 * screenWidthUnit,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(135, 206, 235, 1),
                        borderRadius:
                            BorderRadius.circular(screenHeightUnit * 8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        "Follow",
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                )
              ],
            ),
    );
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
        SizedBox(
          height: screenHeightUnit * 39,
        ),
        GestureDetector(
          onTap: () {
            if (words == "Choose from contacts") {
              print("Contacts");
            } else if (words == "Enter Phone Number") {
              print("Enter Phone");
            } else {
              print("share");
            }
          },
          child: Container(
              height: screenHeightUnit * 97,
              width: screenWidthUnit * 357,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(246, 246, 246, 1),
                borderRadius: BorderRadius.circular(screenWidthUnit * 20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidthUnit * 12,
                  ),
                  Image.asset(
                    image,
                    height: screenHeightUnit * 57,
                    width: screenWidthUnit * 53,
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
        )
      ],
    ));
  }
}

