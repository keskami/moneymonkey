import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
import 'package:money_monkey/home.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  bool delay = false;
  bool loading = true;

  PeerReflectioncontroller peerReflectionController = Get.find();

  String title = '';
  String subTitle = '';
  String ava1 = '';
  String ava2 = '';
  String maria1 = '';
  String maria2 = '';
  String jason1 = '';
  String jason2 = '';
  String button = '';

  Future<void> setData(data) async {
    setState(() {
      title = data['title'];
      subTitle = data['subTitle'];
      ava1 = data['ava'];
      ava2 = data['ava2'];
      maria1 = data['maria'];
      maria2 = data['maria2'];
      jason1 = data['jason'];
      jason2 = data['jason2'];
       button = data['button'];

      loading = false;
    });
    _6secdelay();
  }

  @override
  void initState() {
    super.initState();
    ever(peerReflectionController.isLoading, (_) {
      if (!peerReflectionController.isLoading.value) {
        if (peerReflectionController.pageData.isNotEmpty) {
          setData(peerReflectionController.pageData[1]);
        }
      }
    });
    if (title == '') {
      setData(peerReflectionController.pageData[1]);
    }
  }

  Future<void> _6secdelay() async {
    await Future.delayed(Duration(seconds: 6));
    setState(() {
      delay = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;

    return loading
        ? Center(child: CircularProgressIndicator())
        : Column(children: [
            SizedBox(height: screenHeightUnit * 92),
            Text(
              title,
              style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 7,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: screenHeightUnit * 42),
            Text(
              subTitle,
              style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 4.5,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  height: ((5 / 3) * screenWidthUnit) / 3.5),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeightUnit * 42),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                newMonkey(
                    screenWidthUnit: screenWidthUnit,
                    screenHeightUnit: screenHeightUnit,
                    monkeyImage: 'assets/images/newMonkeys/Maria.png',
                    name: maria1,
                    description: maria2),
                SizedBox(
                  width: screenWidthUnit * 10,
                ),
                newMonkey(
                    screenWidthUnit: screenWidthUnit,
                    screenHeightUnit: screenHeightUnit,
                    monkeyImage: 'assets/images/newMonkeys/Jason.png',
                    name: jason1,
                    description: jason2),
                SizedBox(
                  width: screenWidthUnit * 10,
                ),
                newMonkey(
                    screenWidthUnit: screenWidthUnit,
                    screenHeightUnit: screenHeightUnit,
                    monkeyImage: 'assets/images/newMonkeys/Ava.png',
                    name: ava1,
                    description: ava2),
              ],
            ),
            SizedBox(height: screenHeightUnit * 82),
            GestureDetector(
                onTap: !delay
                    ? () {}
                    : () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        peerReflectionController.pageIndex.value += 1;
                      },
                child: Container(
                  height: screenHeightUnit * 58,
                  width: screenWidthUnit * 61,
                  decoration: BoxDecoration(
                    color: !delay
                        ? Color.fromRGBO(224, 227, 231, 1)
                        : Color.fromRGBO(137, 220, 142, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      button,
                      style: GoogleFonts.baloo2(
                          fontSize: screenWidthUnit * 4.2,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ))
          ]);
  }
}

Widget newMonkey({
  required double screenWidthUnit,
  required double screenHeightUnit,
  required String monkeyImage,
  required String name,
  required String description,
}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
    Image.asset(
      monkeyImage,
      height: screenHeightUnit * 135,
    ),
    Text("$name",
        style: GoogleFonts.baloo2(
            fontSize: screenWidthUnit * 4.5,
            color: Colors.black,
            fontWeight: FontWeight.w700)),
    SizedBox(height: screenHeightUnit * 5),
    Text("$description",
        style: GoogleFonts.baloo2(
            fontSize: screenWidthUnit * 4.5,
            color: Colors.black,
            fontWeight: FontWeight.w700)),
  ]);
}

