import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/ToolkitController.dart';
import 'package:money_monkey/home.dart';

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  bool mariaClicked = false;
  bool jasonClicked = false;
  bool avaClicked = false;



  String title = '';
  String point1= '';
  String point2= '';
  String point3= '';
  String point4= '';
  bool loading = true;

  Future<void> setData(data) async {
    setState(() {
      title = data["title"];
      point1 = data["point1"];
      point2 = data["point2"];
      point3 = data["point3"];
      point4 = data["point4"];
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    ever(peerReflectionController.isLoading, (_) {
      if (!peerReflectionController.isLoading.value) {
        setData(peerReflectionController.pageData[4]);
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });

    if (title == '') {
      setData(peerReflectionController.pageData[4]);
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
                  padding:
                      EdgeInsets.fromLTRB(WebscreenWidthUnit * 475, 0, 0, 0),
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
                      SizedBox(height: WebscreenHeightUnit * 70),
                      Goal(
                          image: "assets/images/lfwLessonPage5/check.png",
                          text:
                              point1,
                          WebscreenHeightUnit: WebscreenHeightUnit,
                          WebscreenWidthUnit: WebscreenWidthUnit),
                      SizedBox(height: WebscreenHeightUnit * 35),
                      Goal(
                          image: "assets/images/lfwLessonPage5/check.png",
                          text:
                              point2,
                          WebscreenHeightUnit: WebscreenHeightUnit,
                          WebscreenWidthUnit: WebscreenWidthUnit),
                      SizedBox(height: WebscreenHeightUnit * 35),
                      Goal(
                          image: "assets/images/lfwLessonPage5/check.png",
                          text: point3,
                          WebscreenHeightUnit: WebscreenHeightUnit,
                          WebscreenWidthUnit: WebscreenWidthUnit),
                      SizedBox(height: WebscreenHeightUnit * 35),
                      Padding(
                        padding: EdgeInsets.only(left: WebscreenWidthUnit * 30),
                        child: Container(
                          height: WebscreenHeightUnit * 105,
                          width: WebscreenWidthUnit * 762,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(135, 206, 235, .2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: WebscreenWidthUnit * 15),
                              Image.asset(
                                  "assets/images/img_monkeymoney_52.png",
                                  height: WebscreenHeightUnit * 66),
                              SizedBox(width: WebscreenWidthUnit * 15),
                              Text(
                                point4,
                                style: GoogleFonts.baloo2(
                                  fontSize: WebscreenWidthUnit * 25,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  WebscreenWidthUnit * 200, WebscreenHeightUnit * 150, 0, WebscreenHeightUnit * 0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Container(
                    height: screenHeightUnit * 58,
                    width: WebscreenWidthUnit * 200,
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
                        "Finish",
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

Widget Goal({
  required String image,
  required String text,
  required double WebscreenHeightUnit,
  required double WebscreenWidthUnit,
}) {
  return Row(
    children: [
      Image.asset(
        image,
        height: WebscreenHeightUnit * 90,
      ),
      SizedBox(width: WebscreenWidthUnit * 20),
      Text(
        text,
        style: GoogleFonts.baloo2(
            fontSize: WebscreenWidthUnit * 22,
            color: Color.fromRGBO(0, 0, 0, 1),
            fontWeight: FontWeight.w500),
      ),
    ],
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
//l