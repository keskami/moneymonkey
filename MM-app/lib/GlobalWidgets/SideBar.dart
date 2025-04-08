import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/HomePagesController.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePagesController homePagesController = Get.find();
    final Map<String, String> imageLinks = const {
      "Home": "assets/images/globemonkey.png",
      "Portfolio": "assets/images/treasure.png",
      "Characters": "assets/images/bottommonkey.png",
      "Home Work": "assets/images/HomeWorkPage.png",
      "Budget Simulator": "assets/images/BudgetSimulator.png",
      "Profile": "assets/images/bluemonkey.png",
    };

    return Obx(() {
      bool isExpanded = homePagesController.isSidebarExpanded.value;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutQuad,
        width: isExpanded ? 250 : 100,
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Navigation Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: imageLinks.entries.map((entry) => 
                  _buildNavItem(
                    context,
                    icon: entry.value,
                    title: entry.key,
                    index: imageLinks.keys.toList().indexOf(entry.key),
                    isActive: homePagesController.pageIndex.value == 
                      imageLinks.keys.toList().indexOf(entry.key),
                  )
                ).toList(),
              ),
            ),
            
            // Bottom Actions or Settings
            _buildBottomSection(context, isExpanded),
          ],
        ),
      );
    });
  }

  Widget _buildNavItem(
    BuildContext context, {
    required String icon, 
    required String title, 
    required int index, 
    required bool isActive,
  }) {
    final HomePagesController homePagesController = Get.find();
    bool isExpanded = homePagesController.isSidebarExpanded.value;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => homePagesController.changePage(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          decoration: BoxDecoration(
            color: isActive ? const Color.fromRGBO(225, 243, 254, 1) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 17,
                backgroundColor: Colors.transparent,
                child: Image.asset(icon),
              ),
              if (isExpanded) ...[
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: isActive ? Colors.blue : Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, bool isExpanded) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          const Icon(Icons.settings_outlined, color: Colors.grey),
          if (isExpanded) ...[
            const SizedBox(width: 15),
            const Text(
              'Settings',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }
}