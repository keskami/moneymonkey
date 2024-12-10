import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Services/crud.dart';
import 'package:money_monkey/Friends/friendsProfile.dart';

class FriendsFromSearch extends StatefulWidget {
  const FriendsFromSearch({super.key});

  @override
  State<FriendsFromSearch> createState() => _FriendsFromSearchState();
}

class _FriendsFromSearchState extends State<FriendsFromSearch> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> friends = [];
  final FirebaseService crud = FirebaseService();
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    onTextChanged('');
  }

  Future<void> onTextChanged(String searchText) async {
    setState(() {
      loading = true;
    });

    List<Map<String, String>> fetchedFriends =
        await crud.findFriendsFromSearch(searchText, 8, userID!);
    setState(() {
      friends = fetchedFriends;
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadFriendSuggestions() async {
    if (userID != null) {
      List<Map<String, String>> fetchedFriends =
          await crud.findFriends(userID!, 8);
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
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: screenHeightUnit * 37,
            ),
          ),
          title: Text(
            "Search for friends",
            style:
                GoogleFonts.fredoka(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeightUnit * 40),
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidthUnit * 14, 0, 0, 0),
                child: Container(
                  height: 45 * screenHeightUnit,
                  width: 348 * screenWidthUnit,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(217, 217, 217, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: onTextChanged,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.baloo2(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: 27 * screenHeightUnit,
                        color: Colors.black,
                      ),
                      hintText: 'Username',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(
                          15 * screenWidthUnit, 12 * screenHeightUnit, 0, 0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeightUnit * 34,
              ),
              Center(
                  child: Container(
                height: screenHeightUnit * 610,
                width: screenWidthUnit * 350,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black, width: screenWidthUnit * 2),
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
                  children: friends.isEmpty || loading
                      ? [Center(child: CircularProgressIndicator())]
                      : friends
                          .map((friend) => friendSuggestion(
                                name: friend["name"]!,
                                whySuggested: friend["whySuggested"]!,
                                screenHeightUnit: screenHeightUnit,
                                screenWidthUnit: screenWidthUnit,
                                otherID: friend["otherID"]!,
                                onRemove: () =>
                                    removeFriend(friend["otherID"]!),
                              ))
                          .toList(),
                ),
              ))
            ],
          ),
        ));
  }

  void removeFriend(String otherID) {
    crud.follow(userID!, otherID);

    onTextChanged(_searchController.text);
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
                          builder: (context) => friendProfile(
                                otherID: otherID,
                              )));
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
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    whySuggested,
                    style: GoogleFonts.baloo2(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.start,
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
                  child: Text(
                    "Follow",
                    style: GoogleFonts.fredoka(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
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
          )
        ],
      ),
    );
  }
}
