import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';

class IntroPage extends StatefulWidget {
  IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  bool wait6 = false;

  @override
  void initState() {
    super.initState();
    wait6sec();
  }

  Future<void> wait6sec() async{
    await Future.delayed(Duration(seconds: 6));
    setState(() {
      wait6 = true;
    });

  }
  
  final StoryController storyController = Get.find();
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight ? webDisplay() : mobileDisplay();
  }

  Widget webDisplay() {
    return Container(
      width: screenWidth * 0.5,
      height: screenHeight * 0.65,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight * 0.4,
                    width: screenWidth * 0.004,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
                  ),
                ],
              ).marginSymmetric(vertical: screenHeight * 0.05),
            ),
            Row(
              children: [
                Spacer(),
                CustomNextButton(
                  nextPage: () {
                   
                    storyController.pageIndex.value += 1;
                  },
                  isEnabled: wait6,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget mobileDisplay() {
    return Column();
  }
}
