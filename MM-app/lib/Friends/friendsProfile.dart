import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/firestore_service.dart';
import 'package:money_monkey/Friends/Widgets/add_friends_button_friends.dart';
import 'package:money_monkey/Friends/Widgets/custom_stat_friends.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/home.dart';
import 'package:money_monkey/PortfolioPages/portfolio_screen.dart';
import 'package:money_monkey/Profile/Widgets/share_button.dart';
import 'package:money_monkey/themes/color_themes.dart';

import '../Profile/profile_page.dart';

class friendProfile extends StatefulWidget {
  final String otherID;
  friendProfile({super.key, required this.otherID});

  @override
  State<friendProfile> createState() => _friendProfileState();
}

class _friendProfileState extends State<friendProfile> {
  final int pageIndex = 0;
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;

  Student? userData;
  bool isLoading = true;
  late bool isFollowing = false;
  final FirestoreService firestoreService = FirestoreService();

  void getUserInfo() async {
    try {
      userData = await firestoreService.getUserData(widget.otherID);
      isFollowing = await firestoreService.isFollowing(userID!, widget.otherID);

      if (userData == null) {
        print("User data is null for userID: ${widget.otherID}");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    // Screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: LightTheme().primaryBackgroundColor,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : userData == null
                      ? const Center(child: Text("loading user data"))
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FProfile%20Page%2FNoProfilePicture.png?alt=media&token=454be09c-518a-42d5-bee7-e64e4cc44376",
                                  height: screenHeight / 4.5,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      // If loadingProgress is null, the image has fully loaded
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              Text(
                                userData!.profile.fullName,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "@${userData!.profile.username}",
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Row(
                                children: [
                                  //Followers and Following count
                                  RichText(
                                    text: TextSpan(
                                        text:
                                            "${userData!.profile.following}\n",
                                        style: GoogleFonts.fredoka().copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "Following",
                                            style:
                                                GoogleFonts.fredoka().copyWith(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                    width: 10,
                                  ),
                                  Container(
                                    height: screenHeight * 0.07,
                                    width: screenWidth * 0.015,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                    width: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text:
                                            "${userData!.profile.numberOfFollowers}\n",
                                        style: GoogleFonts.fredoka().copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "Followers",
                                            style:
                                                GoogleFonts.fredoka().copyWith(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  AddFriendsButtonFriends(
                                    follows: isFollowing,
                                    otherID: widget.otherID,
                                  ),
                                  Spacer(),
                                  ShareButton(),
                                ],
                              ),
                              //Achievements Section
                              Row(
                                children: [
                                  const Text(
                                    "Achievements",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "VIEW ALL",
                                      style: TextStyle(
                                        color: LightTheme().primaryBlue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                //Temporary Icons until Achievements are figured out.
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_1.png?alt=media&token=976c4a31-8935-4577-8371-ecc87513e2c5",
                                    width: screenWidth * 0.25,
                                  ),
                                  Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_2.png?alt=media&token=5949c906-f8db-401c-902e-e3fc9d46ec7d",
                                    width: screenWidth * 0.25,
                                  ),
                                  Image.network(
                                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_3.png?alt=media&token=5541600c-da47-4c45-b5e0-aab024bb8076",
                                    width: screenWidth * 0.25,
                                  ),
                                ],
                              ),
                              const Text(
                                "Overall Stats",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  CustomStatFriends(
                                    accent: Colors.yellow,
                                    title: "Day Streak",
                                    number: userData!.profile.streak.toString(),
                                    iconURL:
                                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FProfile%20Page%2FStreak.png?alt=media&token=10fcb0c5-887d-4719-8c1d-21f9abbc93c7",
                                  ),
                                  const Spacer(),
                                  CustomStatFriends(
                                    accent: Colors.yellow,
                                    title: "Total Profit",
                                    iconURL:
                                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FProfile%20Page%2FProfitStat.png?alt=media&token=fdca0cec-3182-49ed-a802-012f41184b7c",
                                    number:
                                        "+${userData!.profile.totalProfit.toString().substring(0, userData!.profile.totalProfit.toString().lastIndexOf('.'))}",
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  CustomStatFriends(
                                    accent: LightTheme().primaryGreen,
                                    title: "Portfolio Score",
                                    iconURL:
                                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FProfile%20Page%2FPortfolioStat.png?alt=media&token=52557059-bbd7-4cc8-b510-ccc1e95508a0",
                                    number:
                                        "${userData!.profile.portfolioScore.toString().substring(0, userData!.profile.portfolioScore.toString().lastIndexOf('.'))}/100",
                                  ),
                                  const Spacer(),
                                  CustomStatFriends(
                                    accent: LightTheme().primaryBlue,
                                    title: "Avg. Monthly Growth",
                                    iconURL:
                                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FProfile%20Page%2FMonthlyGrowthStat.png?alt=media&token=e28f2843-5af7-4fdb-a020-218e73ba3040",
                                    number:
                                        "${userData!.profile.averageMonthlyGrowth.toString()}%",
                                  ),
                                ],
                              ),
                              TextButton(
                                  onPressed: () {
                                    // firestoreService.signOut();
                                  },
                                  child:
                                      const Text("Temporary Sign Out Button.")),
                            ],
                          ),
                        ),
            ),
          ),
        ),
      ),
      //Temporary Bottom Navigation Bar
      bottomNavigationBar: _buildBottomBar(context),
      floatingActionButton: IconButton(
        padding: EdgeInsets.only(top: 20),
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 40,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        if (_currentIndex == 0) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        } else if (_currentIndex == 1) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PortfolioScreen(),
          ));
        }
        if (_currentIndex == 3) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfileScreen(),
          ));
        }
      },
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed, // Fixed items
      selectedItemColor: Colors.blue, // Color for the selected item
      unselectedItemColor: Colors.grey, // Color for unselected items
      showSelectedLabels: false, // Hide the labels
      showUnselectedLabels: false,
      items: [
        _buildNavItem('assets/images/globemonkey.png', 0),
        _buildNavItem('assets/images/treasure.png', 1),
        _buildNavItem('assets/images/bottommonkey.png', 2),
        _buildNavItem('assets/images/bluemonkey.png', 3),
      ],
    );
  }

  // Build each navigation item with custom behavior for selected state
  BottomNavigationBarItem _buildNavItem(String iconPath, int index) {
    final screenSize = MediaQuery.of(context).size;
    double iconSize = screenSize.width * 0.13; // Make icons 10% of screen width

    return BottomNavigationBarItem(
      icon: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          border: _currentIndex == index
              ? Border.all(
                  color: Colors.blue, width: 3) // Border for the selected item
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          iconPath,
          fit: BoxFit.contain,
        ),
      ),
      label: '', // No label
    );
  }
}
