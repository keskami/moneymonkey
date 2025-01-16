import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/themes/color_themes.dart';

class DashboardSubPageSelector extends StatelessWidget {
  DashboardSubPageSelector({
    super.key,
  });

  final List<String> subPages = [
    "Overview",
    "Lesson Management",
    "Student Performance",
    "Classroom Performance",
  ];
  final TeacherDashboardController _teacherDashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Obx(
      () => Container(
        color: Colors.grey.shade200,
        height: screenHeight * 0.06,
        child: Row(
          children: subPages
              .map(
                (subPage) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _teacherDashboardController.pageIndex.value =
                          subPages.indexOf(subPage);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: _teacherDashboardController.pageIndex.value ==
                              subPages.indexOf(subPage)
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: LightTheme().primaryBlue,
                            )
                          : null,
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Text(
                        subPage,
                        style: TextStyle(
                          color: _teacherDashboardController.pageIndex.value ==
                                  subPages.indexOf(subPage)
                              ? Colors.white
                              : Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
