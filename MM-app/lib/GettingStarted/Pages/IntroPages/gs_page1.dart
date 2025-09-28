import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GettingStarted/Widgets/custom_button.dart';
import 'package:money_monkey/GettingStarted/controller/intro_pages_controller.dart';
import 'package:money_monkey/LoginPages/login.dart';
import 'package:money_monkey/themes/color_themes.dart';

class GettingStartedPage1 extends GetView<GettingStartedController> {
  const GettingStartedPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return _GettingStartedPage1View();
  }
}

class _GettingStartedPage1View extends StatefulWidget {
  @override
  State<_GettingStartedPage1View> createState() => _GettingStartedPage1ViewState();
}

class _GettingStartedPage1ViewState extends State<_GettingStartedPage1View> {
  late final GettingStartedController gettingStartedController = Get.find();
  
  final storageRef = FirebaseStorage.instance.ref();

  void toGettingStarted() {
    gettingStartedController.pageIndex.value = 1;
  }

  void toNextPage() {
    gettingStartedController.pageIndex.value += 1;
  }

  void toLoginPage() {
    print("Login button pressed!");
    Get.to(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: LightTheme().primaryBackgroundColor,
      body: Stack(
        children: [
          // Logo in top center
          Positioned(
            top: -10,
            left: screenWidth * 0.14,
            child: _buildImage(
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMONKEYMONEY%20(91).png?alt=media&token=d9a9d290-db60-4355-b779-8734d09e52a4",
              height: 150,
              width: 250,
            ),
          ),
          // Main content
          Center(
            child: screenWidth > 900
                ? webDisplay(screenWidth, screenHeight)
                : mobileDisplay(screenWidth, screenHeight),
          ),
        ],
      ),
    );
  }

  Widget mobileDisplay(double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1),
            // Main illustration
            _buildImage(
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgetting_started_home.png?alt=media&token=c16b00a6-23b1-486b-bdb6-71effbf4fb24",
              height: screenWidth * 0.6,
              width: screenWidth * 0.8,
            ),
            const SizedBox(height: 40),
            // Title text
            Text(
              "Financial Literacy,\nlasts a lifetime",
              textAlign: TextAlign.center,
              style: GoogleFonts.fredoka(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // Subtitle text
            Text(
              "Don't settle for financial confusion\njoin the Money Monkey Revolution",
              textAlign: TextAlign.center,
              style: GoogleFonts.baloo2(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 40),
            // Buttons
            SizedBox(
              width: screenWidth * 0.8,
              child: Custombutton(
                text: 'Get Started',
                color: LightTheme().primaryBlue,
                isBordered: false,
                toNextPage: toGettingStarted,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: screenWidth * 0.8,
              child: Custombutton(
                text: 'Log In',
                color: LightTheme().primaryBackgroundColor,
                isBordered: true,
                toNextPage: toLoginPage,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
          ],
        ),
      ),
    );
  }

  Widget webDisplay(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side - Image
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: _buildImage(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FYour%20paragraph%20text%20(36).png?alt=media&token=4b9aae56-7e3a-4e84-82ca-99b2265bcc1b",
                height: screenHeight * 0.6,
                width: screenWidth * 0.4,
              ),
            ),
          ),
          const SizedBox(width: 60),
          // Right side - Text and buttons
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Financial Literacy,\nlasts a lifetime",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.fredoka(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Don't settle for financial confusion\njoin the Money Monkey Revolution",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    fontSize: 18,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 370,
                  height: 70,
                  child: Custombutton(
                    text: 'GET STARTED',
                    color: LightTheme().primaryBlue,
                    isBordered: false,
                    toNextPage: toGettingStarted,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 370,
                  height: 70,
                  child: Custombutton(
                    text: 'LOG IN',
                    color: LightTheme().primaryBackgroundColor,
                    isBordered: true,
                    toNextPage: toLoginPage,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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