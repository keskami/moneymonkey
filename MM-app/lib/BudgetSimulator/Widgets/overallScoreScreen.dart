import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/functions.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/circlePainter.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/creditCardManagmentPaymentTracker.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/creditUtilizationManagmentPopUp.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/scoreGraph.dart';
import 'package:money_monkey/BudgetSimulator/Widgets/undsertandingPayment.dart';

class OverallScoreScreen extends StatefulWidget {
  final double screenWidthUnit;
  final double screenHeightUnit;
  final List<String> scoreCategories;
  final double savingsAccountBalance = 0.0;
  final dynamic widget;

  OverallScoreScreen({
    required this.screenWidthUnit,
    required this.screenHeightUnit,
    required this.scoreCategories,
    required this.widget,
  });

  @override
  _OverallScoreScreenState createState() => _OverallScoreScreenState();
}

class _OverallScoreScreenState extends State<OverallScoreScreen> {
  BudgetSimulatorFunctions functions = BudgetSimulatorFunctions();
  double score = 0;
  Color textColor = Color.fromRGBO(0, 0, 0, 0);
  String grade = '';
  String description = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      score += functions
          .s1P2SavingsScore(widget.widget.widget.savingsAccountBalance);
      score += functions.s1P2CreditScoreScore(widget.widget.widget.creditScore);
      score += widget.widget.widget.onTimePaymentScore as int;
      score += functions.s1P2CCDebtScore(widget.widget.widget.creditCardDebt);
      score += functions.s1P2WellnessScore(widget.widget.widget.bodyScore,
          widget.widget.widget.mindScore, widget.widget.widget.socialScore) as int;
      textColor = functions.s1P2ScoreTextColor(score);
      grade = functions.s1P2ScoreGrade(score);
      description = functions.s1P2ScoreTextWord(score);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: widget.screenHeightUnit * 20,
              left: widget.screenWidthUnit * 1100,
              bottom: widget.screenHeightUnit * 60),
          child: Container(
            height: widget.screenHeightUnit * 60,
            width: widget.screenWidthUnit * 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromRGBO(233, 244, 255, 1),
              border: Border.all(
                color: Color.fromRGBO(0, 127, 255, 1),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                'Overall Score: ${score}',
                style: GoogleFonts.baloo2(
                  fontSize: widget.screenHeightUnit * 30,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(0, 127, 255, 1),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: widget.screenHeightUnit * 80,
            left: widget.screenWidthUnit * 80,
          ),
          child: Container(
            height: widget.screenHeightUnit * 800,
            width: widget.screenWidthUnit * 1000,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding:
                        EdgeInsets.only(top: widget.screenHeightUnit * 20)),
                Text(
                  'YOUR BUDGET SCORE',
                  style: GoogleFonts.baloo2(
                    fontSize: widget.screenHeightUnit * 40,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(106, 114, 128, 1),
                  ),
                ),
                SizedBox(height: widget.screenHeightUnit * 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$score',
                      style: GoogleFonts.baloo2(
                        fontSize: widget.screenHeightUnit * 120,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    SizedBox(width: widget.screenWidthUnit * 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GRADE $grade',
                          style: GoogleFonts.baloo2(
                            fontSize: widget.screenHeightUnit * 47,
                            fontWeight: FontWeight.w400,
                            color: textColor,
                          ),
                        ),
                        Text(
                          '$score / 1000 points',
                          style: GoogleFonts.baloo2(
                            fontSize: widget.screenHeightUnit * 29,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                BudgetGraphWidget(
                  scoreCategories: widget.scoreCategories,
                  widget: widget.widget,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildBarPair(String label, double height1, double height2) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildBar(height1, Colors.grey), // Light color for reference
          const SizedBox(width: 8),
          _buildBar(height2, Colors.blue), // Highlighted color
        ],
      ),
      const SizedBox(height: 10),
      RotatedBox(
        quarterTurns: 1,
        child: Text(label, style: const TextStyle(fontSize: 12)),
      ),
    ],
  );
}

Widget _buildBar(double height, Color color) {
  return Container(
    width: 30,
    height: height * .2,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
    ),
  );
}
