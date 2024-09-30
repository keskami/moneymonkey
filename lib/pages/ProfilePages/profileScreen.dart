// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  int? totalProfit;
  bool isLoading = true;
  String totalProfitString = '0.00';
  Map<String, dynamic>? profileData;
  final double _changePercentage = -2.43;
  String _currButton = "All";
  bool isExpanded = false;

  void _updateButton(String buttonText) {
    setState(() {
      _currButton = buttonText;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(133, 220, 64, 1),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    if (userID != null) {
      try {
        DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(userID)
            .collection('profile')
            .doc('userProfile')
            .get();

        if (profileSnapshot.exists) {
          setState(() {
            profileData = profileSnapshot.data() as Map<String, dynamic>?;
            totalProfit = profileData?['Total Profit'];
            totalProfitString =
                NumberFormat('#,###').format(totalProfit?.toInt() ?? 0);
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height * .9;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Text(
                  "Total asset value",
                  style: GoogleFonts.baloo2(fontSize: 13, color: Colors.black),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      '$totalProfitString🍌',
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: "FredokaOne",
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    _changePercentage > 0
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: _changePercentage > 0 ? Colors.blue : Colors.red,
                  ),
                  Text(
                    '$_changePercentage% ',
                    style: GoogleFonts.baloo2(
                      fontSize: 13,
                      color: _changePercentage > 0 ? Colors.blue : Colors.red,
                    ),
                  ),
                  const Text(
                    'from this week',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Center(
                child: SizedBox(
                  width: 320,
                  height: 164,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(135, 206, 235, 1),
                      borderRadius: BorderRadius.circular(screenHeight * .02),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Balance",
                              style: GoogleFonts.baloo2(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: EdgeInsets.only(top: 15, right: 17),
                            child: SizedBox(
                              height: 39,
                              width: 41,
                              child: Image.asset('assets/images/bank.png'),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "**** 0149",
                              style: GoogleFonts.baloo2(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "05/25",
                              style: GoogleFonts.baloo2(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.1),
                              child: Row(
                                children: [
                                  Text(
                                    "7,630🍌",
                                    style: GoogleFonts.baloo2(
                                        fontSize: 52, color: Colors.white),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: SizedBox(
                  width: 366,
                  height: 300,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Text(
                              "Transactional History",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "FredokaOne",
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 37, 0, 0),
                            child: Text(
                              "A list of historical transactions",
                              style: GoogleFonts.baloo2(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(13, 60, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 29,
                                  width: 69,
                                  padding: const EdgeInsets.all(0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _currButton == "All"
                                        ? const Color.fromRGBO(255, 224, 130, 1)
                                        : const Color.fromRGBO(
                                            217, 217, 217, 100),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.lightBlue,
                                      width: _currButton == "All" ? 2 : 0,
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      _updateButton("All");
                                    },
                                    child: Text(
                                      "All",
                                      style: GoogleFonts.baloo2(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: _currButton == "All"
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        height: -.01,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 29,
                                  width: 89,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _currButton == "Income"
                                        ? const Color.fromRGBO(255, 224, 130, 1)
                                        : const Color.fromRGBO(
                                            217, 217, 217, 100),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.lightBlue,
                                      width: _currButton == "Income" ? 2 : 0,
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      _updateButton("Income");
                                    },
                                    child: Text(
                                      "Income",
                                      style: GoogleFonts.baloo2(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: _currButton == "Income"
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        height: -.01,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 29,
                                  width: 89,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _currButton == "Expenses"
                                        ? const Color.fromRGBO(255, 224, 130, 1)
                                        : const Color.fromRGBO(
                                            217, 217, 217, 100),
                                    borderRadius: BorderRadius.circular(
                                        10),
                                    border: Border.all(
                                      color: Colors.lightBlue,
                                      width:
                                          _currButton == "Expenses" ? 2 : 0,
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      _updateButton("Expenses");
                                    },
                                    child: Text(
                                      "Expenses",
                                      style: GoogleFonts.baloo2(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: _currButton == "Expenses"
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        height: -.01,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              screenWidth * .029, screenHeight * .165, 0, 0),
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0, 0, 0, screenHeight * .007),
                                  child: Container(
                                    height: screenHeight * .001,
                                    width: screenWidth * 1,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, .3),
                                    ),
                                  )),
                              SizedBox(
                                width: screenWidth * .8,
                                height: screenHeight * .24,
                                child: Column(
                                  children: [
                                    transactionItem(
                                      icon: Icons.savings_outlined,
                                      title: 'Savings',
                                      subtitle: 'Paid From Balance',
                                      amount: '-200',
                                      imageUrl: 'assets/images/banana.png',
                                    ),
                                    transactionItem(
                                      icon: Icons.savings_outlined,
                                      title: 'Savings',
                                      subtitle: 'Paid From Balance',
                                      amount: '-200',
                                      imageUrl: 'assets/images/banana.png',
                                    ),
                                    transactionItem(
                                      icon: Icons.trending_up_outlined,
                                      title: 'Investment',
                                      subtitle: 'Paid From Balance',
                                      amount: '-300',
                                      imageUrl: 'assets/images/banana.png',
                                    ),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0, screenHeight * .004, 0, 0),
                                        child: Container(
                                          height: screenHeight * .0015,
                                          width: screenWidth * .95,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, .3),
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text("View All >"),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .02,
              ),
              SizedBox(
                height: screenHeight * 0.18,
                width: screenWidth,
                child: Container(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 4),
                                TextButton(
                                  onPressed: () {
                                    isExpanded = !isExpanded;
                                  },
                                  child: Text(
                                    "Buying Power  >",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(0, 0),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                '7,630🍌',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 191,
                                height: isExpanded ? 80 : 52,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: isExpanded
                                      ? Border.all(color: Colors.blue, width: 2)
                                      : Border.all(
                                          color: Colors.transparent, width: 0),
                                ),
                                child: isExpanded
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Invest',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Divider(
                                            color: Colors.white,
                                            thickness: 1,
                                          ),
                                          Text(
                                            'Save',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    : Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Grow  ^',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 42,
                height: 35,
                child: Image.asset("assets/images/navbar1.png"),
              ),
              SizedBox(
                width: 53,
                height: 52,
                child: Image.asset("assets/images/navbar2.png"),
              ),
              SizedBox(
                width: 39,
                height: 39,
                child: Image.asset("assets/images/navbar3.png"),
              ),
              SizedBox(
                width: 38,
                height: 39,
                child: Image.asset("assets/images/navbar4.png"),
              ),
            ],
          ),
        ));
  }

  Widget transactionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required String imageUrl,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          0, screenHeight * .004, screenWidth * .01, screenHeight * .004),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: screenHeight * .018),
          ),
          SizedBox(width: screenWidth * .018),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.baloo2(
                      fontSize: screenHeight * .018, color: Colors.black),
                ),
                Text(subtitle,
                    style: GoogleFonts.baloo2(
                        color: Colors.black,
                        fontSize: screenHeight * .015,
                        height: screenHeight * .0015)),
              ],
            ),
          ),
          Text(amount,
              style: GoogleFonts.baloo2(fontSize: screenHeight * .0275)),
          SizedBox(width: screenWidth * .03),
          Image.asset(imageUrl, height: screenHeight * .0367),
        ],
      ),
    );
  }
}
