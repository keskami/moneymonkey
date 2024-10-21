import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LoginPages/login.dart';
import 'package:money_monkey/friendsPages/friendsHome.dart';

class FriendsFromSearch extends StatefulWidget {
  const FriendsFromSearch({super.key});

  @override
  State<FriendsFromSearch> createState() => _FriendsFromSearchState();
}

class _FriendsFromSearchState extends State<FriendsFromSearch> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidthUnit = MediaQuery.of(context).size.width / 390;
    double screenHeightUnit = MediaQuery.of(context).size.height / 844;
    List<Widget> friendsColumnWidgets = [
      friendSuggestion(
          name: "Kestan Kamei",
          image: "assets/images/magGlass.png",
          nameInContacts: "<Name in Contacts>",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
          friendSuggestion(
          name: "Kestan Kamei",
          image: "assets/images/magGlass.png",
          nameInContacts: "<Name in Contacts>",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
          friendSuggestion(
          name: "Kestan Kamei",
          image: "assets/images/magGlass.png",
          nameInContacts: "<Name in Contacts>",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
          friendSuggestion(
          name: "Kestan Kamei",
          image: "assets/images/magGlass.png",
          nameInContacts: "<Name in Contacts>",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
          friendSuggestion(
          name: "Kestan Kamei",
          image: "assets/images/magGlass.png",
          nameInContacts: "<Name in Contacts>",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
          friendSuggestion(
          name: "Kestan Kamei",
          image: "assets/images/magGlass.png",
          nameInContacts: "<Name in Contacts>",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
          friendSuggestion(
          name: "Kestan Kamei",
          image: "assets/images/magGlass.png",
          nameInContacts: "<Name in Contacts>",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
          friendSuggestion(
          name: "Kestan Kamei",
          image: "assets/images/magGlass.png",
          nameInContacts: "<Name in Contacts>",
          screenHeightUnit: screenHeightUnit,
          screenWidthUnit: screenWidthUnit),
         
    ];

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeightUnit * 57),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidthUnit * 18, 0, 0, 0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FriendsHome()));
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: screenHeightUnit * 37,
                    ),
                  ),
                  SizedBox(
                    width: screenWidthUnit * 20,
                  ),
                  Text(
                    "Search for friends",
                    style: GoogleFonts.fredoka(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ]),
              ),
            ],
          ),
          SizedBox(
            height: screenHeightUnit * 17,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(screenWidthUnit * 14, 0, 0, 0),
            child: Container(
              height: 45 * screenHeightUnit,
              width: 348 * screenWidthUnit,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _searchController,
                textAlign: TextAlign.start,
                style: GoogleFonts.baloo2(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search, 
                    size: 27 * screenHeightUnit,
                    color: Colors.black,
                  ),
                  hintText: 'Name or Username',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(
                      15 * screenWidthUnit, 12 * screenHeightUnit, 0, 0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeightUnit * 34,
          ),
          Center(
              child: Container(
            height: screenHeightUnit * 610,
            width: screenWidthUnit * 350,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black, width: screenWidthUnit * 2),
              borderRadius: BorderRadius.circular(screenWidthUnit * 20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                if (friendsColumnWidgets.isNotEmpty) ...friendsColumnWidgets
              ],
            ),
          ))
        ],
      ),
    ));
  }

  Widget friendSuggestion({
    required String name,
    required String image,
    required String nameInContacts,
    required double screenHeightUnit,
    required double screenWidthUnit,
  }) {
    return name.isEmpty
        ? Container(
            height: screenHeightUnit * 66,
            width: screenWidthUnit * 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: screenHeightUnit * 1,
                  width: screenWidthUnit * 380,
                  color: Colors.black,
                )
              ],
            ),
          )
        : Container(
            height: screenHeightUnit * 72,
            width: screenWidthUnit * 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10 * screenWidthUnit,
                    ),
                    Container(
                      height: screenHeightUnit * 46,
                      width: screenHeightUnit * 46,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(220, 220, 220, 1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 13 * screenWidthUnit,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.fredoka(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          nameInContacts,
                          style: GoogleFonts.baloo2(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Container(
                        height: 23 * screenHeightUnit,
                        width: 95 * screenWidthUnit,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(135, 206, 235, 1),
                          borderRadius:
                              BorderRadius.circular(screenHeightUnit * 8),
                          border: Border.all(
                              color: Colors.black, width: screenWidthUnit * 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          "Follow",
                          style: GoogleFonts.fredoka(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidthUnit * 18,
                    )
                  ],
                ),
                Spacer(),
                Container(
                  height: screenHeightUnit * 1,
                  width: screenWidthUnit * 380,
                  color: Colors.black,
                )
              ],
            ));
  }
}
