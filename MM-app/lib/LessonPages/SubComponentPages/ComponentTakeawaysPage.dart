import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/ShadowedBoxContainer.dart';
import 'package:money_monkey/home.dart';

class ComponentTakeawaysPage extends StatefulWidget {
  final String title;
  final String subTitle;
  final String hint;
  final String image;
  final List<List<String>> takeAways;

  const ComponentTakeawaysPage({
    super.key,
    required this.title,
    required this.subTitle,
    required this.hint,
    required this.image,
    required this.takeAways,
  });

  @override
  State<ComponentTakeawaysPage> createState() => _ComponentTakeawaysPageState();
}

class _ComponentTakeawaysPageState extends State<ComponentTakeawaysPage> {

  // We keep a controller for the reflection text
  TextEditingController personalReflectionController =
      TextEditingController();

  // We remove loading logic since data is injected via constructor
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    // If you want a different mobile layout, adapt similarly
    return screenWidth > screenHeight
        ? webDisplay(screenWidth, screenHeight)
        : mobileDisplay();
  }

  Widget webDisplay(double screenWidth, double screenHeight) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenWidth * 0.02),
            // Heading
            Text(
              widget.title,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 27,
              ),
            ).marginSymmetric(
              vertical: screenHeight * 0.025,
              horizontal: screenWidth * 0.015,
            ),
            SizedBox(height: screenHeight * 0.03),
            // The column with takeaways + reflection
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Generate each "takeaway" box
                ...widget.takeAways.map((takeaway) {
                  return ShadowedBoxContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 25,
                              child: Image.network(widget.image),
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
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          takeaway[1],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                // Reflection
                ShadowedBoxContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.subTitle,
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ).marginOnly(bottom: screenHeight * 0.03),
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
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: widget.hint,
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            // Next Button row
            Row(
              children: [
                const Spacer(),
                CustomNextButton(
                  nextPage: () {
                    // Example: reset page index and go to home
                    if (Get.isRegistered<BaseLessonController>()) {
                      Get.delete<BaseLessonController>();
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  isEnabled: personalReflectionController.text.isNotEmpty,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.1),
          ],
        ).paddingSymmetric(horizontal: screenWidth * 0.25),
      ),
    );
  }

  Widget mobileDisplay() {
    // Minimal example; adapt as needed for smaller screens
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 20),
          // ... The same approach to listing the takeAways ...
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widget.takeAways.map((takeaway) {
                return ShadowedBoxContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            child: Image.network(widget.image),
                          ),
                          SizedBox(width: 8),
                          Text(
                            takeaway[0],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        takeaway[1],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              // Reflection
              ShadowedBoxContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.subTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: widget.hint,
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Next button
          Row(
            children: [
              Spacer(),
              CustomNextButton(
                nextPage: () {
                  if (Get.isRegistered<BaseLessonController>()) {
                    Get.delete<BaseLessonController>();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                isEnabled: personalReflectionController.text.isNotEmpty,
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
