import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/ShadowedBoxContainer.dart';
import 'package:money_monkey/home.dart';

class ComponentTakeawaysPage extends StatefulWidget {
  const ComponentTakeawaysPage({super.key});

  @override
  State<ComponentTakeawaysPage> createState() => _ComponentTakeawaysPageState();
}

class _ComponentTakeawaysPageState extends State<ComponentTakeawaysPage> {
  List<List<String>> takeAways = [
    [],
    [],
    [],
    [],
  ];

  String title = "";
  ComponentOneTwoController componentOneTwoController = Get.find();

  bool loading = true;
  String subTitle = '';
  String hint = '';
  String image = '';
  List<String> takeawayList = [];

  Future<void> setData(data) async {
    setState(() {
      title = data.data.title;
      subTitle = "Personal Reflection";
      hint = data.data.hint;
      image =
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2Ftakeaway_check.png?alt=media&token=9a389932-5562-4c38-a970-9ecd6bf8adcb";
      takeAways[0].add(data.data.takeaways[0].title);
      takeAways[0].add(data.data.takeaways[0].description);
      takeAways[1].add(data.data.takeaways[1].title);
      takeAways[1].add(data.data.takeaways[1].description);
      takeAways[2].add(data.data.takeaways[2].title);
      takeAways[2].add(data.data.takeaways[2].description);
      takeAways[3].add(data.data.takeaways[3].title);
      takeAways[3].add(data.data.takeaways[3].description);

      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).clearSnackBars();
    });
    if (componentOneTwoController.pageData.isNotEmpty) {
      setData(componentOneTwoController.pageData[8]);
    }
    if (title == '') {
      setData(componentOneTwoController.pageData[8]);
    }
  }

  double screenHeight = 0.0;
  double screenWidth = 0.0;
  TextEditingController personalReflectionController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight
        ? webDisplay(screenWidth, screenHeight)
        : mobileDisplay();
  }

  webDisplay(double screenWidth, double screenHeight) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: screenWidth * 0.02),
                  //Heading
                  Text(
                    title,
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
                                  child: Image.network(image),
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
                              subTitle,
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
                                hintText: hint,
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
                        nextPage: () {
                          // componentOneTwoController.pageIndex.value = 0;
                          componentOneTwoController.dispose();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
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
