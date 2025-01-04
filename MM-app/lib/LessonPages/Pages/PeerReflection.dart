import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/progress_bar.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page1.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page2.dart';
import 'package:money_monkey/LessonPages/PeerReflection/page3.dart';

class PeerReflection extends StatefulWidget {
  const PeerReflection({super.key});

  @override
  State<PeerReflection> createState() => _PeerReflectionState();
}

class _PeerReflectionState extends State<PeerReflection> {
  PeerReflectioncontroller peerReflectioncontroller = Get.put(PeerReflectioncontroller());
  final String lessonId = "PeerReflection";
  

  @override
  void initState() {
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  peerReflectioncontroller.pageIndex.value = 0;
                },
                icon: Icon(Icons.close),
              ),
              Container(
                width: screenWidth * 0.44,
                child: CustomProgressBar(
                  pageName: 'PeerReflection',
                  width: screenWidth * 0.44,
                  key: ValueKey(peerReflectioncontroller
                      .pageIndex.value), // Add key to force rebuild
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Image.network(
                  width: 30,
                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FbananasWorth.png?alt=media&token=551b2c7b-08d9-4624-a077-31641e5bd003"),
              Text(
                "3",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Obx(
            () =>
                peerReflectioncontroller.pages[peerReflectioncontroller.pageIndex.value],
          ),
        ],
      ),
    );
  }
}
