import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Invest1 extends StatefulWidget {
  const Invest1({super.key});

  @override
  State<Invest1> createState() => _Invest1State();
}

class _Invest1State extends State<Invest1> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  final String? name = FirebaseAuth.instance.currentUser?.displayName;
  final int monthyAmount = 1100;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthUnit = MediaQuery.of(context).size.width / 390;
    double screenHeightUnit = MediaQuery.of(context).size.height / 880;

    return Scaffold(
      backgroundColor: Color.fromRGBO(137, 220, 142, 1),
      body: Column(
        children: [
          SizedBox(height: screenHeightUnit * 47),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  screenWidthUnit * 14, screenHeightUnit * 9, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: screenHeightUnit * 20,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidthUnit * 24,
                      ),
                      Text(
                        "Welcome Back $name 👋",
                        style: GoogleFonts.baloo2(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 24 * screenWidthUnit),
                      Text(
                        '🍌7600',
                        style: GoogleFonts.baloo2(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10 * screenWidthUnit),
                      monthyAmount > 0
                          ? Icon(
                              Icons.arrow_upward_sharp,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.arrow_downward_sharp,
                              color: Colors.white,
                            ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
