import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GettingStarted/Widgets/custom_button.dart';
import 'package:money_monkey/GettingStarted/controller/intro_pages_controller.dart';
import 'package:money_monkey/LoginPages/login.dart';
import 'package:money_monkey/themes/color_themes.dart';

class GettingStartedPage1 extends StatefulWidget {
  const GettingStartedPage1({super.key});

  @override
  State<GettingStartedPage1> createState() => GettingStartedPage1State();
}

GettingStartedController gettingStartedController =
    Get.put(GettingStartedController());

void toGettingStarted() {
  gettingStartedController.pageIndex.value = 1;
}

void toNextPage() {
  gettingStartedController.pageIndex.value += 1;
}

class GettingStartedPage1State extends State<GettingStartedPage1> {
  final storageRef = FirebaseStorage.instance.ref();

  void toLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return screenWidth > screenHeight
        ? webDisplay(screenWidth)
        : mobileDisplay();
  }

  Widget mobileDisplay() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 17),
            _buildImage(
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgs_home_title.png?alt=media&token=e07fe466-46a3-4bbe-8d23-ff197ec67ce8",
            ),
            const SizedBox(height: 45),
            _buildImage(
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgetting_started_home.png?alt=media&token=c16b00a6-23b1-486b-bdb6-71effbf4fb24",
              height: 230,
              width: 367,
            ),
            const SizedBox(height: 20),
            Text(
              "Financial Literacy,\nlasts a lifetime",
              textAlign: TextAlign.center,
              style: GoogleFonts.fredoka(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Don’t settle for financial confusion\njoin the Money Monkey Revolution",
              textAlign: TextAlign.center,
              style: GoogleFonts.baloo2(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            Custombutton(
              text: 'Get Started',
              color: LightTheme().primaryBlue,
              isBordered: false,
              toNextPage: toGettingStarted,
            ),
            Custombutton(
              text: 'Log In',
              color: LightTheme().primaryBackgroundColor,
              isBordered: true,
              toNextPage: toLoginPage,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget webDisplay(double screenWidth) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: screenWidth * 0.4,
              child: _buildImage(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgetting_started_home.png?alt=media&token=c16b00a6-23b1-486b-bdb6-71effbf4fb24",
                height: screenWidth * 0.4,
                width: screenWidth * 0.4,
              ),
            ),
            Container(
              width: screenWidth * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  _buildImage(
                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgs_home_title.png?alt=media&token=e07fe466-46a3-4bbe-8d23-ff197ec67ce8",
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Financial Literacy,\nlasts a lifetime",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.fredoka(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Don’t settle for financial confusion\njoin the Money Monkey Revolution",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.baloo2(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Custombutton(
                    text: 'Get Started',
                    color: LightTheme().primaryBlue,
                    isBordered: false,
                    toNextPage: toGettingStarted,
                  ),
                  const SizedBox(height: 16),
                  Custombutton(
                    text: 'Log In',
                    color: LightTheme().primaryBackgroundColor,
                    isBordered: true,
                    toNextPage: toLoginPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String url, {double? height, double? width}) {
    return Image.network(
      url,
      height: height,
      width: width,
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
