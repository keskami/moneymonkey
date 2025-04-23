import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExitCheckQuizQuestion extends StatefulWidget {
  final double heightUnit;
  final double widthUnit;
  final int quesionNumber;
  final String questionText;
  final List<String> options;
  final int correctAnswer;
  final Function onAnswerSelected;

  const ExitCheckQuizQuestion({
    Key? key,
    required this.heightUnit,
    required this.widthUnit,
    required this.quesionNumber,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  _ExitCheckQuizQuestionState createState() => _ExitCheckQuizQuestionState();
}

class _ExitCheckQuizQuestionState extends State<ExitCheckQuizQuestion> {
  int chosen = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.heightUnit * 570,
        width: widget.widthUnit * 1100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: .25,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: widget.widthUnit * 20, top: widget.heightUnit * 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question ${widget.quesionNumber}",
                  style: GoogleFonts.baloo2(
                      fontSize: widget.heightUnit * 35,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: widget.heightUnit * 20,
                ),
                Text(
                  widget.questionText,
                  style: GoogleFonts.baloo2(
                      fontSize: widget.heightUnit * 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: widget.heightUnit * 20,
                ),
                GestureDetector(
                  onTap: () {
                    widget.onAnswerSelected(0);
                    setState(() {
                      chosen = 1;
                    });
                  },
                  child: Container(
                    height: widget.heightUnit * 70,
                    width: widget.widthUnit * 900,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: chosen == 1
                          ? Color.fromRGBO(0, 127, 255, 1)
                          : Color.fromRGBO(228, 228, 228, 1),
                    
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: widget.widthUnit * 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.options[0],
                          style: GoogleFonts.baloo2(
                              fontSize: widget.heightUnit * 26,
                              fontWeight: FontWeight.w600,
                              color: chosen == 1
                                  ? Colors.white
                                  : Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.heightUnit * 20,
                ),
                GestureDetector(
                  onTap: () {
                    widget.onAnswerSelected(1);

                    setState(() {
                      chosen = 2;
                    });
                  },
                  child: Container(
                    height: widget.heightUnit * 70,
                    width: widget.widthUnit * 900,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: chosen == 2
                          ? Color.fromRGBO(0, 127, 255, 1)
                          : Color.fromRGBO(228, 228, 228, 1),
                     
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: widget.widthUnit * 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.options[1],
                          style: GoogleFonts.baloo2(
                              fontSize: widget.heightUnit * 26,
                              fontWeight: FontWeight.w600,
                              color: chosen == 2
                                  ? Colors.white
                                  : Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.heightUnit * 20,
                ),
                GestureDetector(
                  onTap: () {
                    widget.onAnswerSelected(2);

                    setState(() {
                      chosen = 3;
                    });
                  },
                  child: Container(
                    height: widget.heightUnit * 70,
                    width: widget.widthUnit * 900,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: chosen == 3
                          ? Color.fromRGBO(0, 127, 255, 1)
                          : Color.fromRGBO(228, 228, 228, 1),
                    
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: widget.widthUnit * 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.options[2],
                          style: GoogleFonts.baloo2(
                              fontSize: widget.heightUnit * 26,
                              fontWeight: FontWeight.w600,
                              color: chosen == 3
                                  ? Colors.white
                                  : Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.heightUnit * 20,
                ),
                GestureDetector(
                  onTap: () {
                    widget.onAnswerSelected(3);
                    setState(() {
                      chosen = 4;
                    });
                  },
                  child: Container(
                    height: widget.heightUnit * 70,
                    width: widget.widthUnit * 900,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: chosen == 4
                          ? Color.fromRGBO(0, 127, 255, 1)
                          : Color.fromRGBO(228, 228, 228, 1),
                     
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: widget.widthUnit * 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.options[3],
                          style: GoogleFonts.baloo2(
                              fontSize: widget.heightUnit * 26,
                              fontWeight: FontWeight.w600,
                              color: chosen == 4
                                  ? Colors.white
                                  : Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }
}
