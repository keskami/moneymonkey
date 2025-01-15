import 'package:flutter/material.dart';
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
  final List<String> classes = [];
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
    return Column(
      children: [
        Text(
          "Teacher Dashboard",
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
        ),
        DashboardSubPageSelector(),
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
      ],
    );
  }
}
