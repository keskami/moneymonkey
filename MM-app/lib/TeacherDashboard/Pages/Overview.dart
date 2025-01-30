import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/CustomDropDownMenu.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class DashboardOverview extends StatefulWidget {
  const DashboardOverview({super.key});

  @override
  State<DashboardOverview> createState() => _DashboardOverviewState();
}

class _DashboardOverviewState extends State<DashboardOverview> {
  final String teacherName = "Mrs. Anderson";
  final String progressStatus = "In-progress";
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
  final List<List<String>> componentsList = [
    ["Recap", "100"],
    ["Concept 1", "100"],
    ["Interactive Activity 1", "100"],
    ["Concept 2", "80"],
    ["Interactive Activity 2", "0"],
    ["Story", "0"],
    ["Scenario Simulation", "0"],
    ["Peer Reflection", "0"],
    ["Toolkit", "0"],
    ["Quiz", "0"],
  ];
  final List<List<String>> topPerformerStudents = [
    [
      "Kid 1",
      "98",
    ],
    [
      "Kid 2",
      "98",
    ],
  ];
  final List<List<String>> supportStudents = [
    [
      "Kid 1",
      "34",
    ],
    [
      "Kid 2",
      "12",
    ],
  ];
  final TeacherDashboardController teacherDashboardController = Get.find();
  final List<Color> randomColorList = [
    Color.fromARGB(255, 122, 180, 255),
    Color.fromARGB(255, 189, 122, 255),
    Color.fromARGB(255, 123, 255, 169),
  ];
  final Map<String, List<String>> discussionQuestions = {
    "Recap": [
      "When should financial responsibility begin?",
      "How do financial decisions impact our future?",
      "What role do emergency funds play?",
    ],
    "Concept 1": [
      "When should financial responsibility begin?",
      "How do financial decisions impact our future?",
      "What role do emergency funds play?",
    ],
    "Interactive Activity 1": [
      "When should financial responsibility begin?",
      "How do financial decisions impact our future?",
      "What role do emergency funds play?",
    ],
    "Concept 2": [
      "When should financial responsibility begin?",
      "How do financial decisions impact our future?",
      "What role do emergency funds play?",
    ],
    "Interactive Activity 2": [
      "When should financial responsibility begin?",
      "How do financial decisions impact our future?",
      "What role do emergency funds play?",
    ],
    "Story": [
      "When should financial responsibility begin?",
      "How do financial decisions impact our future?",
      "What role do emergency funds play?",
    ],
    "Scenario Simulation": [
      "When should financial responsibility begin?",
      "How do financial decisions impact our future?",
      "What role do emergency funds play?",
    ],
    "Peer Reflection": [
      "When should financial responsibility begin?",
      "How do financial decisions impact our future?",
      "What role do emergency funds play?",
    ],
    "Toolkit": [
      "When should financial responsibility begin?",
      "How do financial decisions impact our future?",
      "What role do emergency funds play?",
    ],
    "Quiz": [
      "When should financial responsibility begin?",
      "How do financial decisions impact our future?",
      "What role do emergency funds play?",
    ],
  };
  String discussionComponent = "Concept 2";
  //handles Change in selecting another Lesson Component to get discussion questions for
  void onDiscussionComponentChanged(String? lesson) {
    if (lesson != null) {
      setState(() {
        discussionComponent = lesson;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          //Lesson Progress Container
          ShadowedContainer(
            margin: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              children: [
                //Current Progress and Status Row
                Row(
                  children: [
                    Text(
                      "Current Lesson Progress",
                      style: TextStyles.containerTitle,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          LightTheme().primaryBlue.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        progressStatus,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue.shade300,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                //Green Title for Overview
                ColoredPaddedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message1,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        message2,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                //Lessons and respective status
                ...componentsList.map(
                  (lesson) => Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.transparent,
                        child: teacherDashboardController
                                    .getProgress(lesson[1]) ==
                                'Completed'
                            ? Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FCheck%20circle.png?alt=media&token=52726418-7a0a-4b6c-9207-1efa735199af",
                              )
                            : Container(
                                width: 20,
                                height: 20,
                                child: teacherDashboardController
                                            .getProgress(lesson[1]) ==
                                        'In Progress'
                                    ? CircularProgressIndicator(
                                        value: double.parse(lesson[1]) / 100,
                                        strokeWidth: 2,
                                      )
                                    : CircularProgressIndicator(
                                        value: 1,
                                        strokeWidth: 2,
                                        color: Colors.grey,
                                      ),
                              ),
                      ),
                      Text(
                        lesson[0],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ).marginOnly(
                        left: 10,
                      ),
                      const Spacer(),
                      Text(
                        teacherDashboardController.getProgress(lesson[1]),
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ).marginOnly(
                        right: 20,
                      ),
                    ],
                  ).marginSymmetric(
                    vertical: 6,
                  ),
                ),
              ],
            ),
          ),
          //Quick Actions(Suggestions Container)
          ShadowedContainer(
            margin: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
            ),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.01,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyles.containerTitle,
                ),
                ...quickActionsSuggestions.map(
                  (suggestion) => Container(
                    margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.01,
                      vertical: screenHeight * 0.02,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: randomColorList[
                              quickActionsSuggestions.indexOf(suggestion)]
                          .withValues(alpha: 0.1),
                    ),
                    child: Text(
                      suggestion,
                      style: TextStyle(
                        fontSize: 16,
                        color: randomColorList[
                            quickActionsSuggestions.indexOf(suggestion)],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          //Discussion Container
          ShadowedContainer(
            margin: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
            ),
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.01,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Discussion Questions",
                  style: TextStyles.containerTitle,
                ),
                CustomDropDownContainer(
                  initialSelection: discussionComponent,
                  width: screenWidth * 0.15,
                  items: componentsList
                      .map(
                        (e) => e[0],
                      )
                      .toList(),
                  onChanged: onDiscussionComponentChanged,
                ).marginSymmetric(
                  vertical: screenHeight * 0.01,
                ),
                ...discussionQuestions[discussionComponent]!
                    .map((question) => Container(
                          margin: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.015,
                            horizontal: screenWidth * 0.02,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue.withValues(alpha: 0.1),
                          ),
                          child: Text(
                            question,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),

          //Performance Highlights Container
          ShadowedContainer(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.01,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Performance Highlights",
                  style: TextStyles.containerTitle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    //Top Performers Container
                    Container(
                      width: screenWidth * 0.2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Top Performers",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ...topPerformerStudents.map(
                            (student) => Row(
                              children: [
                                Text(
                                  student[0],
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "${student[1]}%",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            ).marginSymmetric(
                              vertical: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    //Support Students Container
                    Container(
                      width: screenWidth * 0.2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Needs Support",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ...supportStudents.map(
                            (student) => Row(
                              children: [
                                Text(
                                  student[0],
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "${student[1]}%",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ).marginSymmetric(
                              vertical: 5,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Knowledge & Application",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 10,
                  width: screenWidth * 0.65,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    value: 0.7,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Effort & Management",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 10,
                  width: screenWidth * 0.65,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    value: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
