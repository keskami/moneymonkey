import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/Backend/Models/user_data.dart';
import 'package:money_monkey/Backend/Services/crud.dart';
import 'package:money_monkey/themes/color_themes.dart';

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
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            // Background Image
            Positioned(
              top: 60,
              left: MediaQuery.of(context).size.width / 10,
              right: MediaQuery.of(context).size.width / 10,
              child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FProfile%20Page%2FNoProfileImage.png?alt=media&token=93c77c5a-6f36-4115-8b93-109ef552166b",
                height: 270,
              ),
            ),

            // Visible Container or Loading Indicator
            Positioned(
              top: 250, // Adjust the top position based on the image height
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: LightTheme().primaryBackgroundColor,
                  child: isLoading
                      ? const Center(
                          child:
                              CircularProgressIndicator()) // Loading indicator
                      : userData == null
                          ? const Center(
                              child: Text(
                                  "Error loading user data")) // Error handling
                          : Column(
                              children: [
                                Text("User Profile Data"),
                                Text("User ID: ${widget.userID}"),
                                Text("Email: ${userData!.email}"),
                                Text("Age: ${userData!.age}"),
                                Text(
                                    "Knowledge Level: ${userData!.knowledgeLevel}"),
                                Text(
                                    "Learning Goal Per Day: ${userData!.learningGoalPerDay}"),
                                Text(
                                    "Starting Level: ${userData!.startingLevel}"),
                                Text("Profile:"),
                                Text(
                                    "Full Name: ${userData!.profile.fullName}"),
                                Text("Username: ${userData!.profile.username}"),
                                Text(
                                    "Number of Followers: ${userData!.profile.numberOfFollowers}"),
                                Text(
                                    "Following: ${userData!.profile.following}"),
                                Text(
                                    "Top Achievements: ${userData!.profile.topAchievements.toString()}"),
                                Text("Streak: ${userData!.profile.streak}"),
                                Text(
                                    "Total Profit: ${userData!.profile.totalProfit}"),
                                Text(
                                    "Portfolio Score: ${userData!.profile.portfolioScore}"),
                                Text(
                                    "Average Monthly Growth: ${userData!.profile.averageMonthlyGrowth}"),
                              ],
                            )),
            ),
          ],
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
        height: 100,
      ),
    );
  }
}
