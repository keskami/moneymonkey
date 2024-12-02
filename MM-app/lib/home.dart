import 'package:flutter/material.dart';
import 'package:money_monkey/Friends/comingSoonPage.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/home.dart';
import 'package:money_monkey/PortfolioPages/portfolio_screen.dart';
import 'package:money_monkey/Profile/profile_page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return screenWidth > screenHeight
        ? webDisplay(context, screenWidth)
        : mobileDisplay(context);
  }

  Scaffold webDisplay(BuildContext context, double screenWidth) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: screenWidth * 0.15,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    setState(() {
                      currentPage = 0;
                    });
                    _pageController.animateToPage(
                      currentPage,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear,
                    );
                  },
                  selected: currentPage == 0,
                  leading: Image.asset('assets/images/globemonkey.png'),
                  trailing: Text(
                    "Home",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      currentPage = 1;
                    });
                    _pageController.animateToPage(
                      currentPage,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear,
                    );
                  },
                  selected: currentPage == 1,
                  leading: Image.asset('assets/images/treasure.png'),
                  trailing: Text(
                    "Portfolio",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      currentPage = 2;
                    });
                    _pageController.animateToPage(
                      currentPage,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear,
                    );
                  },
                  selected: currentPage == 2,
                  leading: Image.asset('assets/images/bottommonkey.png'),
                  trailing: Text(
                    "Market",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      currentPage = 3;
                    });
                    _pageController.animateToPage(
                      currentPage,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear,
                    );
                  },
                  selected: currentPage == 3,
                  leading: Image.asset('assets/images/bluemonkey.png'),
                  trailing: Text(
                    "Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth * 0.85,
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              children: [
                HomeScreen(),
                PortfolioScreen(),
                ComingSoonPage(),
                ProfileScreen(),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: _buildMobileBottomBar(context),
    );
  }

  Scaffold mobileDisplay(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: [
          HomeScreen(),
          PortfolioScreen(),
          ComingSoonPage(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: _buildMobileBottomBar(context),
    );
  }

  Widget _buildMobileBottomBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentPage,
      onTap: (index) {
        print(index);
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 100),
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