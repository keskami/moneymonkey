import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/CustomDropDownMenu.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/PerformanceTrendCharts.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/PlaceHolderTab.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class ClassroomPreferences extends StatefulWidget {
  const ClassroomPreferences({super.key});
  @override
  State<ClassroomPreferences> createState() => _ClassroomPreferencesState();
}

String selectedFilter = "All Statistics";
final List<String> filters = [
  "All Statistics",
  "Class Average",
  "Participation Rate",
  "Lesson Completion",
];

class _ClassroomPreferencesState extends State<ClassroomPreferences> {
  LocalAcademicService localAcademicService = LocalAcademicService();
  TeacherDashboardController teacherDashboardController =
      Get.find<TeacherDashboardController>();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    if (teacherDashboardController.selectedClassId.isEmpty)
      return TeacherDashoardPlaceHolderPage();
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            ShadowedContainer(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Performance Trends",
                          style: TextStyles.containerTitle,
                        ),
                        const Spacer(),
                        CustomDropDownContainer(
                            initialSelection: selectedFilter,
                            items: filters,
                            onChanged: (stat) {
                              if (stat != null)
                                setState(() {
                                  selectedFilter = stat;
                                });
                            },
                            width: screenWidth * 0.2),
                      ],
                    ),
                  ),
                  PerformanceTrendsChart(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.7,
                    filter: selectedFilter,
                  ),
                ],
              ),
            ),
            //Areas of Strength and Improvements
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: ShadowedContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            style: TextStyles.containerTitle,
                            "Areas of Strength",
                          ).marginSymmetric(
                            vertical: 10,
                          ),
                          ...generateColoredPaddedList(
                            {
                              "Budget Planning": 75,
                              "Saving Strategies": 84,
                              "Financial Goals": 76,
                            },
                            LightTheme().pastelGreen,
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    flex: 1,
                    child: ShadowedContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            style: TextStyles.containerTitle,
                            "Areas of Improvements",
                          ).marginSymmetric(
                            vertical: 10,
                          ),
                          ...generateColoredPaddedList(
                            {
                              "Emergency Planning": 75,
                              "Long-term Investment": 84,
                              "Risk Management": 76,
                            },
                            Colors.orange,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            //Student Distribution Box
            ShadowedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Student Distribution",
                    style: TextStyles.containerTitle,
                  ),
                  //Performance Reflection+Distribution
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ColoredPaddedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Top Performers",
                                style: TextStyles.containerTitle.copyWith(
                                  fontSize: 18,
                                  color: LightTheme().pastelGreen,
                                ),
                              ),
                              Text(
                                teacherDashboardController
                                    .topPerformers.value.length
                                    .toString(),
                                style: TextStyles.containerTitle.copyWith(
                                  fontSize: 30,
                                  color: LightTheme().pastelGreen,
                                ),
                              ),
                              Text(
                                "Above 85%",
                                style: TextStyles.containerTitle.copyWith(
                                  fontSize: 18,
                                  color: LightTheme().pastelGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: ColoredPaddedContainer(
                          color: Colors.blue.withValues(alpha: 0.2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Average",
                                style: TextStyles.containerTitle.copyWith(
                                  fontSize: 18,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                (teacherDashboardController
                                            .classRoomStudents.value.length -
                                        (teacherDashboardController
                                                .topPerformers.value.length +
                                            teacherDashboardController
                                                .supportStudents.value.length))
                                    .toString(),
                                style: TextStyles.containerTitle.copyWith(
                                  fontSize: 30,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                "70 - 85%",
                                style: TextStyles.containerTitle.copyWith(
                                  fontSize: 18,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: ColoredPaddedContainer(
                          color: Colors.orange.withValues(alpha: 0.2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Needs Support",
                                style: TextStyles.containerTitle.copyWith(
                                  fontSize: 18,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                teacherDashboardController
                                    .supportStudents.value.length
                                    .toString(),
                                style: TextStyles.containerTitle.copyWith(
                                  fontSize: 30,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                "Below 70%",
                                style: TextStyles.containerTitle.copyWith(
                                  fontSize: 18,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ShadowedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Suggested Actions",
                    style: TextStyles.containerTitle,
                  ),
                  ColoredPaddedContainer(
                    color: Colors.blue.withValues(alpha: 0.2),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Review Emergency Planning",
                          style: TextStyles.containerTitle.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          "Consider dedicating more time to emergency fund concepts, as 99% of studets scored below target in thiss area.",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ColoredPaddedContainer(
                    color: Colors.purple.withValues(alpha: 0.2),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Group Activity",
                          style: TextStyles.containerTitle.copyWith(
                            color: Colors.purple,
                          ),
                        ),
                        Text(
                          "Consider dedicating more time to emergency fund concepts, as 99% of studets scored below target in thiss area.",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  generateColoredPaddedList(Map<String, double> li, Color color) {
    TextStyle customStyle = TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: FontWeight.bold,
    );
    return li.entries.map(
      (entry) => ColoredPaddedContainer(
        color: color.withValues(alpha: 0.2),
        padding: EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 30,
        ),
        child: Row(
          children: [
            Text(
              entry.key,
              style: customStyle,
            ),
            const Spacer(),
            Text(
              "${entry.value}%",
              style: customStyle,
            ),
          ],
        ),
      ),
    );
  }
}
