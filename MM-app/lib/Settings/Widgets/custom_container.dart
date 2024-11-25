import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 250, 250, 250),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: BorderSide.strokeAlignOutside,
                offset: Offset(2, 3),
                color: Colors.grey,
              )
            ]),
        child: child);
  }
}
