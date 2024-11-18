import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Lesson Flow/controller/controller.dart';

class TopBar extends StatefulWidget {
  final String userId; // Pass the userId from the parent
  final ProgressController progressController;

  const TopBar(
      {Key? key, required this.userId, required this.progressController})
      : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  int bananas = 0;
  int diamonds = 0;
  int monkeys = 0;

  @override
  void initState() {
    super.initState();
    fetchEarnings();

    // Observe changes in the controller
    //ProgressController progressController = Get.find<ProgressController>();
    widget.progressController.progress.listen((progress) {
      if (progress == 1.0) {
        fetchEarnings(); // Fetch bananas once progress is complete
      }
    });
  }

  Future<void> fetchEarnings() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      String? userId = currentUser?.uid;

      if (userId != null) {
        // Reference to the user's Progression sub-collection
        final progressionRef = FirebaseFirestore.instance
            .collection('Users')
            .doc(userId) // Use the real userId here
            .collection('Progression')
            .doc('progression1'); // Assuming you're using 'progression1'

        print("Fetching earnings for user: $userId");
        final docSnapshot = await progressionRef.get();

        if (docSnapshot.exists) {
          final earnings = docSnapshot['Earnings from Lesson'];
          setState(() {
            bananas = earnings['Bananas'] ?? 0;
            diamonds = earnings['Diamonds'] ?? 0;
            monkeys = earnings['Monkeys'] ?? 0;
          });
        }
      } else {
        print("Error: User is not logged in.");
      }
    } catch (e) {
      print("Error fetching earnings: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    double iconSize = screenSize.width * 0.12;
    double textSize = screenSize.height * 0.02;
    print(screenSize);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Obx(() {
        // Wrap in Obx to reactively update when progress changes
        if (widget.progressController.progress.value == 1.0) {
          // When lesson is complete, refresh earnings
          fetchEarnings();
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/images/img_transparent_logo.png',
                    height: iconSize),
                const SizedBox(width: 8),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/images/img_monkeymoney_50.png',
                    height: iconSize),
                const SizedBox(width: 8),
                Text('$monkeys',
                    style: TextStyle(
                        fontSize: textSize, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/images/img_monkeymoney_51.png',
                    height: iconSize),
                const SizedBox(width: 8),
                Text('$diamonds',
                    style: TextStyle(
                        fontSize: textSize, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/images/img_monkeymoney_52.png',
                    height: iconSize),
                const SizedBox(width: 8),
                Text('$bananas',
                    style: TextStyle(
                        fontSize: textSize, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        );
      }),
    );
  }
}
