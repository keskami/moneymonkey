import 'package:flutter/material.dart';

class GettingStartedPage2 extends StatelessWidget {
  const GettingStartedPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 45,
          ),
          const Text(
            "Meet your new\nFinancial literacy coach.",
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
            "Money Monkey will help you\nnavigate the world of finance\nand money",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Image.asset("assets/images/money_monkey.png"),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
