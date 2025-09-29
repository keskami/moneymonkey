import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/controller/intro_pages_controller.dart';

class GettingStartedPage3 extends GetView<GettingStartedController> {
  const GettingStartedPage3({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: screenWidth > screenHeight
          ? webDisplay(screenWidth)
          : mobileDisplay(),
    );
  }

  Widget mobileDisplay() {
    return Column(
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
        _buildImage(
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgs_blackboard.png?alt=media&token=08191299-2a7a-41e3-8965-3e6ee3e52eeb",
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget webDisplay(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image container
        SizedBox(
          width: screenWidth * 0.3,
          child: _buildImage(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgs_blackboard.png?alt=media&token=08191299-2a7a-41e3-8965-3e6ee3e52eeb",
            height: screenWidth * 0.25,
            width: screenWidth * 0.25,
          ),
        ),
        // Text container
        SizedBox(
          width: screenWidth * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Money Monkey gives\nyou friendly feedback.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Learn to manage your money wisely,\navoid common pitfalls, and build a\nbrighter financial future.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Helper method to build images with loading and error states
  Widget _buildImage(String url, {double? height, double? width}) {
    return Image.network(
      url,
      height: height,
      width: width,
      fit: BoxFit.contain,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => SizedBox(
        height: height ?? 100,
        width: width ?? 100,
        child: const Center(child: Text('Unable to fetch Image.')),
      ),
    );
  }
}