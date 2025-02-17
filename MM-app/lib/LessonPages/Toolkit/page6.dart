import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/ToolkitController.dart';
import 'package:money_monkey/home.dart';

class Page6 extends StatefulWidget {
  @override
  _Page6State createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  bool mariaClicked = false;
  bool jasonClicked = false;
  bool avaClicked = false;
  Toolkitcontroller peerReflectionController = Get.find();
  String title = '';
  bool imagesLoaded = false;
//String subTitle = '';
  final List<Image> images = [
    Image.network(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fl1toolkit1%2Fbubble.png?alt=media&token=f24cfee3-b980-48e2-8724-da06e6a07943"),
    Image.asset("assets/images/monkeyNoText.png"),
  ];

  Future<void> _preloadImages() async {
    try {
      final futures = images.map((image) {
        final completer = Completer<void>();
        final ImageStreamListener listener = ImageStreamListener(
          (info, _) => completer.complete(),
          onError: (error, _) => completer.complete(), // Handle error
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
      title = data["title"];
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _preloadImages();

    ever(peerReflectionController.isLoading, (_) {
      if (!peerReflectionController.isLoading.value) {
        setData(peerReflectionController.pageData[2]);
      } else {
        setState(() {
          isLoading = true;
        });
      }
    });

    if (title.isEmpty) {
      setData(peerReflectionController.pageData[2]);
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
        : Column(
            children: [
              SizedBox(height: screenHeight * .08),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    title,
                    style: GoogleFonts.baloo2(
                      fontSize: screenWidthUnit * 7,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              SizedBox(height: WebscreenHeightUnit * 65),
              Container(
                width: WebscreenWidthUnit * 700,
                child: images[0]),
              SizedBox(height: WebscreenHeightUnit * 12),
              Image.asset("assets/images/monkeyNoText.png",
                  height: WebscreenHeightUnit * 250),
              Padding(
                padding: EdgeInsets.only(top: WebscreenHeightUnit * 153),
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

Widget topOfLesson({
  required double screenWidthUnit,
  required double screenHeightUnit,
  required double pageNumber,
  required double totalPages,
  required BuildContext context,
  required int bananas,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.close, color: Colors.black)),
      TweenAnimationBuilder<double>(
        tween: Tween<double>(
            begin: (pageNumber - 1) / totalPages, end: pageNumber / totalPages),
        duration: Duration(seconds: 2),
        builder: (context, value, child) {
          return Container(
            height: screenHeightUnit * 25,
            width: screenWidthUnit * 202,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(135, 206, 235, 1),
                  Color.fromRGBO(213, 213, 213, 1),
                ],
                stops: [value, value],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          );
        },
      ),
      SizedBox(
        width: screenWidthUnit * 4,
      ),
      Image.asset("assets/images/img_monkeymoney_52.png",
          height: screenHeightUnit * 36),
      SizedBox(
        width: screenWidthUnit * 1,
      ),
      Text("$bananas",
          style: GoogleFonts.roboto(
              fontSize: screenWidthUnit * 5.5, color: Colors.black)),
    ],
  );
}
