import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GettingStarted/Widgets/next_button.dart';

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
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "Your recommended\nstarting point",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Score: $score / ${questions.length}",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: getResultMessage(),
              ),
              const Spacer(),
              NextButton(
                nextPage: () {},
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
