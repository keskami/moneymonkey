import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Global Controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: isWideScreen
          ? Row(
              children: [
                _buildPersistentDrawer(), 
                Expanded(
                  child: Obx(
                    () => homeController.pages[homeController.pageIndex.value],
                  ),
                ),
              ],
            )
          : Obx(
              () => homeController.pages[homeController.pageIndex.value],
            ),
      drawer: isWideScreen ? null : _buildDrawer(), 
      bottomNavigationBar: !isWideScreen ? _buildBottomBar(context) : null,
    );
  }

  Widget _buildPersistentDrawer() {
    return Container(
      width: 250, 
      color: Colors.blue.shade50,
      child: _buildDrawerContent(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: _buildDrawerContent(),
    );
  }

  Widget _buildDrawerContent() {
    final screenHeight = MediaQuery.of(context).size.height;
    return ListView(
      padding: EdgeInsets.zero,
      children: 
      <Widget>[
        SizedBox(height: screenHeight * .1,),
        _buildDrawerItem('assets/images/globemonkey.png', 0,screenHeight, "Home"),
        SizedBox(height: screenHeight * .05,),
        _buildDrawerItem('assets/images/treasure.png', 1,screenHeight, "Porfolio"),
        SizedBox(height: screenHeight * .05,),
        _buildDrawerItem('assets/images/bottommonkey.png', 2, screenHeight, "IDK"),
        SizedBox(height: screenHeight * .05,),
        _buildDrawerItem('assets/images/bluemonkey.png', 3, screenHeight, "IDK"),
      ],
    );
  }

  Widget _buildDrawerItem(String iconPath, int index, double screenHeight, String page) {
    
    return ListTile(
      leading: Image.asset(iconPath, height: screenHeight * .15),
      title: Text('$page'),
      selected: homeController.pageIndex.value == index,
      onTap: () {
        setState(() {
          homeController.pageIndex.value = index;
        });
      },
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomNavigationBar(
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
  }