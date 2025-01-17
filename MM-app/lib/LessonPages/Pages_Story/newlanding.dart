
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';



class NewStoryLanding extends StatefulWidget {
  @override
  _NewStoryLandingState createState() => _NewStoryLandingState();
}

class _NewStoryLandingState extends State<NewStoryLanding> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;

  StoryController peerReflectionController = Get.find();
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(133, 220, 64, 1),
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;
    double WebscreenWidthUnit = screenWidth / 1920;
    double WebscreenHeightUnit = screenHeight / 1080;
    return Column(
      children: [
        SizedBox(height: WebscreenHeightUnit * 65),
        Container(
          height: WebscreenHeightUnit * 170,
          width: WebscreenWidthUnit * 700,
          child: Image.asset(
            "assets/images/lfwLessonPage5/bubble2.png",
          ),
        ),

        SizedBox(height: WebscreenHeightUnit * 12),
         Container(
          height: WebscreenHeightUnit * 280,
          width: WebscreenWidthUnit * 400,
          child: Image.asset(
            "assets/images/monkeyNoText.png",
          ),
        ),
       
        Padding(
          padding: EdgeInsets.only(top: WebscreenHeightUnit * 103),
          child: GestureDetector(
              onTap: () {
                print(peerReflectionController.pageIndex.value);
                peerReflectionController.pageIndex.value += 1;
              },
              child: Container(
                height: screenHeightUnit * 58,
                width: WebscreenWidthUnit * 291,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(137, 220, 142, 1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Continue",
                    style: GoogleFonts.baloo2(
                        fontSize: screenWidthUnit * 4.2,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
