import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Models/user_data.dart';
import 'package:money_monkey/Backend/Services/crud.dart';
import 'package:money_monkey/Profile%20Page/Widgets/add_friends_button.dart';
import 'package:money_monkey/Profile%20Page/Widgets/share_button.dart';
import 'package:money_monkey/themes/color_themes.dart';

import 'Widgets/custom_stat.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.userID,
    required this.user,
  });
  final String userID;
  final User user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int pageIndex = 0;

  UserData? userData; // Make userData nullable
  bool isLoading = true; // Track loading state
  final FirebaseService firebaseService = FirebaseService();

  void getUserInfo() async {
    userData = (await firebaseService.getUser(widget.userID)) as UserData?;

    setState(() {
      isLoading = false; // Set loading to false once data is fetched
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    // Screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: LightTheme().primaryBackgroundColor,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator()) // Loading indicator
                : userData == null
                    ? const Center(
                        child:
                            Text("Error loading user data")) // Error handling
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
                                      text: "${userData!.profile.following}\n",
                                      style: GoogleFonts.fredoka().copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "Following",
                                          style: GoogleFonts.fredoka().copyWith(
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
                                      borderRadius: BorderRadius.circular(10)),
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
                                          style: GoogleFonts.fredoka().copyWith(
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
                            const Row(
                              children: [
                                AddFriendsButton(),
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
                            SingleChildScrollView(
                              padding: const EdgeInsets.all(10),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 45,
                                    color: LightTheme().primaryGreen,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 45,
                                    color: LightTheme().primaryGreen,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 45,
                                    color: LightTheme().primaryGreen,
                                  ),
                                ],
                              ),
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
                                CustomStat(
                                  accent: Colors.yellow,
                                  title: "Day Streak",
                                  number: userData!.profile.streak.toString(),
                                  iconURL:
                                      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FProfile%20Page%2FStreak.png?alt=media&token=10fcb0c5-887d-4719-8c1d-21f9abbc93c7",
                                ),
                                const Spacer(),
                                CustomStat(
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
                                CustomStat(
                                  accent: LightTheme().primaryGreen,
                                  title: "Portfolio Score",
                                  iconURL:
                                      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FProfile%20Page%2FPortfolioStat.png?alt=media&token=52557059-bbd7-4cc8-b510-ccc1e95508a0",
                                  number:
                                      "${userData!.profile.portfolioScore.toString().substring(0, userData!.profile.portfolioScore.toString().lastIndexOf('.'))}/100",
                                ),
                                const Spacer(),
                                CustomStat(
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
                                  firebaseService.signOut();
                                },
                                child:
                                    const Text("Temporary Sign Out Button.")),
                          ],
                        ),
                      ),
          ),
        ),
      ),
      //Temporary Bottom Navigation Bar
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {},
        selectedIndex: 3,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.abc),
            enabled: false,
            label: "Page1",
          ),
          NavigationDestination(
            icon: Icon(Icons.abc),
            enabled: false,
            label: "Page2",
          ),
          NavigationDestination(
            icon: Icon(Icons.abc),
            enabled: false,
            label: "Page3",
          ),
          NavigationDestination(
            icon: Icon(Icons.abc),
            enabled: true,
            label: "Profile",
          ),
        ],
        height: 80,
      ),
    );
  }
}
