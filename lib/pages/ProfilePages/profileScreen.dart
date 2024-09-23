import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_monkey/Pages/ProfilePages/provider_installer_helper.dart';
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

    ProviderInstallerHelper.installProvider();
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
                  style: TextStyle(fontSize: 36, fontFamily: "FredokaOne"),
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
                SizedBox(width: 4),
                Text(
                  '$_changePercentage% ',
                  style: TextStyle(
                    color: _changePercentage > 0 ? Colors.blue : Colors.red,
                  ),
                ),
                Text(
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
                    color: Color.fromRGBO(135, 206, 235, 1), 
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text("Balance",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Ballo 2"
                          ),),
                        ),
                      ),
                      
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.free_breakfast_rounded,
                          color: Colors.white,
                          ),
                        ),
                      ),
                     
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Bottom Left"),
                        ),
                      ),
                    
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("05/25"),
                        ),
                      ),
                      // Center of the box
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Balance",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
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
