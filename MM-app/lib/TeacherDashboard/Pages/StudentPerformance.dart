import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Resources/Resources.dart';
import 'package:money_monkey/TeacherDashboard/Backend/SampleDataFille.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ColoredPaddedContainer.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';
import 'package:money_monkey/themes/color_themes.dart';

class StudentPerformace extends StatefulWidget {
  const StudentPerformace({
    super.key,
    required this.classStudents,
  });
  final List<Student> classStudents;
  @override
  State<StudentPerformace> createState() => _StudentPerformaceState();
}

class _StudentPerformaceState extends State<StudentPerformace> {
  Map<String, List<Student>> categorizedStudents = {};
  void getCategorizedStudents() {}
  int selectedStudentIndex = 0;
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
  final Map<String, String> actions = {
    "What about those \$150 sneakers?": "Wait for next paycheck",
    "Planning for Emergencies": "Set aside \$150",
    "What about those \$120 sneakers?": "Wait for next paycheck",
  };
  final TeacherDashboardController teacherDashboardController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ShadowedContainer(
            height: screenHeight * 0.85, // Increased from 0.65
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Students",
                  style: TextStyles.containerTitle,
                ),
                FilterStudentsButton(filter: "All Students"),
                FilterStudentsButton(filter: "Top Performers"),
                FilterStudentsButton(filter: "Needs Support"),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...showStudents(
                          widget.classStudents,
                          screenWidth,
                          screenHeight,
                        ),
                      ],
                    ),
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
          flex: 5,
          child: ShadowedContainer(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.02,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Student and Lesson Info Row
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Student Name",
                            style: TextStyles.containerTitle,
                          ),
                          Text(
                            "Current Lesson: Financial Responsibility",
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ColoredPaddedContainer(
                        width: screenWidth * 0.08,
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        color: LightTheme().pastelGreen.withValues(alpha: 0.3),
                        child: Text(
                          "On-Track",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: LightTheme().pastelGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  //Progress Row
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lesson Progress",
                              style: TextStyles.containerTitle.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Current Lesson",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            LinearProgressIndicator(
                              backgroundColor: Colors.grey.shade300,
                              minHeight: 10,
                              borderRadius: BorderRadius.circular(10),
                              value: 0.76,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Overall Progress",
                              style: TextStyles.containerTitle.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Course Completion",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            LinearProgressIndicator(
                              backgroundColor: Colors.grey.shade300,
                              minHeight: 10,
                              borderRadius: BorderRadius.circular(10),
                              value: 0.76,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Recent Progress",
                    style: TextStyles.containerTitle,
                  ),
                  ...actions.entries
                      .map(
                        (entry) => ColoredPaddedContainer(
                          child: Row(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.key,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    entry.value,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.transparent,
                                child: Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FCheck%20circle.png?alt=media&token=52726418-7a0a-4b6c-9207-1efa735199af",
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "See more",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Iterable<Widget> showStudents(
    List<Student> students,
    double screenWidth,
    double screenHeight,
  ) {
    final currentClassroom =
        sampleClassrooms[teacherDashboardController.classId.value];
    if (currentClassroom == null) return [];

    return students.map((student) {
      final status =
          student.getCurrentLessonProgress(currentClassroom.lessonId);
      final unitId = currentClassroom.lessonId.split('.').take(2).join('.');
      final unitProgress = student.getCurrentUnitProgress(unitId);

      Color progressColor;
      switch (status) {
        case StudentStatus.Ahead:
          progressColor = LightTheme().primaryBlue;
          break;
        case StudentStatus.On_Track:
          progressColor = LightTheme().pastelGreen;
          break;
        default:
          progressColor = LightTheme().pastelRed;
      }

      bool isSelected = students.indexOf(student) == selectedStudentIndex;

      return GestureDetector(
        onTap: () =>
            setState(() => selectedStudentIndex = students.indexOf(student)),
        child: ColoredPaddedContainer(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          color: isSelected
              ? LightTheme().primaryBlue.withOpacity(0.2)
              : Colors.transparent,
          child: Row(
            children: [
              Text(
                student.profile.fullName,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade500,
                ),
              ),
              const Spacer(),
              ColoredPaddedContainer(
                width: screenWidth * 0.06,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                color: progressColor.withOpacity(0.3),
                child: Text(
                  status.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: progressColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (unitProgress > 0)
                Container(
                  width: 60,
                  margin: EdgeInsets.only(left: 8),
                  child: Text(
                    '${(unitProgress * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

class FilterStudentsButton extends StatelessWidget {
  const FilterStudentsButton({
    super.key,
    required this.filter,
  });
  final String filter;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
      ),
      child: Text(
        filter,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}
