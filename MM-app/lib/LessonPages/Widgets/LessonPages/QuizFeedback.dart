import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizFeedback extends StatefulWidget {
  final double heightUnit;
  final double widthUnit;
  final List<int> selectedAnswers;
  final List<int> correctAnswers;
  final List<List<String>> options;
  final List<String> questions;

  const QuizFeedback({
    Key? key,
    required this.heightUnit,
    required this.widthUnit,
    required this.selectedAnswers,
    required this.correctAnswers,
    required this.options,
    required this.questions,
  }) : super(key: key);

  @override
  _QuizFeedbackState createState() => _QuizFeedbackState();
}

class _QuizFeedbackState extends State<QuizFeedback> {
  late int outOf;
  late int correct;
  late int percent;

  @override
  void initState() {
    super.initState();
    outOf = widget.correctAnswers.length;
    correct = 0;

    for (int i = 0; i < widget.correctAnswers.length; i++) {
      if (widget.selectedAnswers[i] == widget.correctAnswers[i]) {
        correct++;
      }
    }

    percent = ((correct / outOf) * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            left: widget.widthUnit * 30, top: widget.heightUnit * 50, bottom: widget.heightUnit * 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: widget.heightUnit * 120,
                  width: widget.widthUnit * 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: percent < 50
                          ? Colors.red
                          : percent < 75
                              ? Colors.orange
                              : percent < 100
                                  ? Colors.yellow
                                  : Colors.green),
                  child: Center(
                    child: Text(
                      "$percent%",
                      style: TextStyle(
                        fontSize: widget.heightUnit * 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: widget.widthUnit * 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quiz Results",
                        style: GoogleFonts.baloo2(
                          fontSize: widget.heightUnit * 38,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        )),
                    Text(
                        "You answered $correct out of $outOf questions correctly.",
                        style: GoogleFonts.baloo2(
                          fontSize: widget.heightUnit * 28,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ))
                  ],
                )
              ],
            ),
            SizedBox(
              height: widget.heightUnit * 30,
            ),
            Column(
              children: List.generate(widget.questions.length, (i) {
              return Padding(
                padding: EdgeInsets.only(bottom: widget.heightUnit * 20),
                child: Container(
                width: widget.widthUnit * 1040,
                decoration: BoxDecoration(
                  color: widget.correctAnswers[i] != widget.selectedAnswers[i]
                    ? Color.fromARGB(255, 255, 231, 194)
                    : Color.fromRGBO(189, 222, 255, 1),
                  border: Border.all(
                    color: widget.correctAnswers[i] != widget.selectedAnswers[i]
                      ? Colors.orange
                      : Color.fromRGBO(0, 127, 255, 1),
                    width: .6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                  left: widget.widthUnit * 20,
                  top: widget.heightUnit * 20,
                  bottom: widget.heightUnit * 20,
                  ),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    widget.questions[i],
                    style: GoogleFonts.baloo2(
                      fontSize: widget.heightUnit * 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    ),
                    SizedBox(
                    height: widget.heightUnit * 7,
                    ),
                    widget.correctAnswers[i] == widget.selectedAnswers[i]
                      ? SizedBox.shrink()
                      : Text(
                        "Your answer: ${widget.options[i][widget.selectedAnswers[i]]}",
                        style: GoogleFonts.baloo2(
                        fontSize: widget.heightUnit * 28,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(249, 93, 26, 1),
                        )),
                    SizedBox(
                    height: widget.heightUnit * 7,
                    ),
                    Text(
                      "Correct answer: ${widget.options[i][widget.correctAnswers[i]]}",
                      style: GoogleFonts.baloo2(
                      fontSize: widget.heightUnit * 28,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 127, 255, 1),
                      )),
                  ],
                  ),
                ),
                ),
              );
              }),
            ),
          ],
        ),
      ),
    );
  }
}