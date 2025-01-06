import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class BudgetSimulatorLanding extends StatefulWidget {
  @override
  _BudgetSimulatorLandingState createState() => _BudgetSimulatorLandingState();
}

class _BudgetSimulatorLandingState extends State<BudgetSimulatorLanding> {
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  bool firstTime = true;
  bool beginner = false;
  bool intermediate = true;
  bool advanced = false;
  bool eventFinished = false;

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

  final List<String> scenarios = [
    'Vacation on a Budget 🔒',
    'Crush the Credit Card Debt',
    'Build an Emergency Fund 🔒',
    'First Apartment: Living on Your Own 🔒',
    'Freelance & Irregular Income 🔒',
  ];

  final List<TyperAnimatedText> animatedTexts = [
    TyperAnimatedText(
      'Hi! Welcome to the Budget Simulator.',
      textStyle: TextStyle(),
      speed: Duration(
          milliseconds: 1000 ~/
              'Hi! Welcome to the Budget Simulator.'
                  .length),
    ),


    TyperAnimatedText(
      'I\’m Minty, your personal guide on this\nadventure.',
      speed: Duration(milliseconds: 2000 ~/ 'I\’m Minty, your personal guide on this adventure'.length),
    ),



    TyperAnimatedText(
      'Here, we\’ll walk through real-life\nbudgeting scenarios, tackle unexpected\nevents, and learn how to manage money\nlike a pro.',
      speed: Duration(
          milliseconds: 5000 ~/ 'Here, we’ll walk through real-life budgeting scenarios, tackle unexpected events, and learn how to manage money like a pro.'.length),
    ),


    TyperAnimatedText(
      'Do not test bugs out, design them out',
      speed: Duration(
          milliseconds: 2000 ~/ 'Do not test bugs out, design them out'.length),
    ),
    
    
  ];
  int animatedTextIndex = 0;

