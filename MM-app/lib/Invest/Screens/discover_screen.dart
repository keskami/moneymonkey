import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Services/stock_service.dart';
import 'package:money_monkey/Invest/Accessory%20Pages/investment_details.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  String? name = '';
  int? _balance = 0;

  int? _totalInvestedBonds = 0;
  int? _totalProfitBonds = 0;

  int? _totalInvestedETFs = 0;
  int? _totalProfitETFs = 0;

  int? _totalInvestedMutralFunds = 0;
  int? _totalProfitMutralFunds = 0;

  int? _totalInvestedStocks = 0;
  int? _totalProfitStocks = 0;

  List<Map<String, dynamic>> investmentData = [];

  int monthyAmount = 0;
  bool loading = true;

  TextEditingController _askHereText = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializePortfolio();
  }

  Future<void> _initializePortfolio() async {
    DocumentSnapshot profileSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(userID).get();

    if (profileSnapshot.exists) {
      var pageData = profileSnapshot['Invest Page (Discover)'];
      setState(() {
        name = pageData['Username'];
        _balance = pageData['Total invested Bananas'];
        monthyAmount = pageData['Profit from Invested Bananas (Current Month)'];
        _totalInvestedBonds = pageData['Total Invested (Bonds)'];
        _totalProfitBonds = pageData['Total Profit (Bonds)'];

        _totalInvestedStocks = pageData['Total Invested (Stocks)'];
        _totalProfitStocks = pageData['Total Profit (Stocks)'];

        _totalInvestedETFs = pageData['Total Invested (ETFs)'];
        _totalProfitETFs = pageData['Total Profit (ETFs)'];

        _totalInvestedMutralFunds = pageData['Total Invested (Mutual Funds)'];
        _totalProfitMutralFunds = pageData['Total Profit (Mutual Funds)'];

        investmentData = [
          {
            'title': 'Stocks',
            'value': _totalInvestedStocks,
            'change': _totalProfitStocks,
            'icon': Icons.show_chart,
          },
          {
            'title': 'ETFs',
            'value': _totalInvestedETFs,
            'change': _totalProfitETFs,
            'icon': Icons.pie_chart,
          },
          {
            'title': 'Mutual Funds',
            'value': _totalInvestedMutralFunds,
            'change': _totalProfitMutralFunds,
            'icon': Icons.assessment,
          },
          {
            'title': 'Bonds',
            'value': _totalInvestedBonds,
            'change': _totalProfitBonds,
            'icon': Icons.business,
          },
        ];
      });

      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;

    return screenWidth > screenHeight
        ? Scaffold(
            backgroundColor: const Color.fromRGBO(137, 220, 142, 1),
            body: loading
                ? Container(
                    color: const Color.fromRGBO(137, 220, 142, 1),
                  )
                : Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeightUnit * 40),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                screenWidthUnit * 10, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: screenWidthUnit * 20),
                                    Text(
                                      "Welcome Back $name 👋",
                                      style: GoogleFonts.baloo2(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: screenWidthUnit * 20),
                                    Text(
                                      '🍌$_balance',
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
                                            size: screenHeightUnit * 17,
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
                                      screenWidthUnit * 20,
                                      screenHeightUnit * 5,
                                      0,
                                      0),
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
                          height: screenHeightUnit * 700,
                          width: screenWidthUnit * 390,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(241, 244, 248, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeightUnit * 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildInvestmentCardWeb(
                                    investmentData[0],
                                    screenWidthUnit,
                                    screenHeightUnit * 1.1,
                                    20,
                                    context,
                                  ),
                                  _buildInvestmentCardWeb(
                                    investmentData[1],
                                    screenWidthUnit,
                                    screenHeightUnit * 1.1,
                                    20,
                                    context,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeightUnit * 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildInvestmentCardWeb(
                                    investmentData[2],
                                    screenWidthUnit,
                                    screenHeightUnit * 1.1,
                                    18,
                                    context,
                                  ),
                                  _buildInvestmentCardWeb(
                                    investmentData[3],
                                    screenWidthUnit,
                                    screenHeightUnit * 1.1,
                                    20,
                                    context,
                                  ),
                                ],
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        25 * screenWidthUnit,
                                        10 * screenHeightUnit,
                                        0,
                                        0),
                                    child: Text(
                                      "Find Your Next Trade",
                                      style: GoogleFonts.baloo2(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        25 * screenWidthUnit,
                                        7 * screenHeightUnit,
                                        0,
                                        0),
                                    child: Text(
                                      "Ask Money Monkey",
                                      style: GoogleFonts.baloo2(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                              SizedBox(height: 10 * screenHeightUnit),
                              Center(
                                child: Container(
                                  height: 260 * screenHeightUnit,
                                  width: 340 * screenWidthUnit,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/monkeyNoText.png',
                                        height: 140 * screenHeightUnit,
                                        width: 120 * screenHeightUnit,
                                      ),
                                      SizedBox(
                                        height: screenHeightUnit * 9,
                                      ),
                                      Container(
                                        height: 100 * screenHeightUnit,
                                        width: 303 * screenWidthUnit,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              241, 244, 248, 1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: TextField(
                                          controller: _askHereText,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.baloo2(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Ask here...',
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                15 * screenWidthUnit,
                                                30 * screenHeightUnit,
                                                0,
                                                0),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        : Scaffold(
            backgroundColor: const Color.fromRGBO(137, 220, 142, 1),
            body: loading
                ? Container(
                    color: const Color.fromRGBO(137, 220, 142, 1),
                  )
                : Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeightUnit * 40),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                screenWidthUnit * 10, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: screenWidthUnit * 20),
                                    Text(
                                      "Welcome Back $name 👋",
                                      style: GoogleFonts.baloo2(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: screenWidthUnit * 20),
                                    Text(
                                      '🍌$_balance',
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
                                            size: screenHeightUnit * 17,
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
                                      screenWidthUnit * 20,
                                      screenHeightUnit * 5,
                                      0,
                                      0),
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
                        bottom: screenHeightUnit * -50,
                        child: Container(
                          height: screenHeightUnit * 650,
                          width: screenWidthUnit * 390,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(241, 244, 248, 1),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeightUnit * 22,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildInvestmentCard(
                                    investmentData[0],
                                    screenWidthUnit,
                                    screenHeightUnit * 1.1,
                                    20,
                                    context,
                                  ),
                                  _buildInvestmentCard(
                                    investmentData[1],
                                    screenWidthUnit,
                                    screenHeightUnit * 1.1,
                                    20,
                                    context,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeightUnit * 19,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildInvestmentCard(
                                    investmentData[2],
                                    screenWidthUnit,
                                    screenHeightUnit * 1.1,
                                    18,
                                    context,
                                  ),
                                  _buildInvestmentCard(
                                    investmentData[3],
                                    screenWidthUnit,
                                    screenHeightUnit * 1.1,
                                    20,
                                    context,
                                  ),
                                ],
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        25 * screenWidthUnit,
                                        25 * screenHeightUnit,
                                        0,
                                        0),
                                    child: Text(
                                      "Find Your Next Trade",
                                      style: GoogleFonts.baloo2(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        25 * screenWidthUnit,
                                        5 * screenHeightUnit,
                                        0,
                                        0),
                                    child: Text(
                                      "Ask Money Monkey",
                                      style: GoogleFonts.baloo2(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                              SizedBox(height: 6 * screenHeightUnit),
                              Center(
                                child: Container(
                                  height: 240 * screenHeightUnit,
                                  width: 340 * screenWidthUnit,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/monkeyNoText.png',
                                        height: 129 * screenHeightUnit,
                                        width: 129 * screenHeightUnit,
                                      ),
                                      SizedBox(
                                        height: screenHeightUnit * 9,
                                      ),
                                      Container(
                                        height: 100 * screenHeightUnit,
                                        width: 303 * screenWidthUnit,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              241, 244, 248, 1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: TextField(
                                          controller: _askHereText,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.baloo2(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Ask here...',
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                15 * screenWidthUnit,
                                                30 * screenHeightUnit,
                                                0,
                                                0),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
  }
}

Widget _buildInvestmentCard(Map<String, dynamic> data, double screenWidthUnit,
    double screenHeightUnit, double fontSize, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (data['title'] == 'Stocks') {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InvestmentDetailsScreen(
              investmentType: 'Stocks',
              investmentService: StockService(),
              defaultSymbol: 'AAPL'),
        ));
      }
      if (data['title'] == 'ETFs') {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InvestmentDetailsScreen(
              investmentType: 'ETFs',
              investmentService: StockService(),
              defaultSymbol: 'SPY'),
        ));
      }
    },
    child: Container(
      height: screenHeightUnit * 90,
      width: screenWidthUnit * 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  data['change']! > 0
                      ? const Icon(
                          Icons.arrow_upward_sharp,
                          color: Colors.green,
                        )
                      : const Icon(
                          color: Colors.red, Icons.arrow_downward_sharp),
                  Text(
                    '🍌${data['change']}',
                    style: GoogleFonts.baloo2(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: data['change']! > 0 ? Colors.green : Colors.red),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget _buildInvestmentCardWeb(Map<String, dynamic> data, double screenWidthUnit,
    double screenHeightUnit, double fontSize, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (data['title'] == 'Stocks') {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InvestmentDetailsScreen(
              investmentType: 'Stocks',
              investmentService: StockService(),
              defaultSymbol: 'AAPL'),
        ));
      }
      if (data['title'] == 'ETFs') {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InvestmentDetailsScreen(
              investmentType: 'ETFs',
              investmentService: StockService(),
              defaultSymbol: 'SPY'),
        ));
      }
    },
    child: Container(
      height: screenHeightUnit * 120,
      width: screenWidthUnit * 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                size: screenWidthUnit * 7,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  data['change']! > 0
                      ? const Icon(
                          Icons.arrow_upward_sharp,
                          color: Colors.green,
                        )
                      : const Icon(
                          color: Colors.red, Icons.arrow_downward_sharp),
                  Text(
                    '🍌${data['change']}',
                    style: GoogleFonts.baloo2(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: data['change']! > 0 ? Colors.green : Colors.red),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}
