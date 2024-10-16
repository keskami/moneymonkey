import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LoginPages/login.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/friendsPages/friendsHome.dart';

class FriendsSuggestions extends StatefulWidget {
  const FriendsSuggestions({super.key});

  @override
  State<FriendsSuggestions> createState() => _FriendsSuggestionsState();
}

class _FriendsSuggestionsState extends State<FriendsSuggestions> {
  @override
  Widget build(BuildContext context) {
    double screenWidthUnit = MediaQuery.of(context).size.width / 390;
    double screenHeightUnit = MediaQuery.of(context).size.height / 844;
    List<Widget> friendsColumnWidgets = [
      friendSuggestion(name: "Josh Feenberg", image: "assets/images/magGlass.png", whySuggested: "", screenHeightUnit: screenHeightUnit, screenWidthUnit: screenWidthUnit)
    ];

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeightUnit * 57),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidthUnit * 18, 0, 0, 0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FriendsHome()));
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: screenHeightUnit * 37,
                    ),
                  ),
                  SizedBox(
                    width: screenWidthUnit * 20,
                  ),
                  Text(
                    "Friend Suggestions",
                    style: GoogleFonts.fredoka(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ]),
              ),
            ],
          ),
          SizedBox(
            height: screenHeightUnit * 8,
          ),
          Container(
            height: screenHeightUnit * 1,
            width: double.infinity,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          SizedBox(
            height: screenHeightUnit * 20,
          ),
          Center(
              child: Container(
            height: screenHeightUnit * 676,
            width: screenWidthUnit * 350,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black, width: screenWidthUnit * 2),
              borderRadius: BorderRadius.circular(screenWidthUnit * 20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                if (friendsColumnWidgets.isNotEmpty) ...friendsColumnWidgets
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget friendSuggestion({
    required String name,
    required String image,
    required String whySuggested,

    required double screenHeightUnit,
    required double screenWidthUnit,
  }) {
    return Container(child: Text(name));
  }
}
