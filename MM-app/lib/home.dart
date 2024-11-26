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
      bottomNavigationBar: !isWideScreen ? _buildBottomBar() : null,
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
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Navigation',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        _buildDrawerItem('assets/images/globemonkey.png', 0),
        _buildDrawerItem('assets/images/treasure.png', 1),
        _buildDrawerItem('assets/images/bottommonkey.png', 2),
        _buildDrawerItem('assets/images/bluemonkey.png', 3),
      ],
    );
  }

  Widget _buildDrawerItem(String iconPath, int index) {
    return ListTile(
      leading: Image.asset(iconPath, width: 24),
      title: Text('Page $index'),
      selected: homeController.pageIndex.value == index,
      onTap: () {
        setState(() {
          homeController.pageIndex.value = index;
        });
      },
    );
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      currentIndex: homeController.pageIndex.value,
      onTap: (index) {
        setState(() {
          homeController.pageIndex.value = index;
        });
      },
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        _buildNavItem('assets/images/globemonkey.png', 0),
        _buildNavItem('assets/images/treasure.png', 1),
        _buildNavItem('assets/images/bottommonkey.png', 2),
        _buildNavItem('assets/images/bluemonkey.png', 3),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconPath, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(iconPath, width: 24),
      label: '',
    );
  }
}
