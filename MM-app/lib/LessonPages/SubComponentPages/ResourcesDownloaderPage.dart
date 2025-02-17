import 'dart:html' as html;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/ToolkitController.dart';
import 'package:money_monkey/home.dart';

class ResourcesDownloaderPage extends StatefulWidget {
  @override
  _ResourcesDownloaderPageState createState() => _ResourcesDownloaderPageState();
}

class _ResourcesDownloaderPageState extends State<ResourcesDownloaderPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  bool downloaded = false;
  late Future<ListResult> futureFiles;
  String title = '';
  String subTitle = '';
  bool loading = true;

  Future<void> setData(data) async {
    setState(() {
      title = data["title"];
      subTitle = data["subTitle"];
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/pdfs').listAll();

    ever(peerReflectionController.isLoading, (_) {
      if (!peerReflectionController.isLoading.value) {
        setData(peerReflectionController.pageData[3]);
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });

    if (title == '') {
      setData(peerReflectionController.pageData[3]);
    }
  }

  Toolkitcontroller peerReflectionController = Get.find();

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
        SizedBox(height: screenHeight * .05),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(WebscreenWidthUnit * 455, 0, 0, 0),
            child: Text(
              "Plan Your Financial Future!",
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
              "This planner helps you set short- and long-term financial goals. Download it\nand fill it out to start your journey toward financial success.",
              style: GoogleFonts.baloo2(
                fontSize: screenWidthUnit * 4.75,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        SizedBox(height: WebscreenHeightUnit * 45),
        GestureDetector(
          onTap: () {
            try {
              futureFiles.then((value) {
                value.items.forEach((element) {
                  if (element.name == "dummy.pdf") {
                    element.getDownloadURL().then((value) {
                      html.window.open(value, "dummy.pdf");
                    });
                  }
                });
              });
              setState(() {
                downloaded = true;
              });
            } catch (e) {
              print(e);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Error Downloading File'),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: Container(
            height: WebscreenHeightUnit * 203,
            width: WebscreenWidthUnit * 972,
            decoration: BoxDecoration(
              color: Color.fromRGBO(249, 250, 251, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  WebscreenWidthUnit * 40, WebscreenHeightUnit * 20, 0, 0),
              child: Text(
                "Financial Goal Planner",
                style: GoogleFonts.baloo2(
                  fontSize: screenWidthUnit * 5,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: WebscreenHeightUnit * 335),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      try {
                        futureFiles.then((value) {
                          value.items.forEach((element) {
                            if (element.name == "dummy.pdf") {
                              element.getDownloadURL().then((value) {
                                html.window.open(value, "dummy.pdf");
                              });
                            }
                          });
                        });
                        setState(() {
                          downloaded = true;
                        });
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Error Downloading File'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: Container(
                      height: screenHeightUnit * 58,
                      width: WebscreenWidthUnit * 221,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(137, 220, 142, 1),
                        borderRadius: BorderRadius.circular(5),
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
                          "Download",
                          style: GoogleFonts.baloo2(
                              fontSize: screenWidthUnit * 4.2,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )),
                SizedBox(width: WebscreenWidthUnit * 170),
                GestureDetector(
                    onTap: () {
                      if (downloaded) {
                        print(peerReflectionController.pageIndex.value);
                        peerReflectionController.pageIndex.value += 1;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Download the file before continuing'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: Container(
                      height: screenHeightUnit * 58,
                      width: WebscreenWidthUnit * 221,
                      decoration: BoxDecoration(
                        color: downloaded
                            ? Color.fromRGBO(137, 220, 142, 1)
                            : Color.fromRGBO(224, 227, 231, 1),
                        borderRadius: BorderRadius.circular(5),
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
              ],
            ))
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
