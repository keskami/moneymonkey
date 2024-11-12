import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Services/crud.dart';
import 'package:money_monkey/friendsPages/comingSoonPage.dart';
import 'package:money_monkey/friendsPages/friendsFromContacts.dart';
import 'package:money_monkey/friendsPages/friendsProfile.dart';
import 'package:money_monkey/friendsPages/friendsSearch.dart';
import 'package:money_monkey/friendsPages/friendsSuggestion.dart';
import 'package:money_monkey/LoginPages/login.dart';

class FriendsHome extends StatefulWidget {
  const FriendsHome({super.key});

  @override
  _FriendsHomeState createState() => _FriendsHomeState();
}

class _FriendsHomeState extends State<FriendsHome> {
  final FirebaseService crud = FirebaseService();
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;

  List<Map<String, String>> friends = [];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(133, 220, 64, 1),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    loadFriendSuggestions(3, '');
  

    super.initState();
  }

  Future<void> loadFriendSuggestions(int amount, String remove) async {
    if (userID != null) {
      List<Map<String, String>> fetchedFriends =
          await crud.findFriends(userID!, amount);

          

      fetchedFriends.removeWhere((friend) => friend["otherID"] == remove);

      setState(() {
        friends = fetchedFriends;
      });
    }
  }

  void _showBottomSheet(
      BuildContext context, double screenHeightUnit, double screenWidthUnit) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: EdgeInsets.all(0),
            height: 175 * screenHeightUnit,
            width: 390 * screenWidthUnit,
            decoration: BoxDecoration(
                color: Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.circular(screenWidthUnit * 15)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          screenWidthUnit * 0, screenHeightUnit * 13, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: screenHeightUnit * 39,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(0, screenHeightUnit * 11, 0, 0),
                      child: Text(
                        "Follow me on Money Monkey!",
                        style: GoogleFonts.baloo2(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(0, 0, 0, .62)),
                      ),
                    ),
                    SizedBox(
                      width: screenHeightUnit * 39,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidthUnit * 26,
                      screenHeightUnit * 20, screenWidthUnit * 26, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/textMessage.png",
                            height: screenHeightUnit * 64,
                            width: screenWidthUnit * 58,
                          ),
                          Text(
                            "iMessage",
                            style: GoogleFonts.baloo2(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/whatsApp.png",
                            height: screenHeightUnit * 64,
                            width: screenWidthUnit * 58,
                          ),
                          Text(
                            "Whatsapp",
                            style: GoogleFonts.baloo2(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/snapchat.png",
                            height: screenHeightUnit * 64,
                            width: screenWidthUnit * 58,
                          ),
                          Text(
                            "Snapchat",
                            style: GoogleFonts.baloo2(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/copyProfile.png",
                            height: screenHeightUnit * 64,
                            width: screenWidthUnit * 58,
                          ),
                          Text(
                            "Copy",
                            style: GoogleFonts.baloo2(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
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
          words: "Search by name",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
      friendsColumnWidget(
          image: "assets/images/shareProfile.png",
          words: "Share your profile",
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
              padding: EdgeInsets.fromLTRB(screenWidthUnit * 6, 0, 0, 0),
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
                          builder: (context) => FriendsSuggestions(),
                        ));
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
            children: friends.isEmpty
                ? [Center(child: CircularProgressIndicator())]
                : friends
                    .map((friend) => friendsRowWidget(
                          name: friend["name"]!,
                          screenHeightUnit: screenHeightUnit,
                          screenWidthUnit: screenWidthUnit,
                          otherID: friend["otherID"]!,
                          onRemove: () => removeFriend(friend["otherID"]!),
                        ))
                    .toList(),
          ),
          SizedBox(
            height: screenHeightUnit * 40,
          )
        ],
      ),
    ));
  }

  void removeFriend(String otherID) {
    crud.follow(userID!, otherID);
    setState(() {
      friends = [];
    });

    loadFriendSuggestions(3, '');
  }

  void removeFriendNotFollow(String otherID) {
    setState(() {
      friends = [];
    });

    loadFriendSuggestions(4, otherID);
  }

  Widget friendsRowWidget({
    required String name,
    required double screenHeightUnit,
    required double screenWidthUnit,
    required String otherID,
    required onRemove,
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
                          removeFriendNotFollow(otherID);
                        },
                        child: Icon(
                          Icons.close,
                          size: screenHeightUnit * 21,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => friendProfile(otherID: otherID),
                        ));
                  },
                  child: Padding(
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
                    onTap: onRemove,
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ComingSoonPage(),
                  ));
            } else if (words == "Search by name") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FriendsFromSearch(),
                  ));
            } else {
              _showBottomSheet(context, screenHeightUnit, screenWidthUnit);
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
