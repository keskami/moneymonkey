import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';

class BudgetSimulatorLanding extends StatefulWidget {
  @override
  _BudgetSimulatorLandingState createState() => _BudgetSimulatorLandingState();
}

class _BudgetSimulatorLandingState extends State<BudgetSimulatorLanding> {
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  bool firstTime = false;
  bool beginner = false;
  bool intermediate = false;
  bool advanced = false;

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

  String? selectedScenario;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double webScreenWidthUnit = screenWidth / 1717;
    double webScreenHeightUnit = screenHeight / 952;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : firstTime
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    Text('Welcome to the Budget Simulator!'),
                    Text('You have $balance in your account'),
                    Text('You have $totalBanans Bananas'),
                  ],
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                body: Column(
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
                            width: webScreenWidthUnit * 121,
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
                                if(value == 'Crush the Credit Card Debt'){
                                  selectedScenario = value as String?;
                                  print(selectedScenario);
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    WrongAnswerSnackBar(message: "Please select 'Crush the Credit Card Debt'")
                                  );
                                  
                                }
                                
                              });
                            },
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
                            width: webScreenWidthUnit * 121,
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
                              }else{
                                beginner = false;
                              }
                              });
                            },
                            ),
                            SizedBox(width: webScreenWidthUnit * 81,),
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
                              }else{
                                intermediate = false;
                              }
                              });
                            },
                            ),
                            SizedBox(width: webScreenWidthUnit * 81,),
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
                              }else{
                                advanced = false;
                              }
                              });
                            },
                            ),
                            
                            

                        ],
                      ),
                    )
                     
                  ],
                ),
              );
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
    child: isSelected? Container(
      width: screenWidthUnit * 359,
      height: screenHeightUnit * 106,
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

    ) : Container(
      width: screenWidthUnit * 359,
      height: screenHeightUnit * 106,
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

    )
  );
}
