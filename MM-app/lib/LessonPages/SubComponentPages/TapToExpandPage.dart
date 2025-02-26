import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';

class TapToExpandPage extends StatefulWidget {
  const TapToExpandPage({super.key});

  @override
  State<TapToExpandPage> createState() => _TapToExpandPageState();
}

class _TapToExpandPageState extends State<TapToExpandPage> {
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
  String ava1 = '';
  String ava2 = '';
  String maria1 = '';
  String maria2 = '';
  String jason1 = '';
  String jason2 = '';
  String button = '';

  Future<void> setData(Question data) async {
    setState(() {
      title = data.data.title;
      ava1 = data.data.characters[0].name + ": " + data.data.characters[0].role;
      ava2 = data.data.characters[0].story;
      maria1 = data.data.characters[1].name + ": " + data.data.characters[1].role;
      maria2 = data.data.characters[1].story;
      jason1 = data.data.characters[2].name + ": " + data.data.characters[2].role;
      jason2 = data.data.characters[2].story;
      button = "Continue to Activity";

      loading = false;
    });
    _6secdelay();
  }

  @override
  void initState() {
    super.initState();
    if (peerReflectionController.pageData.isNotEmpty) {
      setData(peerReflectionController.pageData[1]);
    }
    if (title == '') {
      setData(peerReflectionController.pageData[1]);
    }
  }

  Future<void> _6secdelay() async {
    await Future.delayed(Duration(seconds: 6));
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
    return Column(children: [
      topOfLesson(
          screenWidthUnit: screenWidthUnit,
          screenHeightUnit: screenHeightUnit,
          pageNumber: 2,
          totalPages: 8,
          context: context,
          bananas: totalBanans),
      SizedBox(height: WebscreenHeightUnit * 95),
      Padding(
        padding: EdgeInsets.only(right: WebscreenWidthUnit * 758),
        child: Text(
          title,
          style: GoogleFonts.baloo2(
              fontSize: screenWidthUnit * 5,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            left: WebscreenWidthUnit * 17.5, top: WebscreenHeightUnit * 31),
        child: Container(
            height: WebscreenHeightUnit * 550,
            child: Column(children: [
              lessonTab(
                image: "assets/images/newMonkeys/Maria.png",
                name: maria1,
                discription: maria2,
                isClicked: mariaClicked,
                onClick: () {
                  setState(() {
                    mariaClicked = true;
                  });
                },
                context: context,
                WebscreenHeightUnit: WebscreenHeightUnit,
                WebscreenWidthUnit: WebscreenWidthUnit,
              ),
              SizedBox(height: WebscreenHeightUnit * 29),
              lessonTab(
                image: "assets/images/newMonkeys/Jason.png",
                name: jason1,
                discription: jason2,
                isClicked: jasonClicked,
                onClick: () {
                  setState(() {
                    jasonClicked = true;
                  });
                },
                context: context,
                WebscreenHeightUnit: WebscreenHeightUnit,
                WebscreenWidthUnit: WebscreenWidthUnit,
              ),
              SizedBox(height: WebscreenHeightUnit * 29),
              lessonTab(
                image: "assets/images/newMonkeys/Ava.png",
                name: ava1,
                discription: ava2,
                isClicked: avaClicked,
                onClick: () {
                  setState(() {
                    avaClicked = true;
                  });
                },
                context: context,
                WebscreenHeightUnit: WebscreenHeightUnit,
                WebscreenWidthUnit: WebscreenWidthUnit,
              ),
            ])),
      ),
      SizedBox(height: WebscreenHeightUnit * 82),
      Positioned(
        bottom: WebscreenHeightUnit * 0,
        child: GestureDetector(
            onTap: () {
              if (avaClicked && jasonClicked && mariaClicked && delay) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                peerReflectionController.pageIndex.value += 1;
              } else if (!delay) {
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please read all the stories to continue'),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: Container(
              height: screenHeightUnit * 58,
              width: screenWidthUnit * 61,
              decoration: BoxDecoration(
                color: (avaClicked && jasonClicked && mariaClicked && delay)
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
      ),
    ]);
  }
}

Widget lessonTab({
  required String image,
  required String name,
  required String discription,
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
      : Container(
          height: WebscreenHeightUnit * 157,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: WebscreenWidthUnit * 25,
              ),
              Image.asset(
                image,
                height: WebscreenHeightUnit * 145,
              ),
              SizedBox(
                width: WebscreenWidthUnit * 14,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: GoogleFonts.baloo2(
                          fontSize: WebscreenWidthUnit * 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: WebscreenHeightUnit * 5),
                  Text(discription,
                      style: GoogleFonts.baloo2(
                          fontSize: WebscreenWidthUnit * 16.67,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ],
              )
            ],
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
  return Container();
}
