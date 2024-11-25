import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Services/crud.dart';
import 'package:money_monkey/Friends/friendsHome.dart';
import 'package:money_monkey/Friends/friendsProfile.dart';

class FriendsSuggestions extends StatefulWidget {
  FriendsSuggestions({super.key});

  @override
  State<FriendsSuggestions> createState() => _FriendsSuggestionsState();
}

class _FriendsSuggestionsState extends State<FriendsSuggestions> {
  final FirebaseService crud = FirebaseService();
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;

  List<Map<String, String>> friends = [];

  @override
  void initState() {
    super.initState();
    loadFriendSuggestions();
  }

  Future<void> loadFriendSuggestions() async {
    if (userID != null) {
      List<Map<String, String>> fetchedFriends =
          await crud.findFriends(userID!, 9);
      setState(() {
        friends = fetchedFriends;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthUnit = MediaQuery.of(context).size.width / 390;
    double screenHeightUnit = MediaQuery.of(context).size.height / 844;

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                    SizedBox(width: screenWidthUnit * 20),
                    Text(
                      "Friend Suggestions",
                      style: GoogleFonts.fredoka(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeightUnit * 8),
          Container(
            height: screenHeightUnit * 1,
            width: double.infinity,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
          SizedBox(height: screenHeightUnit * 20),
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
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              child: Column(
                children: friends.isEmpty
                    ? [Center(child: CircularProgressIndicator())]
                    : friends
                        .map((friend) => friendSuggestion(
                              name: friend["name"]!,
                              whySuggested: friend["whySuggested"]!,
                              screenHeightUnit: screenHeightUnit,
                              screenWidthUnit: screenWidthUnit,
                              otherID: friend["otherID"]!,
                              onRemove: () => removeFriend(friend["otherID"]!),
                            ))
                        .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  void removeFriend(String otherID) {
    crud.follow(userID!, otherID);
    setState(() {
      friends = [];
    });
    loadFriendSuggestions();
  }

  Widget friendSuggestion({
    required String name,
    required String whySuggested,
    required double screenHeightUnit,
    required double screenWidthUnit,
    required String otherID,
    required VoidCallback onRemove,
  }) {
    return Container(
      height: screenHeightUnit * 72,
      width: screenWidthUnit * 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10 * screenWidthUnit),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => friendProfile(otherID: otherID),
                      ));
                },
                child: Container(
                  height: screenHeightUnit * 46,
                  width: screenHeightUnit * 46,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(width: 13 * screenWidthUnit),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.fredoka(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    whySuggested,
                    style: GoogleFonts.baloo2(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: onRemove,
                child: Container(
                  height: 23 * screenHeightUnit,
                  width: 95 * screenWidthUnit,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(135, 206, 235, 1),
                    borderRadius: BorderRadius.circular(screenHeightUnit * 8),
                    border: Border.all(
                        color: Colors.black, width: screenWidthUnit * 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Follow",
                      style: GoogleFonts.fredoka(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidthUnit * 18),
            ],
          ),
          Spacer(),
          Container(
            height: screenHeightUnit * 1,
            width: screenWidthUnit * 380,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
