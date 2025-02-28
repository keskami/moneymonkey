import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Friends/comingSoonPage.dart';
import 'package:money_monkey/GlobalWidgets/SideBar.dart';
import 'package:money_monkey/LessonPages/Controllers/HomePagesController.dart';
import 'package:money_monkey/LessonPages/Pages/LessonsHome.dart';
import 'package:money_monkey/PortfolioPages/portfolio_screen.dart';
import 'package:money_monkey/Profile/profile_page.dart';
import 'package:money_monkey/TeacherDashboard/Pages/TeacherDashboard.dart';
import 'package:money_monkey/themes/color_themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final HomePagesController homePagesController =
      Get.put(HomePagesController());

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Decide whether to show web or mobile layout
    return screenWidth > screenHeight
        ? webDisplay(context, screenWidth)
        : mobileDisplay(context);
  }

  /// WEB DISPLAY
  Scaffold webDisplay(BuildContext context, double screenWidth) {
    return Scaffold(
      body: Obx(
        () => Row(
          children: [
            // Sidebar (20% width)
            SizedBox(
              width: screenWidth * 0.2,
              child: SideBar(),
            ),

            // Main content (80% width)
            SizedBox(
              width: screenWidth * 0.8,
              child: homePagesController
                  .pages[homePagesController.pageIndex.value],
            )
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            LightTheme().primaryBlue,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeacherDashboard(),
            ),
          );
        },
        child: Text(
          "Teacher Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  /// MOBILE DISPLAY
  Scaffold mobileDisplay(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: const [
          LessonsHome(),
          PortfolioScreen(),
          ComingSoonPage(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: _buildMobileBottomBar(context),
    );
  }

  /// BUILD MOBILE NAVIGATION BAR
  Widget _buildMobileBottomBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentPage,
      onTap: (index) {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      },
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        _buildMobileNavItem('assets/images/globemonkey.png', 0),
        _buildMobileNavItem('assets/images/treasure.png', 1),
        _buildMobileNavItem('assets/images/bottommonkey.png', 2),
        _buildMobileNavItem('assets/images/bluemonkey.png', 3),
      ],
    );
  }

  /// HELPER TO BUILD BOTTOM NAVIGATION BUTTON
  BottomNavigationBarItem _buildMobileNavItem(String iconPath, int index) {
    final screenSize = MediaQuery.of(context).size;
    double iconSize = screenSize.width * 0.13;

    return BottomNavigationBarItem(
      icon: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          border: currentPage == index
              ? Border.all(color: Colors.blue, width: 3)
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
