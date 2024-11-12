import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LoginPages/login.dart';
import 'package:money_monkey/friendsPages/friendsHome.dart';
import 'package:money_monkey/friendsPages/friendsProfile.dart';

class FriendsFromContacts extends StatefulWidget {
  const FriendsFromContacts({super.key});

  @override
  State<FriendsFromContacts> createState() => _FriendsFromContactsState();
}

class _FriendsFromContactsState extends State<FriendsFromContacts> {
   List<Map<String, String>> friends = [
    {
      "name": "Josh Feenberg",
      "image": "assets/images/magGlass.png",
      "whySuggested": "You may know each other",
      "otherID": 'X8VCqOYHcVj15wodH8uuEmV393',
    },
    {
      "name": "Kestan Kamei",
      "image": "assets/images/magGlass.png",
      "whySuggested": "Followed by Jacob Lee",
      "otherID": "yUx6lW1xW6BoxiMQWwGKMdxi93"
    },
    {
      "name": "Kestan Kamei",
      "image": "assets/images/magGlass.png",
      "whySuggested": "Followed by Jacob Lee",
      "otherID": "yUx6lG1xW6BoxiMQWwGKMdxi93"
    },
    {
      "name": "Kestan Kamei",
      "image": "assets/images/magGlass.png",
      "whySuggested": "Followed by Jacob Lee",
      "otherID": "yUx6lW8GW6BoxiMQWwGKMdxi93"
    },
    {
      "name": "Kestan Kamei",
      "image": "assets/images/magGlass.png",
      "whySuggested": "Followed by Jacob Lee",
      "otherID": "yUx6lW8G6BoxiMQWwGKMdxi93"
    },
    {
      "name": "Kestan Kamei",
      "image": "assets/images/magGlass.png",
      "whySuggested": "Followed by Jacob Lee",
      "otherID": "yUx6lW8G16BoxiMQWwGKMdxi93"
    },
    {
      "name": "Kestan Kamei",
      "image": "assets/images/magGlass.png",
      "whySuggested": "Followed by Jacob Lee",
      "otherID": "yUx6lW8G16BoxiMQWwGKMdxi92"
    },
    {
      "name": "Kestan Kamei",
      "image": "assets/images/magGlass.png",
      "whySuggested": "Followed by Jacob Lee",
      "otherID": "yUx6lW8G1xW6BoxiMQWwGMdxi93"
    },
    {
      "name": "Kestan Kamei",
      "image": "assets/images/magGlass.png",
      "whySuggested": "Followed by Jacob Lee",
      "otherID": "yUx6lW8G1xW6BoxiMQWwGKMdi93"
    },
    
   
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidthUnit = MediaQuery.of(context).size.width / 390;
    double screenHeightUnit = MediaQuery.of(context).size.height / 844;
    

    return Scaffold(
      body: Column(
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
                    "Contacts on Money Monkey",
                    style: GoogleFonts.fredoka(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ]),
              ),
            ],
          ),
          SizedBox(
            height: screenHeightUnit * 8,
          ),
          Container(
            height: screenHeightUnit * 1,
            width: double.infinity,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
          SizedBox(
            height: screenHeightUnit * 20,
          ),
          Center(
              child: Container(
            height: screenHeightUnit * 676,
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
                  for (var friend in friends)
                    friendSuggestion(
                      name: friend["name"]!,
                      image: friend["image"]!,
                      whySuggested: friend["whySuggested"]!,
                      screenHeightUnit: screenHeightUnit,
                      screenWidthUnit: screenWidthUnit,
                      otherID: friend["otherID"]!,
                      onRemove: () => removeFriend(friend["otherID"]!),
                    ),
                ],
              ),
          ))
        ],
      ),
    );
  }

   void removeFriend(String otherID) {
    setState(() {
      friends.removeWhere((friend) => friend["otherID"] == otherID);
    });
  }

  Widget friendSuggestion({
    required String name,
    required String image,
    required String whySuggested,
    required double screenHeightUnit,
    required double screenWidthUnit,
    required String otherID,
    required VoidCallback onRemove,
  }) {
    return Container(
      height: screenHeightUnit * 72,
      width: screenWidthUnit * 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10 * screenWidthUnit),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => friendProfile(
                                otherID: otherID,
                              )));
                },
                child: Container(
                  height: screenHeightUnit * 46,
                  width: screenHeightUnit * 46,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(width: 13 * screenWidthUnit),
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
                    whySuggested,
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
                onTap: onRemove,
                child: Container(
                  height: 23 * screenHeightUnit,
                  width: 95 * screenWidthUnit,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(135, 206, 235, 1), 
                    borderRadius: BorderRadius.circular(screenHeightUnit * 8),
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
                      color: Colors.black, 
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(width: screenWidthUnit * 18),
            ],
          ),
          Spacer(),
          Container(
            height: screenHeightUnit * 1,
            width: screenWidthUnit * 380,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
