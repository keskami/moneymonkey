// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
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
        if (kIsWeb) {
          transactionWidgets.add(
            webTransactionItem(
              icon: type == "Savings"
                  ? Icons.savings_outlined
                  : Icons.trending_up,
              title: type,
              subtitle: subtitle,
              amount: amount,
              imageUrl: imageUrl,
            ),
          );
        } else {
          transactionWidgets.add(
            transactionItem(
              icon: type == "Savings"
                  ? Icons.savings_outlined
                  : Icons.trending_up,
              title: type,
              subtitle: subtitle,
              amount: amount,
              imageUrl: imageUrl,
            ),
          );
        }
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
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double offset = scaffoldGeometry.minInsets.bottom;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    return Offset(
        scaffoldGeometry.scaffoldSize.width / 2 -
            scaffoldGeometry.floatingActionButtonSize.width / 2,
        scaffoldGeometry.scaffoldSize.height -
            fabHeight -
            offset -
            50 // 20 pixels up
        );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;

    return screenWidth > screenHeight
        ? Scaffold(
            body: MouseRegion(
              onEnter: (PointerEvent event) {
                setState(() {
                  isExpanded = false;
                });
              },
              child: Row(children: [
                SizedBox(width: screenWidthUnit * 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(screenWidthUnit * 1.75, 10, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total asset value",
                            style: GoogleFonts.baloo2(
                                fontSize: screenHeightUnit * 15,
                                color: Colors.black),
                          ),
                          Row(children: [
                            Text(
                              '$totalBananstring',
                              style: TextStyle(
                                fontSize: 40 * screenHeightUnit,
                                fontFamily: "FredokaOne",
                              ),
                            ),
                            Image.asset('assets/images/banana.png',
                                height: screenHeightUnit * 40),
                          ]),
                          Row(
                            children: [
                              Icon(
                                _changePercentage > 0
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: _changePercentage > 0
                                    ? Colors.blue
                                    : Colors.red,
                              ),
                              Text(
                                '$_changePercentage% ',
                                style: GoogleFonts.baloo2(
                                  fontSize: 15 * screenHeightUnit,
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeightUnit * 22,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          start: screenWidthUnit * 10,
                          end: screenWidthUnit * 10),
                      child: SizedBox(
                        width: screenWidthUnit * 100,
                        height: screenHeightUnit * 200,
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
                                  padding:
                                      EdgeInsets.all(screenHeightUnit * 20),
                                  child: Text(
                                    "Balance",
                                    style: GoogleFonts.baloo2(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              //Align(
                              //alignment: Alignment.topRight,
                              //child: Container(
                              //padding:
                              //  EdgeInsets.only(top: screenHeightUnit * 10),
                              //child: SizedBox(
                              //height: screenHeightUnit * 30,
                              //width: screenWidthUnit * 31,
                              //child: Image.asset('assets/images/bank.png'),
                              //),
                              // ),
                              //),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(screenHeightUnit * 20),
                                  child: Text(
                                    "**** 0149",
                                    style: GoogleFonts.baloo2(
                                      color: Colors.white,
                                      fontSize: screenHeightUnit * 16,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(screenHeightUnit * 20),
                                  child: Text(
                                    "05/25",
                                    style: GoogleFonts.baloo2(
                                        fontSize: screenHeightUnit * 20,
                                        color: Colors.white),
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
                                          "$balanceString",
                                          style: GoogleFonts.baloo2(
                                              fontSize: screenHeightUnit * 46,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: screenWidthUnit * 2,
                                        ),
                                        Image.asset('assets/images/banana.png',
                                            height: screenHeightUnit * 42),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeightUnit * 47),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(screenWidthUnit * 4.5, 0, 0, 0),
                      child: SizedBox(
                        width: screenWidthUnit * 112,
                        height: screenHeightUnit * 347,
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
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 45, 0, 0),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(13, 77, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _updateButton("All");
                                          _setTransaction("ALL");
                                        },
                                        child: Container(
                                          height: screenHeightUnit * 29,
                                          width: screenWidthUnit * 29,
                                          padding: const EdgeInsets.all(0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: _currButton == "All"
                                                ? const Color.fromRGBO(
                                                    255, 224, 130, 1)
                                                : const Color.fromRGBO(
                                                    217, 217, 217, 100),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.lightBlue,
                                              width: _currButton == "All"
                                                  ? screenWidthUnit * .5
                                                  : screenWidthUnit * 0,
                                            ),
                                          ),
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
                                      SizedBox(width: screenWidthUnit * 5),
                                      GestureDetector(
                                        onTap: () {
                                          _updateButton("Income");
                                          _setTransaction("Income");
                                        },
                                        child: Container(
                                          height: screenHeightUnit * 29,
                                          width: screenWidthUnit * 29,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: _currButton == "Income"
                                                ? const Color.fromRGBO(
                                                    255, 224, 130, 1)
                                                : const Color.fromRGBO(
                                                    217, 217, 217, 100),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.lightBlue,
                                              width: _currButton == "Income"
                                                  ? screenWidthUnit * .5
                                                  : screenWidthUnit * 0,
                                            ),
                                          ),
                                          child: Text(
                                            "Income",
                                            style: GoogleFonts.baloo2(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight:
                                                  _currButton == "Income"
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              height: screenHeightUnit * -.01,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: screenWidthUnit * 5),
                                      GestureDetector(
                                        onTap: () {
                                          _updateButton("Expenses");
                                          _setTransaction("Expenses");
                                        },
                                        child: Container(
                                          height: screenHeightUnit * 29,
                                          width: screenWidthUnit * 29,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: _currButton == "Expenses"
                                                ? const Color.fromRGBO(
                                                    255, 224, 130, 1)
                                                : const Color.fromRGBO(
                                                    217, 217, 217, 100),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.lightBlue,
                                              width: _currButton == "Expenses"
                                                  ? screenWidthUnit * .5
                                                  : screenWidthUnit * 0,
                                            ),
                                          ),
                                          child: Text(
                                            "Expenses",
                                            style: GoogleFonts.baloo2(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight:
                                                  _currButton == "Expenses"
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
                                padding:
                                    const EdgeInsets.fromLTRB(20, 90, 0, 0),
                                child: Column(
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 28, 0, 0),
                                        child: Container(
                                          height: screenHeightUnit * 1,
                                          width: screenWidthUnit * 332,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(0, 0, 0, .3),
                                          ),
                                        )),
                                    SizedBox(
                                      width: screenWidthUnit * 332,
                                      height: screenHeightUnit * 175,
                                      child: Column(
                                        children: [
                                          if (transactionWidgets
                                              .isNotEmpty) ...[
                                            ...transactionWidgets,
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 1, 0, 0),
                                              child: Container(
                                                height: screenHeightUnit * 1,
                                                width: screenWidthUnit * 332,
                                                decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, .3),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeightUnit * 3.5,
                                            ),
                                          ] else ...[
                                            const Center(
                                              child: Text(
                                                'No Transactions',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TransfersScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "View All >",
                                    style: GoogleFonts.baloo2(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                        height: screenHeightUnit * 100,
                        width: screenWidthUnit * 150,
                        //color: Colors.white,
                        child: Row(
                          children: [
                            SizedBox(
                              width: screenWidthUnit * 6,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "$balanceString",
                                          style: GoogleFonts.baloo2(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: screenWidthUnit * 1),
                                        Image.asset('assets/images/banana.png',
                                            height: screenHeightUnit * 20),
                                      ],
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
                SizedBox(
                  width: screenWidthUnit * 10,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: screenHeightUnit * 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/monkeyNoText.png',
                          height: screenHeightUnit * 49,
                        ),
                        SizedBox(
                          width: screenWidthUnit * 12,
                        ),
                        Image.asset(
                          'assets/images/img_monkeymoney_50.png',
                          height: screenHeightUnit * 53,
                        ),
                        SizedBox(
                          width: screenWidthUnit * 2,
                        ),
                        Text(
                          "3",
                          style: GoogleFonts.baloo2(
                            fontSize: screenWidthUnit * 9,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: screenWidthUnit * 8,
                        ),
                        Image.asset(
                          'assets/images/img_monkeymoney_51.png',
                          height: screenHeightUnit * 49,
                        ),
                        SizedBox(
                          width: screenWidthUnit * 2,
                        ),
                        Text(
                          "3",
                          style: GoogleFonts.baloo2(
                            fontSize: screenWidthUnit * 9,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: screenWidthUnit * 8,
                        ),
                        Image.asset(
                          'assets/images/img_monkeymoney_52.png',
                          height: screenHeightUnit * 49,
                        ),
                        SizedBox(
                          width: screenWidthUnit * 2,
                        ),
                        Text(
                          "3",
                          style: GoogleFonts.baloo2(
                            fontSize: screenWidthUnit * 9,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeightUnit * 46,
                    ),
                    SizedBox(
                        width: screenWidthUnit * 100,
                        height: screenHeightUnit * 340,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: .5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeightUnit * 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidthUnit * 7),
                                      child: Text("Daily Quests",
                                          style: GoogleFonts.baloo2(
                                            fontSize: screenWidthUnit * 5.5,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ))),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidthUnit * 7),
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text("View All >",
                                            style: GoogleFonts.baloo2(
                                              fontSize: screenWidthUnit * 4.75,
                                              color: Color.fromRGBO(
                                                  79, 195, 247, 1),
                                              fontWeight: FontWeight.w500,
                                            ))),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: screenHeightUnit * 10,
                              ),
                              dailyQuest(
                                  title: "Complete 3 units",
                                  outOf: 3,
                                  completed: 1,
                                  screenWidthUnit: screenWidthUnit,
                                  screenHeightUnit: screenHeightUnit),
                              SizedBox(
                                height: screenHeightUnit * 20,
                              ),
                              dailyQuest(
                                  title: "Score 80% or higher in 2\nlessons",
                                  outOf: 2,
                                  completed: 1,
                                  screenWidthUnit: screenWidthUnit,
                                  screenHeightUnit: screenHeightUnit)
                            ],
                          ),
                        ))
                  ],
                )
              ]),
            ),
            floatingActionButtonLocation: CustomFabLocation(),
            floatingActionButtonAnimator: NoScalingAnimation(),
            floatingActionButton: MouseRegion(
              onEnter: (PointerEvent event) {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                width: 50 * screenWidthUnit,
                height:
                    isExpanded ? screenHeightUnit * 70 : screenHeightUnit * 42,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(135, 206, 235, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: isExpanded
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                width: 51 * screenWidthUnit,
                                height: screenHeightUnit * 24,
                                child: Text(
                                  'Invest',
                                  style: GoogleFonts.fredoka(
                                    color: Colors.white,
                                    fontSize: 16,
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
                              width: 51 * screenWidthUnit,
                              height: screenHeightUnit * 24,
                              child: Text(
                                'Save',
                                style: GoogleFonts.fredoka(
                                  color: Colors.white,
                                  fontSize: 16,
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
                          'Invest',
                          style: GoogleFonts.fredoka(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
              ),
            ),
          )
        : Scaffold(
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
                            style: GoogleFonts.baloo2(
                                fontSize: 13, color: Colors.black),
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
                                color: _changePercentage > 0
                                    ? Colors.blue
                                    : Colors.red,
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
                                padding:
                                    const EdgeInsets.only(top: 15, right: 17),
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
                                padding:
                                    const EdgeInsets.fromLTRB(15, 45, 0, 0),
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
                                padding:
                                    const EdgeInsets.fromLTRB(13, 77, 0, 0),
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
                                            ? const Color.fromRGBO(
                                                255, 224, 130, 1)
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
                                            ? const Color.fromRGBO(
                                                255, 224, 130, 1)
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
                                            ? const Color.fromRGBO(
                                                255, 224, 130, 1)
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
                                            fontWeight:
                                                _currButton == "Expenses"
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 29, 0, 0),
                                      child: Container(
                                        height: screenHeightUnit * 1,
                                        width: screenWidthUnit * 332,
                                        decoration: const BoxDecoration(
                                          color: Color.fromRGBO(0, 0, 0, .3),
                                        ),
                                      )),
                                  SizedBox(
                                    width: screenWidthUnit * 332,
                                    height: screenHeightUnit * 175,
                                    child: Column(
                                      children: [
                                        if (transactionWidgets.isNotEmpty) ...[
                                          ...transactionWidgets,
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 1, 0, 0),
                                            child: Container(
                                              height: screenHeightUnit * 1,
                                              width: screenWidthUnit * 332,
                                              decoration: const BoxDecoration(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, .3),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeightUnit * 3.5,
                                          ),
                                        ] else ...[
                                          const Center(
                                            child: Text(
                                              'No Transactions',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TransfersScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "View All >",
                                  style: GoogleFonts.baloo2(fontSize: 18),
                                ),
                              ),
                            ),
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
            floatingActionButton: GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                width: 191 * screenWidthUnit,
                height:
                    isExpanded ? screenHeightUnit * 105 : screenHeightUnit * 52,
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

  Widget webTransactionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required String imageUrl,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 3, 5, screenHeight * .008),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: screenWidth * .009),
          ),
          SizedBox(width: screenWidth * 0.008),
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
                  fontSize: screenHeight * .0272, fontWeight: FontWeight.w500)),
          SizedBox(width: screenWidth * .01),
          Image.asset(imageUrl, height: screenHeight * .0367),
          SizedBox(width: screenWidth * 0.006),
        ],
      ),
    );
  }
}

Widget dailyQuest({
  required String title,
  required int outOf,
  required int completed,
  required double screenWidthUnit,
  required double screenHeightUnit,
}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(screenWidthUnit * 7, 0, 0, 0),
    child: Row(
      children: [
        Column(
          children: [
            SizedBox(height: screenHeightUnit * 10),
            Image.asset(
              "assets/images/img_monkeymoney_51.png",
              height: screenHeightUnit * 72,
            ),
          ],
        ),
        SizedBox(width: screenWidthUnit * 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 3.8,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenHeightUnit * 2),
              Container(
                height: screenHeightUnit * 25,
                width: screenWidthUnit * 62,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(135, 206, 235, 1),
                      Color.fromRGBO(213, 213, 213, 1),
                    ],
                    stops: [
                      completed / outOf,
                      completed / outOf,
                    ],
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
                child: Center(
                  child: Text(
                    "$completed/$outOf",
                    style: GoogleFonts.baloo2(
                      fontSize: screenWidthUnit * 3.5,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

class CustomFabLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final Offset offset =
        FloatingActionButtonLocation.centerDocked.getOffset(scaffoldGeometry);
    return Offset(offset.dx - 50, offset.dy - 20);
  }
}

class NoScalingAnimation extends FloatingActionButtonAnimator {
  const NoScalingAnimation();

  @override
  Offset getOffset(
      {required Offset begin, required Offset end, required double progress}) {
    return end;
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }
}
