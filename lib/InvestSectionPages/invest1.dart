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
  final investmentData = [
    {
      'title': 'Stocks',
      'value': 3000,
      'change': 1100,
      'icon': Icons.show_chart
    },
    {'title': 'ETFs', 'value': 1500, 'change': 120, 'icon': Icons.pie_chart},
    {
      'title': 'Mutual Funds',
      'value': 500,
      'change': 1100,
      'icon': Icons.assessment
    },
    {'title': 'Bonds', 'value': 2600, 'change': 1100, 'icon': Icons.business},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidthUnit = MediaQuery.of(context).size.width / 390;
    double screenHeightUnit = MediaQuery.of(context).size.height / 880;

    return Scaffold(
      backgroundColor: Color.fromRGBO(137, 220, 142, 1),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: screenHeightUnit * 47),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenWidthUnit * 10, screenHeightUnit * 9, 0, 0),
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
                        SizedBox(width: screenWidthUnit * 20),
                        Text(
                          "Welcome Back $name 👋",
                          style: GoogleFonts.baloo2(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: screenWidthUnit * 20),
                        Text(
                          '🍌7600',
                          style: GoogleFonts.baloo2(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8 * screenWidthUnit),
                        monthyAmount > 0
                            ? Icon(
                                size: screenHeightUnit * 17,
                                Icons.arrow_upward_sharp,
                                color: Colors.white,
                              )
                            : Icon(
                                size: screenHeightUnit * 18,
                                Icons.arrow_downward_sharp,
                                color: Colors.white,
                              ),
                        SizedBox(width: screenWidthUnit * 3),
                        Text(
                          "$monthyAmount | Month",
                          style: GoogleFonts.baloo2(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          screenWidthUnit * 20, screenHeightUnit * 9, 0, 0),
                      child: Text(
                        "Total Investments",
                        style: GoogleFonts.baloo2(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: screenHeightUnit * -30,
            child: Container(
              height: screenHeightUnit * 610,
              width: screenWidthUnit * 390,
              decoration: BoxDecoration(
                color: Color.fromRGBO(241, 244, 248, 1),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildInvestmentCard(investmentData[0], screenWidthUnit,
                          screenHeightUnit, 20),
                      _buildInvestmentCard(investmentData[1], screenWidthUnit,
                          screenHeightUnit, 20),
                    ],
                  ),
                  Row(
                    children: [
                      _buildInvestmentCard(investmentData[2], screenWidthUnit,
                          screenHeightUnit, 18),
                      _buildInvestmentCard(investmentData[3], screenWidthUnit,
                          screenHeightUnit, 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: screenHeightUnit * 83,
        color: Colors.green,
      ),
    );
  }
}

Widget _buildInvestmentCard(Map<String, dynamic> data, double screenWidthUnit,
    double screenHeightUnit, double fontSize) {
  return Container(
    height: screenHeightUnit * 90,
    width: screenWidthUnit * 160,
    decoration: BoxDecoration(
      color: Color.fromRGBO(241, 244, 248, 1),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${data['title']}',
              style: GoogleFonts.baloo2(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              data['icon'],
              size: screenWidthUnit * 18,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '🍌${data['value']}',
              style: GoogleFonts.baloo2(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                data['change'] > 0
                    ? Icon(
                        Icons.arrow_upward_sharp,
                        color: Colors.green,
                      )
                    : Icon(color: Colors.red, Icons.arrow_upward_sharp),
                Text(
                  '🍌${data['change']}',
                  style: GoogleFonts.baloo2(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: data['change'] > 0 ? Colors.green : Colors.red),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}
