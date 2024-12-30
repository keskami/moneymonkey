import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/LessonOneController.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/ShadowedBoxContainer.dart';

class L1Reflection extends StatefulWidget {
  const L1Reflection({super.key});

  @override
  State<L1Reflection> createState() => _L1ReflectionState();
}

class _L1ReflectionState extends State<L1Reflection> {
  List<List<String>> takeAways = [
    [
      "Early habits matter",
      "Starting even with small amounts when young helps build bigger savings over time."
    ],
    [
      "Budgeting at Every Stage",
      "From first job to retirement, a budget reduces overspending and increases savings."
    ],
    [
      "Preparedness for Changes",
      "Plan for life transitions—like family or job changes—by maintaining an emergency fund."
    ],
    [
      "Never Too Late to Improve",
      "Even close to retirement, you can still refine your budget and investment approach for a more secure future."
    ],
  ];
  String pageHeading = "Lifelong Financial Responsibility";
  LessonOneController lessonOneController = Get.find();
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  TextEditingController personalReflectionController =
      new TextEditingController();

  SnackBar correctAnswer = CorrectAnswerSnackBar(
    message:
        "Yes! Consistent budgeting helps\nensure savings last throughout\nretirement.",
  );

  SnackBar wrongAnswer = WrongAnswerSnackBar(
    message:
        "Coins have been used since\naround 600 B.C., making them the\noldest form of money still in use.",
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).clearSnackBars();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight
        ? webDisplay(screenWidth, screenHeight)
        : mobileDisplay();
  }

  webDisplay(double screenWidth, double screenHeight) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: screenWidth * 0.02),
            //Heading
            Text(
              "Key Takeaways: $pageHeading",
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 27,
              ),
            ).marginSymmetric(
                vertical: screenHeight * 0.025,
                horizontal: screenWidth * 0.015),

            SizedBox(
              height: screenHeight * 0.03,
            ),
            //Backgroud Shadowed Container
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...takeAways.map((takeaway) {
                  return ShadowedBoxContainer(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Ftakeaway_check.png?alt=media&token=9a389932-5562-4c38-a970-9ecd6bf8adcb"),
                          ),
                          Text(
                            "  ${takeaway[0]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Text(
                        takeaway[1],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ));
                }).toList(),
                //Reflection
                ShadowedBoxContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal Reflection",
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ).marginOnly(
                        bottom: screenHeight * 0.03,
                      ),
                      TextField(
                        maxLines: 4,
                        autocorrect: true,
                        controller: personalReflectionController,
                        onTapOutside: (event) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          hintText:
                              "What’s one new financial habit you’ll adopt this month?",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              children: [
                const Spacer(),
                CustomNextButton(
                  nextPage: () {},
                  isEnabled: personalReflectionController.text.isNotEmpty,
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
          ],
        ).paddingSymmetric(horizontal: screenWidth * 0.25),
      ),
    );
  }

  mobileDisplay() {}
}
