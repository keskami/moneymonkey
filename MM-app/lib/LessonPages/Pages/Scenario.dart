import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/progress_bar.dart';
import 'package:money_monkey/LessonPages/Controllers/ScenarioController.dart';

class Scenario extends StatefulWidget {
  const Scenario({super.key});

  @override
  State<Scenario> createState() => _ScenarioState();
}

class _ScenarioState extends State<Scenario> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  final ScenarioController scenarioController = Get.find<ScenarioController>();

  Future<void> _preCacheImages() async {
    await precacheImage(
      NetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Fsneakers%201.png?alt=media&token=625bdbab-4e8d-42cd-82b4-8f79a1bedf3f",
      ),
      context,
    );
    await precacheImage(
      NetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Fcollege%201.png?alt=media&token=cd5510da-9563-41a8-a2eb-bd13594312a3",
      ),
      context,
    );
    await precacheImage(
      NetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Factivities%201.png?alt=media&token=8a2aa7b5-e154-4aa9-ae20-44cfc38e01a7",
      ),
      context,
    );
  }

  @override
  void initState() {
    super.initState();
    scenarioController.getControllerData().then((_) {
      _preCacheImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Obx(
      () => scenarioController.isControllerLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : screenWidth > screenHeight
              ? webDisplay()
              : mobileDisplay(),
    );
  }

  Widget webDisplay() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress Bar Row
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
              Container(
                width: screenWidth * 0.44,
                child: CustomProgressBar(
                  pageName: 'ScenarioPage',
                  width: screenWidth * 0.44,
                  key: ValueKey(scenarioController.pageIndex.value),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Image.network(
                width: 30,
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FbananasWorth.png?alt=media&token=551b2c7b-08d9-4624-a077-31641e5bd003",
              ),
              Text(
                "3",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ).marginSymmetric(vertical: screenHeight * 0.05),
          Obx(
            () => scenarioController.pages[scenarioController.pageIndex.value],
          ),
        ],
      ).paddingSymmetric(
        horizontal: screenWidth * 0.25,
      ),
    );
  }

  Widget mobileDisplay() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("Mobile view not implemented yet."),
      ),
    );
  }
}
