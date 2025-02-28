import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/HomePagesController.dart';

class SideBar extends StatelessWidget {
  SideBar({super.key});
  final HomePagesController homePagesController = Get.find();
  final Map<String, String> imageLinks = const {
    "Home": "assets/images/globemonkey.png",
    "Portfolio": "assets/images/treasure.png",
    "Characters": "assets/images/bottommonkey.png",
    "BudgetSimulator":"assets/images/budget_simulator.png",
    "Profile": "assets/images/bluemonkey.png",
  };
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Obx(
      () => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            for (var entry in imageLinks.entries)
              SideBarTile(
                icon: entry.value,
                index: imageLinks.keys.toList().indexOf(entry.key),
                title: entry.key.toUpperCase(),
                isSelected: homePagesController.pageIndex.value ==
                    imageLinks.keys.toList().indexOf(entry.key),
              ),
          ],
        ),
      ),
    );
  }
}

class SideBarTile extends StatelessWidget {
  SideBarTile({
    super.key,
    required this.icon,
    required this.index,
    required this.title,
    required this.isSelected,
  });
  final String icon;
  final int index;
  final String title;
  final bool isSelected;
  final HomePagesController homePagesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homePagesController.pageIndex.value = index;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 225, 243, 254)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundColor: Colors.transparent,
              child: Image.asset(
                icon,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              overflow: TextOverflow.visible,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ).paddingSymmetric(
          vertical: 10,
        ),
      ),
    );
  }
}
