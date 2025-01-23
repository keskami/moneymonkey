import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:money_monkey/home.dart';

class BudgetSimulatorLanding extends StatefulWidget {
  @override
  _BudgetSimulatorLandingState createState() => _BudgetSimulatorLandingState();
}

class _BudgetSimulatorLandingState extends State<BudgetSimulatorLanding> {
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = false;
  int? balance;
  int totalBanans = 0;
  bool firstTime = true;
  bool beginner = false;
  bool intermediate = false;
  bool advanced = false;
  bool eventFinished = false;
  bool showSecondText = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(133, 220, 64, 1),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    //_fetchUserProfile();
  }

  // Future<void> _fetchUserProfile() async {
  //   if (userID != null) {
  //     try {
  //       DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
  //           .collection('Users')
  //           .doc(userID)
  //           .get();

  //       if (profileSnapshot.exists) {
  //         setState(() {
  //           final data = profileSnapshot.data() as Map<String, dynamic>?;

  //           var portfolioData = data?['Portfolio'] as Map<String, dynamic>?;

  //           if (portfolioData != null) {
  //             balance = portfolioData['Balance'] ?? 0;
  //             totalBanans = portfolioData['Total Bananas'] ?? 0;
  //           }

  //           isLoading = false;
  //         });
  //       } else {
  //         setState(() {
  //           isLoading = false;
  //         });
  //       }
  //     } catch (e) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   }
  // }

  final List<String> scenarios = [
    'Vacation on a Budget 🔒',
    'Crush the Credit Card Debt',
    'Build an Emergency Fund 🔒',
    'First Apartment: Living on Your Own 🔒',
    'Freelance & Irregular Income 🔒',
  ];

  final List<TyperAnimatedText> animatedTexts = [
    TyperAnimatedText(
      'Hi! Welcome to the ',
      speed: Duration(milliseconds: 1000 ~/ 'Hi! Welcome to the'.length),
    ),
    TyperAnimatedText(
      'I\’m Minty, your personal guide on this\nadventure.',
      speed: Duration(
          milliseconds: 2000 ~/
              'I\’m Minty, your personal guide on this adventure'.length),
    ),
    TyperAnimatedText(
      'Here, we\’ll walk through real-life\nbudgeting scenarios, tackle unexpected\nevents, and learn how to manage money\nlike a pro.',
      speed: Duration(
          milliseconds: 5000 ~/
              'Here, we’ll walk through real-life budgeting scenarios, tackle unexpected events, and learn how to manage money like a pro.'
                  .length),
    ),
    TyperAnimatedText(
      'Think of me as your friendly companion\n—ready to cheer you on at every step!',
      speed: Duration(
          milliseconds: 2500 ~/
              'Think of me as your friendly companion\n—ready to cheer you on at every step!'
                  .length),
    ),
    TyperAnimatedText(
      'This simulator will challenge you to\nbalance your everyday expenses with\nlarger financial goals.',
      speed: Duration(
          milliseconds: 3300 ~/
              'This simulator will challenge you to\nbalance your everyday expenses with\nlarger financial goals.'
                  .length),
    ),
    TyperAnimatedText(
      'Don\’t worry—I\’ll provide hints along the\nway. By the end, you\’ll see how small\nchanges can make a big difference in\nyour finances!',
      speed: Duration(
          milliseconds: 5000 ~/
              'Don\’t worry—I\’ll provide hints along the\nway. By the end, you\’ll see how small\nchanges can make a big difference in\nyour finances!'
                  .length),
    ),
    TyperAnimatedText(
      'Ok, let’s get set up!',
      speed: Duration(milliseconds: 1500 ~/ 'Ok, let’s get set up!'.length),
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
                                width: selectedScenario !=
                                            "Crush the Credit Card Debt" &&
                                        intermediate
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
                                width: selectedScenario ==
                                            "Crush the Credit Card Debt" &&
                                        intermediate
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
                                selectedScenario ==
                                            "Crush the Credit Card Debt" &&
                                        intermediate
                                    ? webScreenHeightUnit * 88
                                    : 290,
                                0,
                                selectedScenario ==
                                            "Crush the Credit Card Debt" &&
                                        intermediate
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
                          SizedBox(
                            height: webScreenWidthUnit * 450,
                            width: webScreenWidthUnit * 550,
                            child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                    ),
                                  );
                                }
                              },
                            ),
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
                                          style: GoogleFonts.baloo2(
                                            fontSize: webScreenWidthUnit * 36,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              animatedTextIndex < 1
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AnimatedTextKit(
                                                          key: ValueKey<int>(0),
                                                          animatedTexts: [
                                                            animatedTexts[0]
                                                          ],
                                                          isRepeatingAnimation:
                                                              false,
                                                          onFinished: () {
                                                            setState(() {
                                                              showSecondText =
                                                                  true;
                                                            });
                                                          },
                                                        ),
                                                        animatedTextIndex ==
                                                                    0 &&
                                                                showSecondText
                                                            ? AnimatedTextKit(
                                                                animatedTexts: [
                                                                  TyperAnimatedText(
                                                                    'Budget Simluator!',
                                                                    textStyle:
                                                                        GoogleFonts
                                                                            .baloo2(
                                                                      fontSize:
                                                                          webScreenWidthUnit *
                                                                              36,
                                                                      color: Color.fromRGBO(
                                                                          79,
                                                                          195,
                                                                          247,
                                                                          1),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                    speed: Duration(
                                                                        milliseconds:
                                                                            400 ~/
                                                                                'Budget Simluator!'.length),
                                                                  ),
                                                                ],
                                                                isRepeatingAnimation:
                                                                    false,
                                                              )
                                                            : Text("")
                                                      ],
                                                    )
                                                  : AnimatedTextKit(
                                                      key: ValueKey<int>(
                                                          animatedTextIndex), // Ensures the widget rebuilds
                                                      animatedTexts: [
                                                        animatedTexts[
                                                            animatedTextIndex]
                                                      ],
                                                      isRepeatingAnimation:
                                                          false,
                                                      onFinished: () {
                                                        setState(() {
                                                          eventFinished = true;
                                                        });
                                                        print(
                                                            "Animation Finished");
                                                      },
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (animatedTextIndex < 1) {
                                              animatedTextIndex = 1;
                                            }
                                            if (eventFinished) {
                                              animatedTextIndex++;
                                              eventFinished = false;
                                              if (animatedTextIndex >=
                                                  animatedTexts.length) {
                                                firstTime = false;
                                              }
                                            }
                                          });
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(0, 0,
                                                webScreenWidthUnit * 38, 0),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: webScreenWidthUnit * 57,
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
                              width: selectedScenario ==
                                          "Crush the Credit Card Debt" &&
                                      intermediate
                                  ? webScreenWidthUnit * 121
                                  : webScreenWidthUnit * 151,
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
                      selectedScenario == 'Crush the Credit Card Debt' &&
                              intermediate
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
                              width: selectedScenario ==
                                          "Crush the Credit Card Debt" &&
                                      intermediate
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      WrongAnswerSnackBar(
                                          message:
                                              "Please select Intermediate"));
                                }),
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                    WrongAnswerSnackBar(
                                        message: "Please select Intermediate"));
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(
                              webScreenWidthUnit * 1200,
                              selectedScenario ==
                                          "Crush the Credit Card Debt" &&
                                      intermediate
                                  ? webScreenHeightUnit * 88
                                  : 290,
                              0,
                              selectedScenario ==
                                          "Crush the Credit Card Debt" &&
                                      intermediate
                                  ? 0
                                  : webScreenHeightUnit * 60),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedScenario ==
                                      "Crush the Credit Card Debt" &&
                                  intermediate) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    WrongAnswerSnackBar(
                                        message:
                                            "Please select Intermediate and Crush the Credit Card Debt"));
                              }
                            },
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
  return level != "Intermediate"
      ? Container(
          width: screenWidthUnit * 359,
          height: screenHeightUnit * 185,
          decoration: BoxDecoration(
            color: Color.fromRGBO(197, 197, 197, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
              width: screenWidthUnit * 59,
              height: screenHeightUnit * 25,
              child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLock.png?alt=media&token=2b93bce0-075b-4f9c-a6ef-fae04dd0e6b0",
              )))
      : GestureDetector(
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
