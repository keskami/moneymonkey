import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Models/settings.dart';
import 'package:money_monkey/Backend/Services/StudentServices.dart';
import 'package:money_monkey/Resources/Resources.dart';
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
  // LocalAcademicService _localAcademicService = LocalAcademicService();
  Map<String, List<Student>> categorizedStudents = {};
  // final List<List<String>> topPerformerStudents = [
  //   [
  //     "Kid 1",
  //     "98",
  //   ],
  //   [
  //     "Kid 2",
  //     "98",
  //   ],
  // ];
  // final List<List<String>> supportStudents = [
  //   [
  //     "Kid 1",
  //     "34",
  //   ],
  //   [
  //     "Kid 2",
  //     "12",
  //   ],
  // ];
  final Map<String, String> actions = {
    "What about those \$150 sneakers?": "Wait for next paycheck",
    "Planning for Emergencies": "Set aside \$150",
    "What about those \$120 sneakers?": "Wait for next paycheck",
  };
  final TeacherDashboardController teacherDashboardController = Get.find();
  int selectedStudentIndex = 0; // Change to nullable
  Student selectedStudent = Student(
    studentId: "S123456",
    email: "john.doe@example.com",
    phoneNumber: "+1234567890",
    age: 22,
    knowledgeLevel: 3,
    learningGoalPerDay: 5,
    startingLevel: 1,
    classRooms: ['tempClassId1_2025', 'tempClassId2_2025'],
    progress: "A.1.2.6",
    profile: ProfileData(
      fullName: "John Doe",
      username: "john_doe_25",
      numberOfFollowers: 1500,
      following: 180,
      topAchievements: 5,
      streak: 30,
      totalProfit: 2500.75,
      portfolioScore: 88.4,
      averageMonthlyGrowth: 7.5,
    ),
    settings: SettingsData(
      preferences: Preferences(
        soundEffects: true,
        audio: true,
        darkMode: true,
      ),
      notifications: Notifications(
        reminders: RemindersNotifications(
          practiceEmail: true,
          practicePhone: false,
          weeklyProgress: true,
          reminderTime: '07:30 AM',
        ),
        friends: FriendsNotifications(
          newFollowerEmail: true,
          newFollowerPhone: false,
          friendActivityEmail: true,
          friendActivityPhone: false,
        ),
        announcements: AnnouncementsNotifications(
          marketingNotificationsEmail: true,
          marketingNotificationsPhone: true,
          educationalTipsEmail: false,
          educationalTipsPhone: true,
        ),
      ),
      privacySettings: PrivacySettings(publicProfile: true),
    ),
  );
  late StudentService studentService;
  void selectStudent(int index) {
    if (index < widget.classStudents.length) {
      setState(() => selectedStudentIndex = index);
    }
  }

  void setSelectedStudent(int index) {
    setState(() {
      selectedStudentIndex = index;
      selectedStudent = widget.classStudents[index];
      studentService = StudentService(student: selectedStudent);
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.classStudents.isNotEmpty) {
      selectedStudentIndex = 0;
      selectedStudent = widget.classStudents[0];
      studentService = StudentService(student: widget.classStudents[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Widget.ClassStudents: ${widget.classStudents}");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return widget.classStudents.isEmpty
        ? SizedBox(
            child:
                Text("Either there are no students, or they're being loaded."),
          )
        : Row(
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
                                  selectedStudent.profile.fullName,
                                  style: TextStyles.containerTitle,
                                ),
                                Text(
                                  "Current Lesson: ",
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
                              color: LightTheme()
                                  .pastelGreen
                                  .withValues(alpha: 0.3),
                              child: Text(
                                studentService.getStatusFromProgress().name,
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
                                    value: studentService.getLessonProgress(),
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
                                    value: studentService.getOverallProgress(),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
    if (students.isEmpty) {
      students = [
        Student(
          studentId: "S123456",
          email: "john.doe@example.com",
          phoneNumber: "+1234567890",
          age: 22,
          knowledgeLevel: 3,
          learningGoalPerDay: 5,
          startingLevel: 1,
          classRooms: ['tempClassId1_2025', 'tempClassId2_2025'],
          progress: "A.1.2.6",
          profile: ProfileData(
            fullName: "John Doe",
            username: "john_doe_25",
            numberOfFollowers: 1500,
            following: 180,
            topAchievements: 5,
            streak: 30,
            totalProfit: 2500.75,
            portfolioScore: 88.4,
            averageMonthlyGrowth: 7.5,
          ),
          settings: SettingsData(
            preferences: Preferences(
              soundEffects: true,
              audio: true,
              darkMode: true,
            ),
            notifications: Notifications(
              reminders: RemindersNotifications(
                practiceEmail: true,
                practicePhone: false,
                weeklyProgress: true,
                reminderTime: '07:30 AM',
              ),
              friends: FriendsNotifications(
                newFollowerEmail: true,
                newFollowerPhone: false,
                friendActivityEmail: true,
                friendActivityPhone: false,
              ),
              announcements: AnnouncementsNotifications(
                marketingNotificationsEmail: true,
                marketingNotificationsPhone: true,
                educationalTipsEmail: false,
                educationalTipsPhone: true,
              ),
            ),
            privacySettings: PrivacySettings(publicProfile: true),
          ),
        ),
      ];
    }

    return List.generate(students.length, (index) {
      print("****************Entered List Generate");
      final student = students[index];
      print("****************Student= ${student.profile.fullName}");
      final StudentService studentService = StudentService(student: student);
      print("****************Got studentService $studentService");
      final lessonProgress = studentService.getLessonProgress();
      print("************Retrieved lesson Progress $lessonProgress");

      final unitProgress = studentService.getOverallProgress();
      print("************Retrieved Unit Progress $unitProgress");

      StudentStatus status;
      Color progressColor;

      if (lessonProgress > 1) {
        status = StudentStatus.Ahead;
        progressColor = LightTheme().primaryBlue;
      } else if (lessonProgress > 0.6) {
        status = StudentStatus.On_Track;
        progressColor = LightTheme().pastelGreen;
      } else {
        status = StudentStatus.Behind;
        progressColor = LightTheme().pastelRed;
      }
      print("************Retrieved status:${status.name}");
      print("************Retrieved Color: $progressColor");

      return GestureDetector(
        onTap: () => setSelectedStudent(index),
        child: ColoredPaddedContainer(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          color: selectedStudentIndex == index
              ? LightTheme().primaryBlue.withValues(alpha: 0.2)
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
                color: progressColor.withValues(alpha: 0.3),
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
