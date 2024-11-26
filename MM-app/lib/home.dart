import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Global Controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());
  late double screenWidth;
  late double screenHeight;


  @override
  Widget build(BuildContext context) {
       screenWidth = MediaQuery.of(context).size.width;
       screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Obx(
        () => homeController.pages[homeController.pageIndex.value],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }



  Widget _buildBottomBar(BuildContext context) {
    return screenHeight > screenWidth ?
    BottomNavigationBar(
      currentIndex: homeController.pageIndex.value,
      onTap: (index) {
        setState(() {
          homeController.pageIndex.value = index;
        });
      },
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        _buildNavItem('assets/images/globemonkey.png', 0),
        _buildNavItem('assets/images/treasure.png', 1),
        _buildNavItem('assets/images/bottommonkey.png', 2),
        _buildNavItem('assets/images/bluemonkey.png', 3),
      ],
    ) : 
    
    
    BottomNavigationBar(
      currentIndex: homeController.pageIndex.value,
      onTap: (index) {
        setState(() {
          homeController.pageIndex.value = index;
        });
      },
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        _buildWebNavItem('assets/images/globemonkey.png', 0),
        _buildWebNavItem('assets/images/treasure.png', 1),
        _buildWebNavItem('assets/images/bottommonkey.png', 2),
        _buildWebNavItem('assets/images/bluemonkey.png', 3),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconPath, int index) {
    final screenSize = MediaQuery.of(context).size;
    double iconSize = screenSize.width * 0.13;

    return BottomNavigationBarItem(
      icon: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          border: homeController.pageIndex.value == index
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

  BottomNavigationBarItem _buildWebNavItem(String iconPath, int index) {
    final screenSize = MediaQuery.of(context).size;
    double iconSize = screenSize.width * 0;

    return BottomNavigationBarItem(
      icon: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          border: homeController.pageIndex.value == index
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
