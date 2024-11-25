import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GettingStarted/Pages/sf_home.dart';
import 'package:money_monkey/GettingStarted/Widgets/next_button.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../Models and Questions/question_data.dart';

class QuizResultPage extends StatelessWidget {
  final int score;

  const QuizResultPage({
    Key? key,
    required this.score,
  }) : super(
          key: key,
        );

  TextSpan getResultMessage() {
    if (score <= 3) {
      return TextSpan(
        children: [
          TextSpan(
            text: 'Beginner Level\n\n',
            style: GoogleFonts.fredoka(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: 'Welcome to the Start of\nYour Financial Adventure!',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ],
      );
    } else if (score <= 7) {
      return TextSpan(
        children: [
          TextSpan(
            text: 'Intermediate Level\n\n',
            style: GoogleFonts.fredoka(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text:
                'Great job! You have a good\nfoundation in financial literacy!',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ],
      );
    } else {
      return TextSpan(
        children: [
          TextSpan(
            text: 'Advanced Level\n\n',
            style: GoogleFonts.fredoka(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text:
                'Awesome work! You’re\nready to tackle advanced\nfinancial topics!',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Text(
                "Your recommended\nstarting point",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const Spacer(),
              Text(
                "Score: $score/${questions.length}",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              //Score Gauge Meter
              SizedBox(
                width: screenWidth * 0.5,
                height: screenHeight * 0.3,
                child: SfRadialGauge(
                  animationDuration: 1,
                  enableLoadingAnimation: true,
                  axes: <RadialAxis>[
                    RadialAxis(
                      showLabels: false,
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          knobStyle: KnobStyle(
                            color: Colors.lightGreen,
                            knobRadius: 0.15,
                            borderColor: Colors.grey[300],
                            borderWidth: 0.02,
                          ),
                          needleEndWidth: 13,
                          needleStartWidth: 1,
                          enableAnimation: true,
                          value: score.toDouble(),
                        ),
                      ],
                      minimum: 0,
                      maximum: 10,
                      startAngle: 180,
                      endAngle: 0,
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 0,
                          endValue: 2,
                          color: Colors.red,
                          startWidth: 50,
                          endWidth: 50,
                        ),
                        GaugeRange(
                          startValue: 2,
                          endValue: 4,
                          color: Colors.orange,
                          startWidth: 50,
                          endWidth: 50,
                        ),
                        GaugeRange(
                          startValue: 4,
                          endValue: 6,
                          color: Colors.yellow,
                          startWidth: 50,
                          endWidth: 50,
                        ),
                        GaugeRange(
                          startValue: 6,
                          endValue: 8,
                          color: Colors.lightGreen,
                          startWidth: 50,
                          endWidth: 50,
                        ),
                        GaugeRange(
                          startValue: 8,
                          endValue: 10,
                          color: Colors.green,
                          startWidth: 50,
                          endWidth: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: getResultMessage(),
              ),
              const Spacer(),
              NextButton(
                nextPage: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StartFreshHome(),
                      ));
                },
                isEnabled: true,
                text: "Start your Journey!",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
