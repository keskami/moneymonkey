import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  double? totalProfit; 
  bool isLoading = true; 
  String totalProfitString = '0.00';
  Map<String, dynamic>? profileData;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    if (user != null) {
      try {
        DocumentSnapshot profileDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('profile')
            .doc('userProfile') // Adjust the document ID as necessary
            .get();

        if (profileDoc.exists) {
          setState(() {
            profileData = profileDoc.data() as Map<String, dynamic>;
            totalProfit = profileData!['Total Profit'] ?? 0.0; // Get total profit
            isLoading = false;
          });
        } else {
          print("Profile document does not exist.");
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        print("Error fetching profile: $e");
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst); // Return to the login screen or home
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
              child: Text(
                "Total asset value",
                style: TextStyle(fontSize: 13, fontFamily: "Ballo2"),
              ),
            ),
            Row(
              children: [
                Text(
                  totalProfitString,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
