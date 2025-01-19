import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GlobalWidgets/progress_bar.dart';
import 'package:money_monkey/LessonPages/Controllers/ToolkitController.dart';
import 'package:money_monkey/home.dart';

class Toolkit extends StatefulWidget {
  const Toolkit({super.key});

  @override
  State<Toolkit> createState() => _ToolkitState();
}

class _ToolkitState extends State<Toolkit> {
  Toolkitcontroller toolkitcontroller = Get.put(Toolkitcontroller());
  final String lessonId = "PeerReflectionQuiz";

  Future<void> _preCacheImages() async {
    await precacheImage(
        NetworkImage(
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fl1toolkit1%2Fpiggy.png?alt=media&token=67260651-2b47-40bf-8d11-9cdd6e5cf6e4",
        ),
        context);
    await precacheImage(
        NetworkImage(
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fl1toolkit1%2Fhouse.png?alt=media&token=870308c5-a116-429f-a711-6bc7186fb15c",
        ),
        context);

    await precacheImage(
        NetworkImage(
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fl1toolkit1%2Fgrad.png?alt=media&token=110526d2-737d-4e6e-9dcf-8d1fd205d36a",
        ),
        context);

    
  }

  @override
  void initState() {
    _preCacheImages();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * .06,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            if (toolkitcontroller.pageIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else {
              toolkitcontroller.pageIndex -= 1;
            }
          },
          icon: Icon(
            Icons.arrow_back,
            size: screenHeight * .04,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: screenHeight * 0.00,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  toolkitcontroller.pageIndex.value = 0;
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
                  pageName: 'Toolkit',
                  width: screenWidth * 0.44,
                  key: ValueKey(toolkitcontroller
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
            () => toolkitcontroller.pages[toolkitcontroller.pageIndex.value],
          ),
        ],
      ),
    );
  }
}
