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
      child: Image.network(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FnextButton.png?alt=media&token=a949a38d-4c8d-4965-ac5e-f4bf143514ca",
      ),
    );
  }
}
