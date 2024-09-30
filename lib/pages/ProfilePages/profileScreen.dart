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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 15,
                  child: Text(
                    "Total asset value",
                    style:
                        GoogleFonts.baloo2(fontSize: 13, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Text(
                    '$totalProfitString🍌',
                    style: TextStyle(
                      fontSize: 36,
                      fontFamily: "FredokaOne",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Row(
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
                          color:
                              _changePercentage > 0 ? Colors.blue : Colors.red,
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
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Center(
              child: SizedBox(
                width: 320,
                height: 144,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(135, 206, 235, 1),
                    borderRadius: BorderRadius.circular(10),
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
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 366,
                height: 265,
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
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.lightBlue,
                                    width: _currButton == "Expenses" ? 2 : 0,
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
                        padding: EdgeInsets.fromLTRB(20, 100, 0, 0),
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                  height: 1,
                                  width: 332,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 0, .3),
                                  ),
                                )),
                            SizedBox(
                              width: 332,
                              height: 160,
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
                                      padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                      child: Container(
                                        height: 1,
                                        width: 332,
                                        decoration: const BoxDecoration(
                                          color: Color.fromRGBO(0, 0, 0, .3),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "View All >",
                                      style: GoogleFonts.baloo2(fontSize: 18),
                                    ),
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
           
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          height: 145,
          color: Colors.white,

          child: Column(
            children: [
              Container(
                height: 60,
                width: 500,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Text(
                          "Buying Power  >",
                          style: GoogleFonts.baloo2(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        )
                      ],
                    )
                  ],
                )),
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 62,
                height: 55,
                child: Image.asset("assets/images/navbar1.png"),
              ),
              SizedBox(
                width: 63,
                height: 60,
                child: Image.asset("assets/images/navbar2.png"),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: Image.asset("assets/images/navbar3.png"),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: Image.asset("assets/images/navbar4.png"),
              ),
            ],
          ),

            ],
          )
         
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
      padding: EdgeInsets.fromLTRB(0, 4, 5, 4),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: 15),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.baloo2(fontSize: 13, color: Colors.black),
                ),
                Text(subtitle,
                    style: GoogleFonts.baloo2(
                      color: Colors.black,
                      fontSize: 10,
                    )),
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
