import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/progress_bar.dart';
import 'package:money_monkey/LessonPages/Controllers/ScenarioController.dart';
import 'package:money_monkey/home.dart';

class Scenario extends StatefulWidget {
  final String componentId;
  const Scenario({super.key, required this.componentId});

  @override
  State<Scenario> createState() => _ScenarioState();
}

class _ScenarioState extends State<Scenario> {
  late ScenarioController scenarioController;

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
    scenarioController = Get.find<ScenarioController>();
    _preCacheImages();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    if (Get.isRegistered<ScenarioController>()) {
      Get.delete<ScenarioController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: screenHeight * .06,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            if (scenarioController.pageIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else {
              scenarioController.pageIndex -= 1;
            }
          },
          icon: Icon(
            Icons.arrow_back,
            size: screenHeight * .04,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: screenHeight * 0.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  scenarioController.pageIndex.value = 0;
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
              Container(
                width: screenWidth * 0.44,
                child: CustomProgressBar(
                  pageName: 'ScenarioPage',
                  key: ValueKey(scenarioController.pageIndex.value),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Image.network(
                width: 30,
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FbananasWorth.png?alt=media&token=551b2c7b-08d9-4624-a077-31641e5bd003",
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image, size: 30);
                },
              ),
              Text(
                "3",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Expanded(
            child: Obx(
              () => scenarioController.pageIndex.value <
                      scenarioController.pages.length
                  ? scenarioController.pages[scenarioController.pageIndex.value]
                  : Container(child: Text("End of content")),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: screenWidth * 0.25),
    );
  }
}