  String? selectedScenario = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double webScreenWidthUnit = screenWidth / 1717;
    double webScreenHeightUnit = screenHeight / 2078;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : firstTime
            ? Scaffold(
                body: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: webScreenHeightUnit * 50,
                        ),
                        Center(
                          child: Text(
                            'Setup',
                            style: GoogleFonts.baloo2(
                              fontSize: webScreenWidthUnit * 35,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: webScreenHeightUnit * 92,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: selectedScenario != ''
                                    ? webScreenWidthUnit * 151
                                    : webScreenWidthUnit * 121,
                              ),
                              Text(
                                'Scenario',
                                style: GoogleFonts.baloo2(
                                  fontSize: webScreenWidthUnit * 35,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: webScreenWidthUnit * 55,
                              ),
                              DropdownMenu(
                                width: webScreenWidthUnit * 543,
                                dropdownMenuEntries: [
                                  for (String scenario in scenarios)
                                    DropdownMenuEntry(
                                      value: scenario,
                                      label: scenario,
                                    )
                                ],
                                textStyle: GoogleFonts.baloo2(
                                    fontSize: webScreenWidthUnit * 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: webScreenHeightUnit * 127,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: selectedScenario == ""
                                    ? webScreenWidthUnit * 121
                                    : webScreenWidthUnit * 151,
                              ),
                              Text(
                                'Level',
                                style: GoogleFonts.baloo2(
                                  fontSize: webScreenWidthUnit * 35,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: webScreenWidthUnit * 106,
                              ),
                              LevelOptions(
                                screenWidthUnit: webScreenWidthUnit,
                                screenHeightUnit: webScreenHeightUnit,
                                level: "Beginner",
                                isSelected: beginner,
                                onTap: () {
                                  setState(() {
                                    if (beginner == false) {
                                      beginner = true;
                                      intermediate = false;
                                      advanced = false;
                                    } else {
                                      beginner = false;
                                    }
                                  });
                                },
                              ),
                              SizedBox(
                                width: webScreenWidthUnit * 81,
                              ),
                              LevelOptions(
                                screenWidthUnit: webScreenWidthUnit,
                                screenHeightUnit: webScreenHeightUnit,
                                level: "Intermediate",
                                isSelected: intermediate,
                                onTap: () {
                                  setState(() {
                                    if (intermediate == false) {
                                      beginner = false;
                                      intermediate = true;
                                      advanced = false;
                                    } else {
                                      intermediate = false;
                                    }
                                  });
                                },
                              ),
                              SizedBox(
                                width: webScreenWidthUnit * 81,
                              ),
                              LevelOptions(
                                screenWidthUnit: webScreenWidthUnit,
                                screenHeightUnit: webScreenHeightUnit,
                                level: "Advanced",
                                isSelected: advanced,
                                onTap: () {
                                  setState(() {
                                    if (advanced == false) {
                                      advanced = true;
                                      intermediate = false;
                                      beginner = false;
                                    } else {
                                      advanced = false;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                webScreenWidthUnit * 1200,
                                selectedScenario == "Crush the Credit Card Debt"
                                    ? webScreenHeightUnit * 88
                                    : 290,
                                0,
                                selectedScenario == ""
                                    ? 0
                                    : webScreenHeightUnit * 60),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: webScreenWidthUnit * 207,
                                height: webScreenHeightUnit * 120,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(79, 195, 247, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text("Confirm",
                                      style: GoogleFonts.baloo2(
                                        fontSize: webScreenWidthUnit * 22,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ))
                      ],
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/images/newMonkeys/Minty.png',
                            height: webScreenWidthUnit * 450,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: webScreenWidthUnit * 160,
                                  height: webScreenHeightUnit * 100,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Color.fromRGBO(79, 195, 247, 1),
                                  ),
                                  child: Center(
                                    child: Text("Minty",
                                        style: GoogleFonts.baloo2(
                                          fontSize: webScreenWidthUnit * 22,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        )),
                                  )),
                              SizedBox(
                                height: webScreenHeightUnit * 20,
                              ),
                              Container(
                                  width: webScreenWidthUnit * 856,
                                  padding: EdgeInsets.fromLTRB(
                                      webScreenWidthUnit * 67,
                                      webScreenHeightUnit * 50,
                                      0,
                                      webScreenWidthUnit * 0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: DefaultTextStyle(
                                          style:  GoogleFonts.baloo2(
                                            fontSize: webScreenWidthUnit * 36,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                           
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AnimatedTextKit(
                                                key: ValueKey<int>(
                                                    animatedTextIndex), // Ensures the widget rebuilds
                                                animatedTexts: [
                                                  animatedTexts[
                                                      animatedTextIndex]
                                                ],
                                                isRepeatingAnimation: false,
                                                onFinished: () {
                                                  setState(() {
                                                    eventFinished = true;
                                                  });
                                                  print("Animation Finished");
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (eventFinished) {
                                              animatedTextIndex++;
                                              eventFinished = false;
                                              if (animatedTextIndex >=
                                                  animatedTexts.length) {
                                                animatedTextIndex =
                                                    0; // Reset to the first text
                                              }
                                            }
                                          });
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(0, 0,
                                                webScreenWidthUnit * 38, 0),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: webScreenWidthUnit * 37,
                                              color: Color.fromRGBO(
                                                  79, 197, 247, 1),
                                            )),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: webScreenHeightUnit * 77,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: webScreenHeightUnit * 50,
                      ),
                      Center(
                        child: Text(
                          'Setup',
                          style: GoogleFonts.baloo2(
                            fontSize: webScreenWidthUnit * 35,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: webScreenHeightUnit * 92,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: selectedScenario != ''
                                  ? webScreenWidthUnit * 151
                                  : webScreenWidthUnit * 121,
                            ),
                            Text(
                              'Scenario',
                              style: GoogleFonts.baloo2(
                                fontSize: webScreenWidthUnit * 35,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: webScreenWidthUnit * 55,
                            ),
                            DropdownMenu(
                              width: webScreenWidthUnit * 543,
                              dropdownMenuEntries: [
                                for (String scenario in scenarios)
                                  DropdownMenuEntry(
                                    value: scenario,
                                    label: scenario,
                                  )
                              ],
                              textStyle: GoogleFonts.baloo2(
                                  fontSize: webScreenWidthUnit * 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              onSelected: (value) {
                                setState(() {
                                  if (value == 'Crush the Credit Card Debt') {
                                    selectedScenario = value as String?;
                                    print(selectedScenario);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        WrongAnswerSnackBar(
                                            message:
                                                "Please select 'Crush the Credit Card Debt'"));
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      selectedScenario == 'Crush the Credit Card Debt'
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: webScreenHeightUnit * 2010,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      webScreenWidthUnit * 151, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: webScreenHeightUnit * 58,
                                      ),
                                      Text(
                                        "You have a \$3,000 credit card balance with a 19.99% APR, and it\’s becoming a real\nfinancial burden. Despite your everyday living costs, you\’re determined to\naggressively pay down this debt. You\’ll face unexpected events along the way, but\nthe ultimate goal is to cut that \$3,000 down by at least 50% within 3 months.",
                                        style: GoogleFonts.baloo2(
                                          fontSize: webScreenWidthUnit * 31,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          wordSpacing: webScreenWidthUnit * 10,
                                          height: webScreenHeightUnit * 3.75,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: webScreenHeightUnit * 73,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            children: [
                                              Text("Monthly Income",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: webScreenWidthUnit * 42,
                                          ),
                                          Text("\$2,500",
                                              style: GoogleFonts.baloo2(
                                                fontSize:
                                                    webScreenWidthUnit * 33,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    30, 213, 58, 1),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: webScreenHeightUnit * 61,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("Expenses",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                              SizedBox(
                                                height:
                                                    webScreenHeightUnit * 134,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: webScreenWidthUnit * 79,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Rent",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                              SizedBox(
                                                height:
                                                    webScreenHeightUnit * 11,
                                              ),
                                              Text("\$800",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        243, 52, 52, 1),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: webScreenWidthUnit * 92,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Utilities",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                              SizedBox(
                                                height:
                                                    webScreenHeightUnit * 11,
                                              ),
                                              Text("\$150",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        243, 52, 52, 1),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: webScreenWidthUnit * 67,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Groceries",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                              SizedBox(
                                                height:
                                                    webScreenHeightUnit * 11,
                                              ),
                                              Text("\$250",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        243, 52, 52, 1),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: webScreenWidthUnit * 62,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Transportation",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                              SizedBox(
                                                height:
                                                    webScreenHeightUnit * 11,
                                              ),
                                              Text("\$120",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        243, 52, 52, 1),
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: webScreenHeightUnit * 21,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: webScreenWidthUnit * 219,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Credit Card Minimum Payment",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                              SizedBox(
                                                height:
                                                    webScreenHeightUnit * 11,
                                              ),
                                              Text("\$200",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        243, 52, 52, 1),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: webScreenWidthUnit * 67,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Entertainment",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                              SizedBox(
                                                height:
                                                    webScreenHeightUnit * 11,
                                              ),
                                              Text("\$80",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        243, 52, 52, 1),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("Milestones",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: webScreenWidthUnit * 56.5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/budgetSim/blueSquare.png',
                                                height:
                                                    webScreenHeightUnit * 80,
                                              ),
                                              SizedBox(
                                                width: webScreenWidthUnit * 10,
                                              ),
                                              Text("Debt Avalanche Start",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: webScreenWidthUnit * 49,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/budgetSim/blueSquare.png',
                                                height:
                                                    webScreenHeightUnit * 80,
                                              ),
                                              SizedBox(
                                                width: webScreenWidthUnit * 10,
                                              ),
                                              Text("Two Weeks Under Budget",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: webScreenWidthUnit * 67,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: webScreenHeightUnit * 21,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: webScreenWidthUnit * 219,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/budgetSim/blueSquare.png',
                                                height:
                                                    webScreenHeightUnit * 80,
                                              ),
                                              SizedBox(
                                                width: webScreenWidthUnit * 10,
                                              ),
                                              Text(
                                                  "Credit Card Minimum Payment",
                                                  style: GoogleFonts.baloo2(
                                                    fontSize:
                                                        webScreenWidthUnit * 33,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: webScreenWidthUnit * 67,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: webScreenHeightUnit * 100,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text("Goal",
                                                        style:
                                                            GoogleFonts.baloo2(
                                                          fontSize:
                                                              webScreenWidthUnit *
                                                                  33,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                        )),
                                                    SizedBox(
                                                      height:
                                                          webScreenHeightUnit *
                                                              126,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width:
                                                      webScreenWidthUnit * 150,
                                                ),
                                                Text(
                                                    "50% (or more) of the original credit card balance paid off by\nthe end of Month 3",
                                                    style: GoogleFonts.baloo2(
                                                      fontSize:
                                                          webScreenWidthUnit *
                                                              33,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    )),
                                              ],
                                            ),
                                          ]),
                                      SizedBox(
                                        height: webScreenHeightUnit * 120,
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          : SizedBox(
                              height: webScreenHeightUnit * 127,
                            ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: selectedScenario == ""
                                  ? webScreenWidthUnit * 121
                                  : webScreenWidthUnit * 151,
                            ),
                            Text(
                              'Level',
                              style: GoogleFonts.baloo2(
                                fontSize: webScreenWidthUnit * 35,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: webScreenWidthUnit * 106,
                            ),
                            LevelOptions(
                              screenWidthUnit: webScreenWidthUnit,
                              screenHeightUnit: webScreenHeightUnit,
                              level: "Beginner",
                              isSelected: beginner,
                              onTap: () {
                                setState(() {
                                  if (beginner == false) {
                                    beginner = true;
                                    intermediate = false;
                                    advanced = false;
                                  } else {
                                    beginner = false;
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              width: webScreenWidthUnit * 81,
                            ),
                            LevelOptions(
                              screenWidthUnit: webScreenWidthUnit,
                              screenHeightUnit: webScreenHeightUnit,
                              level: "Intermediate",
                              isSelected: intermediate,
                              onTap: () {
                                setState(() {
                                  if (intermediate == false) {
                                    beginner = false;
                                    intermediate = true;
                                    advanced = false;
                                  } else {
                                    intermediate = false;
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              width: webScreenWidthUnit * 81,
                            ),
                            LevelOptions(
                              screenWidthUnit: webScreenWidthUnit,
                              screenHeightUnit: webScreenHeightUnit,
                              level: "Advanced",
                              isSelected: advanced,
                              onTap: () {
                                setState(() {
                                  if (advanced == false) {
                                    advanced = true;
                                    intermediate = false;
                                    beginner = false;
                                  } else {
                                    advanced = false;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(
                              webScreenWidthUnit * 1200,
                              selectedScenario == "Crush the Credit Card Debt"
                                  ? webScreenHeightUnit * 88
                                  : 290,
                              0,
                              selectedScenario == ""
                                  ? 0
                                  : webScreenHeightUnit * 60),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: webScreenWidthUnit * 207,
                              height: webScreenHeightUnit * 120,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(79, 195, 247, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text("Confirm",
                                    style: GoogleFonts.baloo2(
                                      fontSize: webScreenWidthUnit * 22,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ))
                    ],
                  ),
                ));
  }
}

Widget LevelOptions({
  required double screenWidthUnit,
  required double screenHeightUnit,
  required String level,
  required bool isSelected,
  required Function() onTap,
}) {
  return GestureDetector(
      onTap: onTap,
      child: isSelected
          ? Container(
              width: screenWidthUnit * 359,
              height: screenHeightUnit * 185,
              decoration: BoxDecoration(
                color: Color.fromRGBO(79, 195, 247, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  level,
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 35,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Container(
              width: screenWidthUnit * 359,
              height: screenHeightUnit * 185,
              decoration: BoxDecoration(
                color: Color.fromRGBO(197, 197, 197, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  level,
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 35,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(127, 127, 127, 1),
                  ),
                ),
              ),
            ));
}
