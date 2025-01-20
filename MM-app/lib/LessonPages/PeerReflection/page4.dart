import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
import 'package:money_monkey/home.dart';

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  bool mariaClicked = false;
  bool jasonClicked = false;
  bool avaClicked = false;
  PeerReflectioncontroller peerReflectionController = Get.find();
  bool delay = false;

  bool loading = true;
  String title = '';
  String subTitle = '';
  String ava = '';
  String maria = '';
  String jason = '';
  String button = '';

  Future<void> setData(data) async {
    setState(() {
      title = data['title'];
      subTitle = data['subTitle'];
      ava = data['ava'];
      maria = data['maria'];
      jason = data['jason'];
      button = data['button'];

      loading = false;
    });
    _6secdelay();
  }

  @override
  void initState() {
    super.initState();
    ever(peerReflectionController.isLoading, (_) {
      if (!peerReflectionController.isLoading.value) {
        if (peerReflectionController.pageData.isNotEmpty) {
          setData(peerReflectionController.pageData[4]);
        }
      }
    });
    if (title == '') {
      setData(peerReflectionController.pageData[4]);
    }
  }

  Future<void> _6secdelay() async {
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      delay = true;
    });
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
        SizedBox(height: screenHeight * .05),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(WebscreenWidthUnit * 475, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.baloo2(
                        fontSize: screenWidthUnit * 6,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: WebscreenHeightUnit * 10),
                  Text(
                    subTitle,
                    style: GoogleFonts.baloo2(
                        fontSize: screenWidthUnit * 4.5,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: WebscreenHeightUnit * 79),
                  lessonTab(
                    image: "assets/images/newMonkeys/Maria.png",
                    name: maria,
                    isClicked: mariaClicked,
                    onClick: () {
                      setState(() {
                        if (mariaClicked) {
                          mariaClicked = false;
                        } else {
                          mariaClicked = true;
                          jasonClicked = false;
                          avaClicked = false;

                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          Future.delayed(Duration(seconds: 1), () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                CorrectAnswerSnackBar(message: ""));
                          });
                        }
                      });
                    },
                    context: context,
                    WebscreenHeightUnit: WebscreenHeightUnit,
                    WebscreenWidthUnit: WebscreenWidthUnit,
                  ),
                  SizedBox(height: WebscreenHeightUnit * 29),
                  lessonTab(
                    image: "assets/images/newMonkeys/Jason.png",
                    name:
                        jason,
                    isClicked: jasonClicked,
                    onClick: () {
                      setState(() {
                        if (jasonClicked) {
                          jasonClicked = false;
                        } else {
                          jasonClicked = true;
                          avaClicked = false;
                          mariaClicked = false;
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          Future.delayed(Duration(seconds: 1), () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                CorrectAnswerSnackBar(message: ""));
                          });
                        }
                      });
                    },
                    context: context,
                    WebscreenHeightUnit: WebscreenHeightUnit,
                    WebscreenWidthUnit: WebscreenWidthUnit,
                  ),
                  SizedBox(height: WebscreenHeightUnit * 29),
                  lessonTab(
                    image: "assets/images/newMonkeys/Ava.png",
                    name:
                        ava,
                    isClicked: avaClicked,
                    onClick: () {
                      setState(() {
                        if (avaClicked) {
                          avaClicked = false;
                        } else {
                          avaClicked = true;
                          jasonClicked = false;
                          mariaClicked = false;
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          Future.delayed(Duration(seconds: 1), () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                CorrectAnswerSnackBar(message: ""));
                          });
                        }
                      });
                    },
                    context: context,
                    WebscreenHeightUnit: WebscreenHeightUnit,
                    WebscreenWidthUnit: WebscreenWidthUnit,
                  ),
                ],
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: WebscreenHeightUnit * 120),
          child: GestureDetector(
              onTap: () {
                if ((avaClicked || jasonClicked || mariaClicked) && delay) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else if (!delay) {
                } else {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please select a peer to continue'),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              child: Container(
                height: screenHeightUnit * 58,
                width: screenWidthUnit * 81,
                decoration: BoxDecoration(
                  color: ((avaClicked || jasonClicked || mariaClicked) && delay)
                      ? Color.fromRGBO(137, 220, 142, 1)
                      : Color.fromRGBO(224, 227, 231, 1),
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
    );
  }
}

Widget lessonTab({
  required String image,
  required String name,
  required bool isClicked,
  required Function onClick,
  required BuildContext context,
  required double WebscreenHeightUnit,
  required double WebscreenWidthUnit,
}) {
  return !isClicked
      ? GestureDetector(
          onTap: () {
            onClick();
          },
          child: Container(
            height: WebscreenHeightUnit * 106,
            width: WebscreenWidthUnit * 907,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color.fromRGBO(175, 175, 175, 1),
                width: .1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: WebscreenWidthUnit * 25,
                ),
                Image.asset(
                  image,
                  height: WebscreenHeightUnit * 73,
                ),
                SizedBox(
                  width: WebscreenWidthUnit * 14,
                ),
                Text(name,
                    style: GoogleFonts.baloo2(
                        fontSize: WebscreenWidthUnit * 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        )
      : GestureDetector(
          onTap: () {
            onClick();
          },
          child: Container(
            height: WebscreenHeightUnit * 106,
            width: WebscreenWidthUnit * 907,
            decoration: BoxDecoration(
              color: Color.fromRGBO(137, 220, 142, 1),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color.fromRGBO(175, 175, 175, 1),
                width: .1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: WebscreenWidthUnit * 25,
                ),
                Image.asset(
                  image,
                  height: WebscreenHeightUnit * 73,
                ),
                SizedBox(
                  width: WebscreenWidthUnit * 14,
                ),
                Text(name,
                    style: GoogleFonts.baloo2(
                        fontSize: WebscreenWidthUnit * 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        );
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
