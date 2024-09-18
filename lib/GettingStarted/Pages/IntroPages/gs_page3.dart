import 'package:flutter/material.dart';

class GettingStartedPage3 extends StatelessWidget {
  const GettingStartedPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 45,
          ),
          const Text(
            "Money Monkey gives\nyou friendly feedback.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 35,
          ),
          const Text(
            "Learn to manage your money wisely,\navoid common pitfalls, and build a\nbrighter financial future.",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Image.asset("assets/gs_blackboard.png"),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
