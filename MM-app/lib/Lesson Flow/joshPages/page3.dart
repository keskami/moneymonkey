import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_monkey/home.dart';
import 'package:google_fonts/google_fonts.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;

  List<String> availableItems = ['Item A', 'Item B', 'Item C'];
  List<String> droppedItems1 = [];
  List<String> droppedItems2 = [];
  List<String> droppedItems3 = [];

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
            .get();

        if (profileSnapshot.exists) {
          setState(() {
            final data = profileSnapshot.data() as Map<String, dynamic>?;

            var portfolioData = data?['Portfolio'] as Map<String, dynamic>?;

            if (portfolioData != null) {
              balance = portfolioData['Balance'] ?? 0;
              totalBanans = portfolioData['Total Bananas'] ?? 0;
            }

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: screenHeight * .05),
          topOfLesson(
            screenWidthUnit: screenWidthUnit,
            screenHeightUnit: screenHeightUnit,
            pageNumber: 5,
            totalPages: 10,
            context: context,
            bananas: totalBanans,
          ),
          SizedBox(height: 20),
          // Droppable Section
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDropZone(droppedItems1, 'Drop Zone 1'),
                _buildDropZone(droppedItems2, 'Drop Zone 2'),
                _buildDropZone(droppedItems3, 'Drop Zone 3'),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Draggable Items Row

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: availableItems.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: _buildDraggableItem(item),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropZone(List<String> droppedItems, String label) {
    return DragTarget<String>(
      onAccept: (data) {
        setState(() {
          droppedItems.add(data);
          availableItems.remove(data);
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 100,
          height: 200,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ...droppedItems.map((item) => _buildDroppedItem(item)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDraggableItem(String label) {
    return Draggable<String>(
      data: label,
      feedback: Material(
        color: Colors.transparent,
        child: _buildDroppedItem(label),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildDroppedItem(label),
      ),
      child: _buildDroppedItem(label),
    );
  }

  Widget _buildDroppedItem(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Text(label, style: TextStyle(fontSize: 14)),
      ),
    );
  }
}

Widget topOfLesson({
  required double screenWidthUnit,
  required double screenHeightUnit,
  required double pageNumber,
  required double totalPages,
  required BuildContext context,
  required int bananas,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        icon: Icon(Icons.close, color: Colors.black),
      ),
      Container(
        height: screenHeightUnit * 25,
        width: screenWidthUnit * 202,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(135, 206, 235, 1),
              Color.fromRGBO(213, 213, 213, 1),
            ],
            stops: [pageNumber / totalPages, pageNumber / totalPages],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
      SizedBox(width: screenWidthUnit * 4),
      Image.asset("assets/images/img_monkeymoney_52.png",
          height: screenHeightUnit * 36),
      SizedBox(width: screenWidthUnit * 1),
      Text(
        "$bananas",
        style: GoogleFonts.roboto(
          fontSize: screenWidthUnit * 5.5,
          color: Colors.black,
        ),
      ),
    ],
  );
}
