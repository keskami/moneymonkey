import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';

class MonkeyLandingPage extends StatefulWidget {
  @override
  _MonkeyLandingPageState createState() => _MonkeyLandingPageState();
}

class _MonkeyLandingPageState extends State<MonkeyLandingPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;

  final StoryController storyController = Get.find();

  String button = '';
  bool imagesLoaded = false;
  bool isLoading = true;
//String subTitle = '';
  final List<Image> images = [
    Image.asset("assets/images/lfwLessonPage5/bubble2.png"),
    Image.asset("assets/images/monkeyNoText.png"),
  ];

  Future<void> _preloadImages() async {
    try {
      final futures = images.map((image) {
        final completer = Completer<void>();
        final ImageStreamListener listener = ImageStreamListener(
          (info, _) => completer.complete(),
          onError: (error, _) => completer.complete(),
        );
        image.image.resolve(const ImageConfiguration()).addListener(listener);
        return completer.future;
      });

      await Future.wait(futures);
      setState(() {
        imagesLoaded = true;
      });
    } catch (e) {
      debugPrint("Error preloading images: $e");
    }
  }

  Future<void> setData(Map<String, dynamic> data) async {
    setState(() {
      button = data["button"];
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _preloadImages();

    ever(storyController.isLoading, (_) {
      if (!storyController.isLoading.value) {
        setData(storyController.pageData[1]);
      }
    });

    if (button == '') {
      if (storyController.pageData[1] != null) {
        setData(storyController.pageData[1]);
      } else {
        debugPrint("Page data for index 1 is null");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;
    double WebscreenWidthUnit = screenWidth / 1920;
    double WebscreenHeightUnit = screenHeight / 1080;
    return (isLoading || !imagesLoaded)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: EdgeInsets.only(left: screenWidth * .09),
            child: Column(
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
                        storyController.pageIndex.value += 1;
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
                            button,
                            style: GoogleFonts.baloo2(
                                fontSize: screenWidthUnit * 4.2,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )),
                )
              ],
            ));
  }
}
