import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

SnackBar WrongAnswerSnackBar({required String message}) {
  return SnackBar(
    backgroundColor: LightTheme().pastelRed,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FWrong%20X.png?alt=media&token=7502b819-8b30-4120-8222-305534358c8c",
          ),
        ),
        Expanded(
          child: Text(
            message,
            overflow: TextOverflow.visible,
            softWrap: true,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
      ],
    ),
  );
}

SnackBar CorrectAnswerSnackBar({required String message}) {
  return SnackBar(
    backgroundColor: LightTheme().pastelGreen,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FCheck%20circle.png?alt=media&token=52726418-7a0a-4b6c-9207-1efa735199af",
          ),
        ),
        Expanded(
          child: Text(
            message,
            overflow: TextOverflow.visible,
            softWrap: true,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
      ],
    ),
  );
}
