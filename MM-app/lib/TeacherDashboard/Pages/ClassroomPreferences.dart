import 'dart:js_interop';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/TeacherDashboard/Backend/Model.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/CustomDropDownMenu.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/PerformanceTrendCharts.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class ClassroomPreferences extends StatefulWidget {
  const ClassroomPreferences({super.key});

  @override
  State<ClassroomPreferences> createState() => _ClassroomPreferencesState();
}

final List<PerformanceData> samplePerformanceData = [
  PerformanceData(
    label: "Recap",
    classAverage: 65.0, // Blue line starts lower
    participationRate: 75.0, // Green line starts high
    lessonCompletion: 70.0, // Purple line starts in middle
  ),
  PerformanceData(
    label: "Concept 1",
    classAverage: 75.0, // Blue line rises
    participationRate: 85.0, // Green line peaks
    lessonCompletion: 68.0, // Purple line slightly drops
  ),
  PerformanceData(
    label: "Interactive Activity 1",
    classAverage: 80.0, // Blue line continues rising
    participationRate: 70.0, // Green line drops
    lessonCompletion: 58.0, // Purple line drops more
  ),
  PerformanceData(
    label: "Concept 2",
    classAverage: 70.0, // Blue line dips
    participationRate: 65.0, // Green line continues dropping
    lessonCompletion: 90.0, // Purple line shoots up
  ),
  PerformanceData(
    label: "Interactive Activity 2",
    classAverage: 82.0, // Blue line peaks
    participationRate: 80.0, // Green line recovers
    lessonCompletion: 85.0, // Purple line stays high
  ),
  PerformanceData(
    label: "Story",
    classAverage: 75.0, // Blue line drops at end
    participationRate: 65.0, // Green line drops at end
    lessonCompletion: 60.0, // Purple line drops at end
  ),
  PerformanceData(
    label: "Scenario Simulation",
    classAverage: 82.0, // Blue line peaks
    participationRate: 80.0, // Green line recovers
    lessonCompletion: 85.0, // Purple line stays high
  ),
  PerformanceData(
    label: "Peer Reflection",
    classAverage: 82.0, // Blue line peaks
    participationRate: 80.0, // Green line recovers
    lessonCompletion: 85.0, // Purple line stays high
  ),
  PerformanceData(
    label: "Toolkit",
    classAverage: 80.0, // Blue line continues rising
    participationRate: 70.0, // Green line drops
    lessonCompletion: 58.0, // Purple line drops more
  ),
  PerformanceData(
    label: "Quiz",
    classAverage: 82.0, // Blue line peaks
    participationRate: 80.0, // Green line recovers
    lessonCompletion: 85.0, // Purple line stays high
  ),
];

class _ClassroomPreferencesState extends State<ClassroomPreferences> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
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
                          items: [],
                          onChanged: (stat) {},
                          width: screenWidth * 0.1),
                    ],
                  ),
                ),
                PerformanceTrendsChart(
                  data: samplePerformanceData,
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.7,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: ShadowedContainer(
                    child: Column(
                      children: [
                        Text(
                          "Areas of Strength",
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
                      children: [
                        Text(
                          "Areas of Improvements",
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
              children: [
                Text(
                  "Student Distribution",
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ColoredPaddedContainer(
                        child: Column(
                          children: [
                            Text(
                              "Top Performers",
                            ),
                            Text(
                              "6",
                            ),
                            Text(
                              "Above 85%",
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
                        child: Column(
                          children: [
                            Text(
                              "Top Performers",
                            ),
                            Text(
                              "6",
                            ),
                            Text(
                              "Above 85%",
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
                        child: Column(
                          children: [
                            Text(
                              "Top Performers",
                            ),
                            Text(
                              "6",
                            ),
                            Text(
                              "Above 85%",
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
                  child: Column(
                    children: [
                      Text("Review Emergency Planning"),
                      Text(
                          "Consider dedicating more time to emergency fund concepts, as 99% of studets scored below target in thiss area."),
                    ],
                  ),
                ),
                ColoredPaddedContainer(
                  child: Column(
                    children: [
                      Text("Group Activity"),
                      Text(
                          "Consider dedicating more time to emergency fund concepts, as 99% of studets scored below target in thiss area."),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
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
