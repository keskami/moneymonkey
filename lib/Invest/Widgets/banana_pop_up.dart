import 'package:flutter/material.dart';

class BananaPopUp extends StatelessWidget {
  const BananaPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.transparent,
      child: Image.asset(
        "assets/real_estate/real_estate_income.png",
      ),
    );
  }
}
