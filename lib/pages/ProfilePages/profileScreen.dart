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

  void _logout() async {
    if (mounted) {
       await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.06),
            Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * .04, 0, 0, 0),
              child:  Text(
                "Total asset value",
                style: GoogleFonts.baloo2(fontSize: screenHeight * .02, ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * .02, 0, 0, 0),
                  child: Text(
                    totalProfitString,
                    style:
                         TextStyle(fontSize: screenHeight * .05, fontFamily: "FredokaOne"),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.13,
                  height: screenHeight * 0.05,
                  child: Image.asset("assets/images/banana.png"),
                )
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
                  style: TextStyle(
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
              height: screenHeight * 0.002,
            ),
            Center(
              child: SizedBox(
                width: screenWidth * 0.82,
                height: screenHeight * 0.259,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(135, 206, 235, 1),
                    borderRadius: BorderRadius.circular(screenHeight * .02),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(screenHeight * 0.02),
                          child:  Text(
                            "Balance",
                            style: GoogleFonts.baloo2(
                                color: Colors.white,
                                fontSize: screenHeight * .0235,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.only(right: screenWidth * 0.04),
                          child: SizedBox(
                            height: screenHeight * .1,
                            width: screenWidth * .1,
                            child: Image.asset('assets/images/bank.png'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(screenHeight * 0.02),
                          child:  Text(
                            "**** 0149",
                            style: GoogleFonts.baloo2(
                                color: Colors.white,
                                fontSize: screenHeight * 0.026,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(screenHeight * 0.02),
                          child:  Text(
                            "05/25",
                            style: GoogleFonts.baloo2(
                                fontSize: 20,
                                
                                color: Colors.white),
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
                                  "7,630",
                                  style: GoogleFonts.baloo2(
                                      fontSize: 52,
                                      
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: screenHeight * .15,
                                  width: screenWidth * .15,
                                  child:
                                      Image.asset('assets/images/banana.png'),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * .03),
            Center(
              child: SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight * 0.364,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
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
                          padding: EdgeInsets.fromLTRB(
                              screenWidth * .03, screenWidth * .03, 0, 0),
                          child:  Text(
                            "Transactional History",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenHeight * .035,
                                fontFamily: "FredokaOne"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              screenWidth * .029, screenWidth * .11, 0, 0),
                          child:  Text(
                            "A list of historical transactions",
                            style: GoogleFonts.baloo2(
                                color: Colors.black,
                                fontSize: screenHeight * .018,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                screenWidth * .029, screenHeight * .1, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: screenHeight * .055,
                                  width: screenWidth * .19,
                                  padding: const EdgeInsets.all(0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(255, 224, 130, 1),
                                    borderRadius: BorderRadius.circular(
                                      screenHeight * .02,
                                    ),
                                    border: Border.all(
                                      color: Colors.lightBlue,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child:  Text(
                                      "All",
                                      style: GoogleFonts.baloo2(
                                        color: Colors.black,
                                        fontSize: 15,
                                       
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: screenHeight * .055,
                                  width: screenWidth * .225,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        217, 217, 217, 100),
                                    borderRadius: BorderRadius.circular(
                                        screenHeight * .02),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child:  Text(
                                      "Income",
                                      style: GoogleFonts.baloo2(
                                          color: Colors.black,
                                          fontSize: 13,
                                          
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: screenHeight * .055,
                                  width: screenWidth * .225,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        217, 217, 217, 100),
                                    borderRadius: BorderRadius.circular(
                                        screenHeight * .02),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Expenses",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: "Ballo2",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _logout,
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
