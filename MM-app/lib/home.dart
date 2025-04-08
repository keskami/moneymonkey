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

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final HomePagesController homePagesController =
      Get.put(HomePagesController());
  int currentPage = 0;
  late AnimationController _sidebarAnimationController;
  late Animation<double> _sidebarWidthAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _sidebarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _sidebarAnimationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

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
        () {
          // Calculate sidebar width animation
          _sidebarWidthAnimation = Tween<double>(
            begin: screenWidth * 0.06,  // Minimized width
            end: screenWidth * 0.2,     // Expanded width
          ).animate(CurvedAnimation(
            parent: _sidebarAnimationController,
            curve: Curves.easeInOutQuad,
          ));

          // Trigger animation based on sidebar state
          if (homePagesController.isSidebarExpanded.value) {
            _sidebarAnimationController.forward();
          } else {
            _sidebarAnimationController.reverse();
          }

          return AnimatedBuilder(
            animation: _sidebarAnimationController,
            builder: (context, child) {
              // Calculate content width dynamically
              double sidebarWidth = _sidebarWidthAnimation.value;
              double contentWidth = screenWidth - sidebarWidth;

              return Row(
                children: [
                  // Sidebar with smooth width transition
                  MouseRegion(
                    onEnter: (_) => homePagesController.isSidebarExpanded.value = true,
                    onExit: (_) => homePagesController.isSidebarExpanded.value = false,
                    child: SizedBox(
                      width: sidebarWidth,
                      height: double.infinity,
                      child: SideBar(
                      ),
                    ),
                  ),
                  
                  // Main content with smooth width transition
                  SizedBox(
                    width: contentWidth,
                    child: homePagesController
                        .pages[homePagesController.pageIndex.value],
                  )
                ],
              );
            },
          );
        },
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