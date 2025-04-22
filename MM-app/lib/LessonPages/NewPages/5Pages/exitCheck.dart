import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/NewPages/newPageWidgets/exitCheckOption.dart';
import 'package:money_monkey/LessonPages/NewPages/newPageWidgets/exitCheckQuizQuestion.dart';

class ExitCheck extends StatefulWidget {
  final double heightUnit;
  final double widthUnit;

  const ExitCheck({
    Key? key,
    required this.heightUnit,
    required this.widthUnit,
  }) : super(key: key);

  @override
  _ExitCheckState createState() => _ExitCheckState();
}

class _ExitCheckState extends State<ExitCheck> {
  //To Be fixed with backend
  final String LessonName = 'Financial Values';

  bool selected1 = true;
  bool selected2 = false;
  bool selected3 = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight,
            width: screenWidth * .2,
            decoration: BoxDecoration(
                color: Colors.white,
                border: BorderDirectional(
                    end: BorderSide(width: .6, color: Colors.grey))),
            child: Padding(
              padding: EdgeInsets.all(widget.heightUnit * 55),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widget.widthUnit * 90,
                    height: widget.heightUnit * 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromRGBO(0, 127, 255, 1), width: 2)),
                    child: Center(
                      child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
                        height: widget.heightUnit * 70,
                      ),
                    ),
                  ),
                  SizedBox(height: widget.heightUnit * 20),
                  Text(
                    "Money Monkey",
                    style: GoogleFonts.baloo2(
                        fontSize: widget.heightUnit * 40,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: widget.heightUnit * 5),
                  Text(
                    "Exit Check",
                    style: GoogleFonts.baloo2(
                        fontSize: widget.heightUnit * 24,
                        color: Color.fromRGBO(112, 118, 124, 1),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: widget.heightUnit * 50),
                  Text(
                    "Complete Your Learning",
                    style: GoogleFonts.baloo2(
                        fontSize: widget.heightUnit * 24,
                        color: Color.fromRGBO(112, 118, 124, 1),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: widget.heightUnit * 30),
                  ExitCheckOption(
                    heightUnit: widget.heightUnit,
                    widthUnit: widget.widthUnit,
                    onClick: () {
                      setState(() {
                        selected1 = true;
                        selected2 = false;
                        selected3 = false;
                      });
                    },
                    text: "Knowlage Check Quiz ",
                    icon: Icon(
                      Icons.create,
                      size: widget.heightUnit * 40,
                      color: selected1
                          ? Color.fromRGBO(0, 127, 255, 1)
                          : Color.fromRGBO(112, 118, 124, 1),
                    ),
                    selected: selected1,
                  ),
                  SizedBox(height: widget.heightUnit * 30),
                  ExitCheckOption(
                    heightUnit: widget.heightUnit,
                    widthUnit: widget.widthUnit,
                    onClick: () {
                      setState(() {
                        selected2 = true;
                        selected1 = false;
                        selected3 = false;
                      });
                    },
                    text: "Set A Financial Goal",
                    icon: Icon(
                      Icons.center_focus_strong,
                      size: widget.heightUnit * 40,
                      color: selected2
                          ? Color.fromRGBO(0, 127, 255, 1)
                          : Color.fromRGBO(112, 118, 124, 1),
                    ),
                    selected: selected2,
                  ),
                  SizedBox(height: widget.heightUnit * 30),
                  ExitCheckOption(
                    heightUnit: widget.heightUnit,
                    widthUnit: widget.widthUnit,
                    onClick: () {
                      setState(() {
                        selected3 = true;
                        selected2 = false;
                        selected1 = false;
                      });
                    },
                    text: "Final Reflection Chat",
                    icon: Icon(
                      Icons.chat_bubble,
                      size: widget.heightUnit * 40,
                      color: selected3
                          ? Color.fromRGBO(0, 127, 255, 1)
                          : Color.fromRGBO(112, 118, 124, 1),
                    ),
                    selected: selected3,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: screenWidth * .8,
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth * .8,
                  height: screenHeight * .1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: .6))),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: widget.heightUnit * 10,
                        left: widget.widthUnit * 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        selected1
                            ? Text(
                                "Knowledge Check: $LessonName",
                                style: GoogleFonts.baloo2(
                                    fontSize: widget.heightUnit * 50,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              )
                            : selected2
                                ? Text(
                                    "Financial Goal: $LessonName",
                                    style: GoogleFonts.baloo2(
                                        fontSize: widget.heightUnit * 50,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  )
                                : Text(
                                    "Reflection: $LessonName",
                                    style: GoogleFonts.baloo2(
                                        fontSize: widget.heightUnit * 50,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                        selected1
                            ? Text(
                                "Demonstrate what you have learned about $LessonName",
                                style: GoogleFonts.baloo2(
                                    fontSize: widget.heightUnit * 30,
                                    color: Color.fromRGBO(106, 114, 128, 1),
                                    fontWeight: FontWeight.w500),
                              )
                            : selected2
                                ? Text(
                                    "Demonstrate what you have learned about $LessonName",
                                    style: GoogleFonts.baloo2(
                                        fontSize: widget.heightUnit * 30,
                                        color: Color.fromRGBO(106, 114, 128, 1),
                                        fontWeight: FontWeight.w500),
                                  )
                                : Text(
                                    "Demonstrate what you have learned about $LessonName",
                                    style: GoogleFonts.baloo2(
                                        fontSize: widget.heightUnit * 30,
                                        color: Color.fromRGBO(106, 114, 128, 1),
                                        fontWeight: FontWeight.w500),
                                  ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * .9,
                  width: screenWidth * .8,
                  child: Center(
                    child: SingleChildScrollView(
                        child: selected1
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: widget.heightUnit * 50,),
                                  ExitCheckQuizQuestion(
                                      heightUnit: widget.heightUnit,
                                      widthUnit: widget.widthUnit),
                                      SizedBox(height: widget.heightUnit * 50,),
                                       ExitCheckQuizQuestion(
                                      heightUnit: widget.heightUnit,
                                      widthUnit: widget.widthUnit),
                                      SizedBox(height: widget.heightUnit * 50,),
                                       ExitCheckQuizQuestion(
                                      heightUnit: widget.heightUnit,
                                      widthUnit: widget.widthUnit),
                                      SizedBox(height: widget.heightUnit * 50,),
                                ],
                              )
                            : Column()),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
