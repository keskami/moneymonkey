import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Backend/Loading%20Widgets/shimmer_loading_container.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/firestore_service.dart';
import 'package:money_monkey/Profile/Widgets/add_friends_button.dart';
import 'package:money_monkey/Profile/Widgets/share_button.dart';
import 'package:money_monkey/Settings/Pages/settings.dart';
import 'package:money_monkey/themes/color_themes.dart';

import '../Friends/friendsHome.dart';
import 'Widgets/custom_stat.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;

  Student? userData; // Make userData nullable
  bool isLoading = true; // Track loading state
  final FirestoreService firestoreService = FirestoreService();

  void getUserInfo() async {
    try {
      userData = await firestoreService.getUserData(userID!);
      if (userData == null) {
        print("User data is null for userID: ${userID!}");
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return isLoading
        ? Center(
            child: SizedBox(
                height: screenHeight * 0.2,
                width: screenHeight * 0.2,
                child: CircularProgressIndicator()),
          )
        : screenWidth > screenHeight
            ? webDisplay(context, screenHeight, screenWidth)
            : mobileDisplay(context, screenHeight, screenWidth);
  }

  Scaffold webDisplay(
      BuildContext context, double screenHeight, double screenWidth) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: LightTheme().primaryBackgroundColor,
        child: userData == null
            ? const Center(
                child: Text("Error loading user data")) // Error handling
            : Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.05,
                        ),
                        width: screenWidth * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FProfile%20Page%2FNoProfilePicture.png?alt=media&token=454be09c-518a-42d5-bee7-e64e4cc44376",
                                height: screenHeight * 0.3,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: ShimmerContainer(
                                      height: screenWidth * 0.4,
                                      width: screenWidth * 0.4,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: ShimmerContainer(
                                      height: screenHeight / 4.5,
                                      width: double.infinity,
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
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FriendsHome(),
                                        ));
                                  },
                                  child: AddFriendsButton(),
                                ),
                                Spacer(),
                                ShareButton(),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.1,
                            ),
                            const Text(
                              "Overall Stats",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
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
                                      "+${userData!.profile.totalProfit.toString().contains('.') ? userData!.profile.totalProfit.toString().substring(0, userData!.profile.totalProfit.toString().lastIndexOf('.')) : userData!.profile.totalProfit.toString()}",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Row(
                              children: [
                                CustomStat(
                                  accent: LightTheme().primaryGreen,
                                  title: "Portfolio Score",
                                  iconURL:
                                      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FProfile%20Page%2FPortfolioStat.png?alt=media&token=52557059-bbd7-4cc8-b510-ccc1e95508a0",
                                  number:
                                      "${userData!.profile.portfolioScore.toString().contains('.') ? userData!.profile.portfolioScore.toString().substring(0, userData!.profile.portfolioScore.toString().lastIndexOf('.')) : userData!.profile.portfolioScore.toString()}/100",
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
                            SizedBox(
                              height: screenHeight * 0.1,
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
                                  width: screenWidth * 0.1,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: ShimmerContainer(
                                          height: screenWidth * 0.1,
                                          width: screenWidth * 0.1,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: ShimmerContainer(
                                        height: screenWidth * 0.1,
                                        width: screenWidth * 0.1,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_2.png?alt=media&token=5949c906-f8db-401c-902e-e3fc9d46ec7d",
                                  width: screenWidth * 0.1,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: ShimmerContainer(
                                          height: screenWidth * 0.1,
                                          width: screenWidth * 0.1,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: ShimmerContainer(
                                        height: screenWidth * 0.1,
                                        width: screenWidth * 0.1,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_3.png?alt=media&token=5541600c-da47-4c45-b5e0-aab024bb8076",
                                  width: screenWidth * 0.1,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: ShimmerContainer(
                                          height: screenWidth * 0.1,
                                          width: screenWidth * 0.1,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: ShimmerContainer(
                                        height: screenWidth * 0.1,
                                        width: screenWidth * 0.1,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Container(
                        width: screenWidth * 0.25,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("data"),
                            Row(
                              children: [
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
                                  width: screenWidth * 0.005,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      //Temporary Bottom Navigation Bar
      // bottomNavigationBar: _buildBottomBar(context),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SettingsPage(),
          ));
        },
        icon: Icon(
          Icons.settings,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Scaffold mobileDisplay(
      BuildContext context, double screenHeight, double screenWidth) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: LightTheme().primaryBackgroundColor,
            child: isLoading
                ? Center(
                    child: ShimmerContainer(
                      height: screenHeight * 0.9,
                      width: screenHeight * 0.7,
                    ),
                  ) // Loading indicator
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
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: ShimmerContainer(
                                      height: screenHeight / 4.5,
                                      width: screenHeight / 4.5,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: ShimmerContainer(
                                      height: screenHeight / 4.5,
                                      width: double.infinity,
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
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FriendsHome(),
                                          ));
                                    },
                                    child: AddFriendsButton()),
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
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: ShimmerContainer(
                                          height: screenWidth * 0.25,
                                          width: screenWidth * 0.25,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: ShimmerContainer(
                                        height: screenWidth * 0.25,
                                        width: screenWidth * 0.25,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_2.png?alt=media&token=5949c906-f8db-401c-902e-e3fc9d46ec7d",
                                  width: screenWidth * 0.25,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: ShimmerContainer(
                                          height: screenWidth * 0.25,
                                          width: screenWidth * 0.25,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: ShimmerContainer(
                                        height: screenWidth * 0.25,
                                        width: screenWidth * 0.25,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Achievements%2Fachievement_3.png?alt=media&token=5541600c-da47-4c45-b5e0-aab024bb8076",
                                  width: screenWidth * 0.25,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: ShimmerContainer(
                                          height: screenWidth * 0.25,
                                          width: screenWidth * 0.25,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: ShimmerContainer(
                                        height: screenWidth * 0.25,
                                        width: screenWidth * 0.25,
                                      ),
                                    );
                                  },
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
                                      "+${userData!.profile.totalProfit.toString().contains('.') ? userData!.profile.totalProfit.toString().substring(0, userData!.profile.totalProfit.toString().lastIndexOf('.')) : userData!.profile.totalProfit.toString()}",
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
                                      "${userData!.profile.portfolioScore.toString().contains('.') ? userData!.profile.portfolioScore.toString().substring(0, userData!.profile.portfolioScore.toString().lastIndexOf('.')) : userData!.profile.portfolioScore.toString()}/100",
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
                            )
                          ],
                        ),
                      ),
          ),
        ),
      ),
      //Temporary Bottom Navigation Bar
      // bottomNavigationBar: _buildBottomBar(context),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SettingsPage(),
          ));
        },
        icon: Icon(
          Icons.settings,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
