import 'package:flutter/material.dart';
import 'package:money_monkey/GlobalWidgets/progress_bar.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
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
                onPressed: () {},
                icon: Icon(Icons.close),
              ),
              Container(
                width: screenWidth * 0.44,
                child: CustomProgressBar(
                  pageName: 'StoryPage',
                  width: screenWidth * 0.44,
                  key: ValueKey(0),
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
          // Obx(
          //   () =>
          //       lessonOneController.pages[lessonOneController.pageIndex.value],
          // ),
        ],
      ),
    );
  }
}
