import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/progress_bar.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
import 'package:money_monkey/home.dart';

class PeerReflection extends StatefulWidget {
  final String componentId;
  const PeerReflection({super.key, required this.componentId});

  @override
  State<PeerReflection> createState() => _PeerReflectionState();
}

class _PeerReflectionState extends State<PeerReflection> {
  late PeerReflectioncontroller peerReflectioncontroller;
  final String lessonId = "PeerReflection";

  Future<void> _preloadImages() async {
    await precacheImage(
        AssetImage('assets/images/newMonkeys/Maria.png'), context);
    await precacheImage(
        AssetImage('assets/images/newMonkeys/Jason.png'), context);
    await precacheImage(
        AssetImage('assets/images/newMonkeys/Ava.png'), context);
    await precacheImage(
        AssetImage('assets/images/img_monkeymoney_52.png'), context);
  }

  @override
  void initState() {
    super.initState();
    peerReflectioncontroller =
        Get.find<PeerReflectioncontroller>();
    _preloadImages();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    if (Get.isRegistered<PeerReflectioncontroller>()) {
      Get.delete<PeerReflectioncontroller>();
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
            if (peerReflectioncontroller.pageIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else {
              peerReflectioncontroller.pageIndex -= 1;
            }
          },
          icon: Icon(
            Icons.arrow_back,
            size: screenHeight * .04,
            color: Colors.black, // Add color to make the back arrow visible
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Match StoryPage exactly
        mainAxisSize: MainAxisSize.min, // Match StoryPage exactly
        children: [
          SizedBox(
            height: screenHeight * 0.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min, // Match StoryPage exactly
            mainAxisAlignment:
                MainAxisAlignment.center, // Match StoryPage exactly
            children: [
              IconButton(
                onPressed: () {
                  peerReflectioncontroller.pageIndex.value = 0;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                icon: Icon(Icons.close),
              ),
              Container(
                width: screenWidth * 0.44,
                child: CustomProgressBar(
                  pageName: 'PeerReflection',
                  width: screenWidth * 0.44,
                  key: ValueKey(peerReflectioncontroller.pageIndex.value),
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
          ),
          SizedBox(
            height: screenHeight * 0.05, // Added this to match StoryPage
          ),
          Obx(
            () => peerReflectioncontroller
                .pages[peerReflectioncontroller.pageIndex.value],
          ),
        ],
      ).paddingSymmetric(horizontal: screenWidth * 0.25),
    );
  }
}
