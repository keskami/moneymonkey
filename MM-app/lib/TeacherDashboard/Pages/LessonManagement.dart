import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';

class LessonManagement extends StatefulWidget {
  const LessonManagement({super.key});

  @override
  State<LessonManagement> createState() => _LessonManagementState();
}

class _LessonManagementState extends State<LessonManagement> {
  final String message1 = "Financial Responsibility Over a Lifetime ";
  final String message2 =
      "Making informed decisions about earning, saving, spending, and investing ";
  final List<List<String>> lessonList = [
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
  final TeacherDashboardController teacherDashboardController = Get.find();
  final String nextLessonTitle = "Smart Spending Decisions";
  final String nextLessonDescription =
      "Learning to make informed purchase decisions and understanding the val,ue  of money  through practical exercises and real-world scenarios.";
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        //Lesson Actions Container
        ShadowedContainer(
          margin: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lesson Management",
                style: TextStyles.containerTitle,
              ),
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
              ...lessonList.map(
                (lesson) => ColoredPaddedContainer(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.01,
                    vertical: screenHeight * 0.01,
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                  ),
                  color: Colors.grey.shade100,
                  child: Row(
                    children: [
                      //Completion Reflection Icon
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
                                      )),
                      ),
                      //Component Name
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
                      //Action Button
                      GestureDetector(
                        child: Container(
                          width: screenWidth * 0.1,
                          height: screenHeight * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              teacherDashboardController.getLessonAction(
                                lesson[1],
                              ),
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).marginSymmetric(
                    vertical: 6,
                  ),
                ),
              ),
            ],
          ),
        ),
        //Resources Row
        ShadowedContainer(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lesson Resources",
                style: TextStyles.containerTitle,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ColoredPaddedContainer(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: screenHeight * 0.02,
                      ),
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: Image.network(
                              AppResources.interactiveAtivityGuide,
                            ),
                          ),
                          Text(
                            "Interactive Activity Guide",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ColoredPaddedContainer(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: screenHeight * 0.02,
                      ),
                      color: Color.fromARGB(255, 239, 246, 255),
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: Image.network(
                              AppResources.teachersGuide,
                            ),
                          ),
                          Text(
                            "Teacher’s Guide",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ColoredPaddedContainer(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: screenHeight * 0.02,
                      ),
                      color: Color.fromARGB(255, 250, 245, 255),
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: Image.network(
                              AppResources.studentWorkshopTemplate,
                            ),
                          ),
                          Text(
                            "Student Worksheet Template",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ColoredPaddedContainer(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: screenHeight * 0.02,
                      ),
                      color: Color.fromARGB(255, 255, 236, 213),
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FTeacher%20Dashboard%2FLesson%20management%2FIcon4.png?alt=media&token=aabe9c04-773a-4e47-af73-25aedd6a3612",
                            ),
                          ),
                          Text(
                            "Teacher’s Guide",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        //Upcoming Lesson Row
        ShadowedContainer(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upcoming Lesson",
                style: TextStyles.containerTitle,
              ),
              ColoredPaddedContainer(
                margin: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade100,
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nextLessonTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      nextLessonDescription,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
