import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/SubPageSelectorRow.dart';
import 'package:money_monkey/themes/color_themes.dart';

class DashboardOverview extends StatefulWidget {
  const DashboardOverview({super.key});

  @override
  State<DashboardOverview> createState() => _DashboardOverviewState();
}

class _DashboardOverviewState extends State<DashboardOverview> {
  final String teacherName = "Mrs. Anderson";
  final String progressStatus = "In-Progress";
  final String message1 = "Financial Responsibility Over a Lifetime ";
  final String message2 =
      "Making informed decisions about earning, saving, spending, and investing ";
  final List<String> classes = [
    'All Classes',
    'Batch 1',
    'Batch 2',
    'Batch 3',
    'Batch 4',
  ];
  final List<String> quickActionsSuggestions = [
    "Launch “Jordan’s Journey Scenario”",
    "Start “Emergency Fun Challenge”",
    "Begin “Spending Decisions Quiz”",
  ];
  final List<String> lessonList = [
    "Recap",
    "Concept 1",
    "Interactive Activity 1",
    "Concept  2",
    "Interactive Activity 2",
    "Story",
    "Scenario Simulation",
    "Peer Reflection",
    "Toolkit",
    "Quiz",
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Teacher Dashboard",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 25,
            ),
            Text(
              "Welcome,\n $teacherName",
            ),
            const Spacer(),
            DropdownMenu(
              label: Text("Class"),
              dropdownMenuEntries: [
                ...classes.map(
                  (e) => DropdownMenuEntry(
                    value: "",
                    label: e,
                  ),
                ),
              ],
            ),
          ],
        ).marginSymmetric(
          horizontal: screenWidth * 0.05,
        ),
        DashboardSubPageSelector().marginSymmetric(
          horizontal: screenWidth * 0.05,
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ),
          height: screenHeight * 0.8,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
            ),
            child: Column(
              children: [
                //Lesson Progress Container
                Container(
                  child: Column(
                    children: [
                      //Current Progress and Status Row
                      Row(
                        children: [
                          Text(
                            "Current Lesson Progress",
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              progressStatus,
                            ),
                          ),
                        ],
                      ),
                      //Green Title for Overview
                      Container(
                        color: LightTheme().pastelGreen,
                        child: Column(
                          children: [
                            Text(
                              message1,
                            ),
                            Text(
                              message2,
                            ),
                          ],
                        ),
                      ),
                      //Lessons and respective status
                      ...lessonList.map(
                        (lesson) => Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.green,
                            ),
                            Text(
                              lesson,
                            ),
                            const Spacer(),
                            Text("Lesson Status"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Quick Actions(Suggestions Container)
                ShadowedContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Quick Actions",
                      ),
                      ...quickActionsSuggestions.map(
                        (suggestion) => ListTile(
                          tileColor: LightTheme().pastelGreen,
                          leading: Text(
                            suggestion,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ShadowedContainer(
                  child: Column(
                    children: [
                      DropdownMenu(
                        dropdownMenuEntries: [],
                      ),
                      ...quickActionsSuggestions.map(
                        (suggestion) => ListTile(
                          tileColor: LightTheme().pastelGreen,
                          leading: Text(
                            suggestion,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Performance Highlights Container
                ShadowedContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Performance Highlights",
                      ),
                      Row(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Top Performers",
                              ),
                              const Text(
                                "Child 1",
                              ),
                              const Text(
                                "Child 2",
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Needs Support",
                              ),
                              const Text(
                                "Child 1",
                              ),
                              const Text(
                                "Child 2",
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Text(
                  "Knowledge & Application",
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 10,
                      width: screenWidth * 0.5,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        value: 0.7,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Effort & Management",
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 10,
                      width: screenWidth * 0.5,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        value: 0.4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ).marginSymmetric(
      horizontal: screenWidth * 0.1,
    );
  }
}
