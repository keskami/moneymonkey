import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/ToolkitController.dart';
import 'dart:async';

class Page5 extends StatefulWidget {
  @override
  _Page5State createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  bool imagesLoaded = false;
  int? balance;
  int totalBanans = 0;
  bool mariaClicked = false;
  bool jasonClicked = false;
  bool avaClicked = false;
  Toolkitcontroller peerReflectionController = Get.find();
  String title = '';
  String subTitle = '';

  final List<Image> images = [
    Image.network(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fl1toolkit1%2Fpiggy.png?alt=media&token=67260651-2b47-40bf-8d11-9cdd6e5cf6e4"),
    Image.network(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fl1toolkit1%2Fhouse.png?alt=media&token=870308c5-a116-429f-a711-6bc7186fb15c"),
    Image.network(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fl1toolkit1%2Fgrad.png?alt=media&token=110526d2-737d-4e6e-9dcf-8d1fd205d36a"),
  ];

  Future<void> _preloadImages() async {
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
  }

  Future<void> setData(data) async {
    setState(() {
      title = data["title"];
      subTitle = data["subTitle"];
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _preloadImages();
    ever(peerReflectionController.isLoading, (_) {
      if (!peerReflectionController.isLoading.value) {
        setData(peerReflectionController.pageData[1]);
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });

    if (title == '') {
      setData(peerReflectionController.pageData[1]);
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
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              SizedBox(height: screenHeight * .07),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(WebscreenWidthUnit * 455, 0, 0, 0),
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
              SizedBox(height: WebscreenHeightUnit * 20),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(WebscreenWidthUnit * 455, 0, 0, 0),
                  child: Text(
                    subTitle,
                    style: GoogleFonts.baloo2(
                      fontSize: screenWidthUnit * 4.75,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              SizedBox(height: WebscreenHeightUnit * 65),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images
                    .map(
                      (image) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: WebscreenWidthUnit * 52),
                        child: SizedBox(
                          height: WebscreenHeightUnit * 181,
                          child: image,
                        ),
                      ),
                    )
                    .toList(),
              ),
              Padding(
                padding: EdgeInsets.only(top: WebscreenHeightUnit * 293),
                child: GestureDetector(
                  onTap: () {
                    peerReflectionController.pageIndex.value += 1;
                  },
                  child: Container(
                    height: screenHeightUnit * 58,
                    width: screenWidthUnit * 71,
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
                        "Start Learning ->",
                        style: GoogleFonts.baloo2(
                          fontSize: screenWidthUnit * 4.2,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
