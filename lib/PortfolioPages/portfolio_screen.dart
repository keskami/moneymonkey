// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:money_monkey/Invest/investment_home.dart';
import 'package:money_monkey/PortfolioPages/transfers_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  int? balance;
  int? totalBanans;
  bool isLoading = true;
  String balanceString = '0';
  String totalBananstring = '0';
  Map<String, dynamic>? portfolioData;
  double _changePercentage = 0;
  String _currButton = "All";
  bool isExpanded = false;

  List<Widget> transactionWidgets = [];

  void _updateButton(String buttonText) {
    setState(() {
      _currButton = buttonText;
    });
  }

  Future<List<DocumentSnapshot>> _getTransactions(String type) async {
    CollectionReference transactionsRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('Transactions');

    Query query = transactionsRef;

    if (type == "Income") {
      query = query
          .where('Type', isEqualTo: 'Income')
          .orderBy('Date', descending: true)
          .limit(3);
    } else if (type == "Expenses") {
      query = query
          .where('Type', isEqualTo: 'Expense')
          .orderBy('Date', descending: true)
          .limit(3);
    } else {
      query = query.orderBy('Date', descending: true).limit(3);
    }
    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs;
  }

  void _setTransaction(String type) async {
    List<DocumentSnapshot> transactions = await _getTransactions(type);
    transactionWidgets.clear();
    if (transactions.isEmpty) {
      transactionWidgets.add(
        const Center(child: Text("No transactions found.")),
      );
    } else {
      for (var doc in transactions) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String sourceOrDestination = data['Source/Destination'];
        String amount = data['Amount']?.toString() ?? '0';
        String subtitle = "Paid From $sourceOrDestination";
        String imageUrl = 'assets/images/banana.png';
        String type = data['Type'];
        transactionWidgets.add(
          transactionItem(
            icon:
                type == "Savings" ? Icons.savings_outlined : Icons.trending_up,
            title: type,
            subtitle: subtitle,
            amount: amount,
            imageUrl: imageUrl,
          ),
        );
      }
    }
    setState(() {});
  }

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
    _setTransaction("ALL");
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

            portfolioData = data?['Portfolio'] as Map<String, dynamic>?;

            if (portfolioData != null) {
              balance = portfolioData?['Balance'] ?? 0;
              totalBanans = portfolioData?['Total Bananas'] ?? 0;
              int netGain = portfolioData?['Weekly net gain'] ?? 0;
              int lastWeek = balance! - netGain;
              if (lastWeek != 0) {
                double percentChange = ((balance! - lastWeek) / lastWeek) * 100;
                _changePercentage =
                    double.parse(percentChange.toStringAsFixed(2));
              } else {
                _changePercentage = 0.0;
              }

              totalBananstring =
                  NumberFormat('#,###').format(totalBanans?.toInt() ?? 0);
              balanceString =
                  NumberFormat('#,###').format(balance?.toInt() ?? 0);
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
    double screenWidthUnit = MediaQuery.of(context).size.width / 390;
    double screenHeightUnit = MediaQuery.of(context).size.height / 880;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = false;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeightUnit * 13,
                    child: Text(
                      "Total asset value",
                      style:
                          GoogleFonts.baloo2(fontSize: 13, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: screenHeightUnit * 47,
                    child: Text(
                      '$totalBananstring🍌',
                      style: const TextStyle(
                        fontSize: 36,
                        fontFamily: "FredokaOne",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeightUnit * 18,
                    child: Row(
                      children: [
                        Icon(
                          _changePercentage > 0
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color:
                              _changePercentage > 0 ? Colors.blue : Colors.red,
                        ),
                        Text(
                          '$_changePercentage% ',
                          style: GoogleFonts.baloo2(
                            fontSize: 13,
                            color: _changePercentage > 0
                                ? Colors.blue
                                : Colors.red,
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
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeightUnit * 15,
            ),
            Center(
              child: SizedBox(
                width: screenWidthUnit * 320,
                height: screenHeightUnit * 164,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(135, 206, 235, 1),
                    borderRadius: BorderRadius.circular(10),
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
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "Balance",
                            style: GoogleFonts.baloo2(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, right: 17),
                          child: SizedBox(
                            height: screenHeightUnit * 39,
                            width: screenWidthUnit * 41,
                            child: Image.asset('assets/images/bank.png'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "**** 0149",
                            style: GoogleFonts.baloo2(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "05/25",
                            style: GoogleFonts.baloo2(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Row(
                              children: [
                                Text(
                                  "$balanceString🍌",
                                  style: GoogleFonts.baloo2(
                                      fontSize: 52, color: Colors.white),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeightUnit * 33),
            Center(
              child: SizedBox(
                width: screenWidthUnit * 366,
                height: screenHeightUnit * 300,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(5),
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
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 17, 0, 0),
                          child: Text(
                            "Transactional History",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "FredokaOne",
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 45, 0, 0),
                          child: Text(
                            "A list of historical transactions",
                            style: GoogleFonts.baloo2(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 77, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: screenHeightUnit * 29,
                                width: screenWidthUnit * 69,
                                padding: const EdgeInsets.all(0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _currButton == "All"
                                      ? const Color.fromRGBO(255, 224, 130, 1)
                                      : const Color.fromRGBO(
                                          217, 217, 217, 100),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.lightBlue,
                                    width: _currButton == "All"
                                        ? screenWidthUnit * 2
                                        : screenWidthUnit * 0,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    _updateButton("All");
                                    _setTransaction("ALL");
                                  },
                                  child: Text(
                                    "All",
                                    style: GoogleFonts.baloo2(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: _currButton == "All"
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      height: screenHeightUnit * -.01,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidthUnit * 10),
                              Container(
                                height: screenHeightUnit * 29,
                                width: screenWidthUnit * 89,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _currButton == "Income"
                                      ? const Color.fromRGBO(255, 224, 130, 1)
                                      : const Color.fromRGBO(
                                          217, 217, 217, 100),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.lightBlue,
                                    width: _currButton == "Income"
                                        ? screenWidthUnit * 2
                                        : screenWidthUnit * 0,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    _updateButton("Income");
                                    _setTransaction("Income");
                                  },
                                  child: Text(
                                    "Income",
                                    style: GoogleFonts.baloo2(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: _currButton == "Income"
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      height: screenHeightUnit * -.01,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidthUnit * 10),
                              Container(
                                height: screenHeightUnit * 29,
                                width: screenWidthUnit * 89,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _currButton == "Expenses"
                                      ? const Color.fromRGBO(255, 224, 130, 1)
                                      : const Color.fromRGBO(
                                          217, 217, 217, 100),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.lightBlue,
                                    width: _currButton == "Expenses"
                                        ? screenWidthUnit * 2
                                        : screenWidthUnit * 0,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    _updateButton("Expenses");
                                    _setTransaction("Expenses");
                                  },
                                  child: Text(
                                    "Expenses",
                                    style: GoogleFonts.baloo2(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: _currButton == "Expenses"
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      height: screenHeightUnit * -.01,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 90, 0, 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 29, 0, 0),
                              child: Container(
                                height: screenHeightUnit * 1,
                                width: screenWidthUnit * 332,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, .3),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidthUnit * 332,
                              height: screenHeightUnit * 175,
                              child: Column(
                                children: [
                                  if (transactionWidgets.isNotEmpty) ...[
                                    ...transactionWidgets,
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 1, 0, 0),
                                      child: Container(
                                        height: screenHeightUnit * 1,
                                        width: screenWidthUnit * 332,
                                        decoration: const BoxDecoration(
                                          color: Color.fromRGBO(0, 0, 0, .3),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeightUnit * 3.5,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TransfersScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "View All >",
                                          style:
                                              GoogleFonts.baloo2(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    const Center(
                                      child: Text(
                                        'No Transactions',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
                height: screenHeightUnit * 80,
                width: screenWidthUnit * 500,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: screenWidthUnit * 15,
                    ),
                    Column(
                      children: [
                        SizedBox(height: screenHeightUnit * 20),
                        Text(
                          "Buying Power  >",
                          style: GoogleFonts.baloo2(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidthUnit * 20,
                            ),
                            Text(
                              "$balanceString🍌",
                              style: GoogleFonts.baloo2(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: screenWidthUnit * 30,
                    ),
                  ],
                )),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomBar(context),
      floatingActionButton: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 0),
          width: 191 * screenWidthUnit,
          height: isExpanded ? screenHeightUnit * 105 : screenHeightUnit * 52,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(135, 206, 235, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: isExpanded
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InvestmentHomePage(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(135, 206, 235, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 191 * screenWidthUnit,
                          height: screenHeightUnit * 40,
                          child: Text(
                            'Invest',
                            style: GoogleFonts.fredoka(
                              color: Colors.white,
                              fontSize: 19,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        color: const Color.fromRGBO(135, 206, 235, 1),
                        width: 191 * screenWidthUnit,
                        height: screenHeightUnit * 40,
                        child: Text(
                          'Save',
                          style: GoogleFonts.fredoka(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                )
              : Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Grow  ^',
                    style: GoogleFonts.fredoka(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget transactionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required String imageUrl,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 3, 5, 3),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: 15),
          ),
          SizedBox(width: screenWidth * 0.06),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.baloo2(fontSize: 13, color: Colors.black),
                ),
                Text(subtitle,
                    style: GoogleFonts.baloo2(
                      color: Colors.black,
                      fontSize: 10,
                    )),
              ],
            ),
          ),
          Text(amount,
              style: GoogleFonts.baloo2(
                  fontSize: screenHeight * .0275, fontWeight: FontWeight.w500)),
          SizedBox(width: screenWidth * .03),
          Image.asset(imageUrl, height: screenHeight * .0367),
        ],
      ),
    );
  }
}
