import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  final int pageIndex = 0;

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

            // Visible Container
            Positioned(
              top: 250, // Adjust the top position based on the image height
              child: Container(
                height: MediaQuery.of(context)
                    .size
                    .height, // Adjust the height as per requirement
                width: MediaQuery.of(context).size.width,
                color: LightTheme()
                    .primaryBackgroundColor, // Semi-transparent color
                child: Column(),
              ),
            ),
          ],
        ),
      ),
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
