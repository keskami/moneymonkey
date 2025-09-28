import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/controller/intro_pages_controller.dart';

class GettingStartedPage2 extends GetView<GettingStartedController> {
  const GettingStartedPage2({super.key});
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > screenHeight
        ? webDisplay(screenWidth)
        : mobileDisplay();
  }
  
  Center mobileDisplay() {
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
          _buildImage(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
  
  Center webDisplay(double screenWidth) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image container
          SizedBox(
            width: screenWidth * 0.3,
            child: _buildImage(
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
              height: screenWidth * 0.25,
              width: screenWidth * 0.25,
            ),
          ), // Space between containers
          // Text container
          SizedBox(
            width: screenWidth * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Meet your new\nFinancial literacy coach.",
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
                  "Money Monkey will help you\nnavigate the world of finance\nand money",
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
      ),
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