import 'package:flutter/material.dart';

class CustomSignInButton extends StatelessWidget {
  const CustomSignInButton({
    super.key,
    required this.child,
    required this.color,
    required this.isBordered,
    required this.toNextPage,
  });
  final Widget child;
  final Color color;
  final bool isBordered;
  final Function() toNextPage;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: toNextPage,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: color,
          border: isBordered
              ? Border.all(
                  color: Colors.black38,
                )
              : null,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        height:
            screenWidth > screenHeight ? screenHeight * 0.1 : double.infinity,
        width: screenWidth > screenHeight ? screenWidth * 0.4 : double.infinity,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
