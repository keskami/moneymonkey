import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/StudentServices.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/CustomDropDownMenu.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/PlaceHolderTab.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class DashboardOverview extends StatefulWidget {
  const DashboardOverview({
    super.key,
  });
  @override
  State<DashboardOverview> createState() => _DashboardOverviewState();
}

class _DashboardOverviewState extends State<DashboardOverview> {
  final TeacherDashboardController teacherDashboardController = Get.find();
  LocalAcademicService localAcademicService = LocalAcademicService();

  @override
  void initState() {
    super.initState();
  }

  void onDiscussionComponentChanged(String? componentName) {
    if (componentName != null) {
      // Find the component ID for the selected name
      String? selectedComponent =
          teacherDashboardController.childComponents.value
              .firstWhere(
                (entry) => entry.title == componentName,
              )
              .title;

      if (selectedComponent.isNotEmpty) {
        setState(() {
          teacherDashboardController.selectedComponent =
              teacherDashboardController.childComponents.value
                  .firstWhere((comp) => comp.title == componentName);
        });
      }
    }
  }

  Widget getProgressIndicator(Status status) {
    switch (status) {
      case Status.Completed:
        return Image.network(
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FCheck%20circle.png?alt=media&token=52726418-7a0a-4b6c-9207-1efa735199af",
        );
      case Status.InProgress:
        return CircularProgressIndicator(
          value: double.parse("24") / 100,
          strokeWidth: 2,
        );
      case Status.Active:
        return CircularProgressIndicator(
          value: 0.1,
          strokeWidth: 2,
        );
      case Status.Inactive:
      default:
        return CircularProgressIndicator(
          value: 1,
          strokeWidth: 2,
          color: Colors.grey,
        );
    }
  }

  final List<Color> randomColorList = [
    Color.fromARGB(255, 122, 180, 255),
    Color.fromARGB(255, 189, 122, 255),
    Color.fromARGB(255, 123, 255, 169),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    if (teacherDashboardController.selectedClassId.isEmpty)
      return TeacherDashoardPlaceHolderPage();
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
                        teacherDashboardController.presentLesson.lessonStatus.name,
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
                        teacherDashboardController.overviewMessage1,
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
                        teacherDashboardController.overviewMessage1,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                //Lessons and respective status
                Obx(() => Column(
                      children: [
                        ...teacherDashboardController.childComponents.value.map(
                          (component) {
                            return Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    child: getProgressIndicator(
                                        component.componentStatus),
                                  ),
                                ),
                                Text(
                                  component.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).marginOnly(
                                  left: 10,
                                ),
                                const Spacer(),
                                Text(
                                  component.componentStatus.name,
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
                            );
                          },
                        ),
                      ],
                    )),
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
                ...teacherDashboardController.quickActionsSuggestions.map(
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
                      color: randomColorList[teacherDashboardController
                              .quickActionsSuggestions
                              .indexOf(suggestion)]
                          .withValues(alpha: 0.1),
                    ),
                    child: Text(
                      suggestion,
                      style: TextStyle(
                        fontSize: 16,
                        color: randomColorList[teacherDashboardController
                            .quickActionsSuggestions
                            .indexOf(suggestion)],
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
            width: double.infinity,
            height: screenHeight * 0.3,
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
                  initialSelection:
                      teacherDashboardController.selectedComponent.title,
                  width: screenWidth * 0.3,
                  items: teacherDashboardController.componentNames.value,
                  onChanged: onDiscussionComponentChanged,
                ).marginSymmetric(
                  vertical: screenHeight * 0.01,
                ),
                if (teacherDashboardController
                            .selectedComponent.discussionQuestions !=
                        null &&
                    teacherDashboardController
                        .selectedComponent.discussionQuestions!.isNotEmpty)
                  ...teacherDashboardController
                      .selectedComponent.discussionQuestions!
                      .map((question) => Container(
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Top Performers Container
                    Container(
                      width: screenWidth * 0.2,
                      child: Column(
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
                          // Using Obx to observe topPerformers List changes
                          Column(
                            children: [
                              ...teacherDashboardController.topPerformers.value
                                  .map(
                                (student) => Row(
                                  children: [
                                    Text(
                                      student.profile.fullName,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "${StudentService(student: student).getLessonProgress()}%",
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
                          // Using Obx to observe supportStudents List changes
                          Column(
                            children: [
                              ...teacherDashboardController
                                  .supportStudents.value
                                  .map(
                                (student) => Row(
                                  children: [
                                    Text(
                                      student.profile.fullName,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "${StudentService(student: student).getLessonProgress()}%",
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

extension on Color {
  Color? withValues({required double alpha}) {}
}
