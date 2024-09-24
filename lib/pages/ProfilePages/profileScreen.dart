import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

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
          print("User profile not found.");
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        print("Error fetching user profile: $e");
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.08),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .04),
              child: const Text(
                "Total asset value",
                style: TextStyle(fontSize: 13, fontFamily: "Ballo2"),
              ),
            ),
            Row(
              children: [
                Text(
                  totalProfitString,
                  style:
                      const TextStyle(fontSize: 36, fontFamily: "FredokaOne"),
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
                const SizedBox(width: 4),
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
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: screenWidth * 0.80,
                height: screenHeight * 0.225,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(135, 206, 235, 1),
                    borderRadius: BorderRadius.circular(10),
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
                          child: const Text(
                            "Balance",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "Ballo 2"),
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
                          child: const Text(
                            "**** 0149",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "Ballo2"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(screenHeight * 0.02),
                          child: const Text(
                            "05/25",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Ballo2",
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
                                  style: TextStyle(
                                      fontSize: 52,
                                      fontFamily: "Ballo2",
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
            SizedBox(height: screenHeight * .04),
            Center(
              child: SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight * 0.325,
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
                              screenWidth * .04, screenWidth * .04, 0, 0),
                          child: Text(
                            "Transactional History",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "FredokaOne"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              screenWidth * .029, screenWidth * .11, 0, 0),
                          child: Text(
                            "A list of historical transaction",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: "Ballo2"),
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
                                  height: screenHeight * .05,
                                  width: screenWidth * .15,
                                  padding: EdgeInsets.all(0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 68),
                                    borderRadius: BorderRadius.circular(
                                        screenHeight * .01),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "All",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Ballo2"),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: screenHeight * .045,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(
                                        screenHeight * .01),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Income",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: "Ballo2"),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: screenHeight * .045,
                                  padding: EdgeInsets.all(0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(
                                        screenHeight * .01),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Expenses",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: "Ballo2"),
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
