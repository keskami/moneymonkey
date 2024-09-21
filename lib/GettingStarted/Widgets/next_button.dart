import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.pages,
    required this.nextPage,
  });
  final int pages;
  final Function() nextPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextPage,
      child: Image.asset("assets/images/nextButton.png"),
    );
  }
}
