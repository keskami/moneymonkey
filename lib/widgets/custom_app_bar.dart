import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore imports
import 'package:firebase_auth/firebase_auth.dart';   // Firebase auth imports
import 'package:moneymonkey/widgets/monkeyanimation.dart';
import '../controller/controller.dart'; // Import the controller

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ProgressController progressController;

  const CustomAppBar({Key? key, required this.progressController}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int bananas = 0;

  @override
  void initState() {
    super.initState();
    fetchBananas();
    
    // Listen for progress completion and refresh bananas
    widget.progressController.progress.listen((progress) {
      if (progress == 1.0) {
        fetchBananas();
      }
    });
  }
  @override
void dispose() {
  // Cancel any listeners or subscriptions here if needed
  super.dispose();
}

  Future<void> fetchBananas() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      String? userId = currentUser?.uid;

      if (userId != null) {
        final progressionRef = FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('Progression')
            .doc('progression1'); // Adjust the path if necessary

        final docSnapshot = await progressionRef.get();

        if (docSnapshot.exists) {
          final earnings = docSnapshot['Earnings from Lesson'];
          setState(() {
            bananas = earnings['Bananas'] ?? 0; // Update banana count
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
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
        onPressed: () {
       
          final ProgressController progressController = Get.find<ProgressController>();
          progressController.decrementProgress();
              Navigator.pop(context);
        },
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Obx((){
                print("Building progress bar with value: ${widget.progressController.progress.value}");

                   return ClipRRect(
                     borderRadius: BorderRadius.circular(20),
                     child: LinearProgressIndicator(
                       key: ValueKey(widget.progressController.progress.value), // Force rebuild
                       value: widget.progressController.progress.value, // Animated progress value
                       
                       backgroundColor: const Color(0xFFF0F0F0),
                       valueColor: const AlwaysStoppedAnimation<Color>(
                           Colors.lightBlue),
                       minHeight: 20,
                                     
                                ),
                   );
              }),
            //child: MonkeyProgressWidget(progressController:widget.progressController),
            ),
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/img_monkeymoney_52.png',
                height: 35,
              ),
              const SizedBox(width: 6),
              Text(
                '$bananas', // Display the updated bananas count
                style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
