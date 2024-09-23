import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/custom_button.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/intro_pages_controller.dart';
import 'package:money_monkey/login.dart';
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
  void toLoginPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  } //Needs to be integrated once Login Page is shifted to main and replace the toNextPage fn

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 17,
          ),
          Image.asset(
            "assets/images/gs_home_title.png",
          ),
          const SizedBox(
            height: 45,
          ),
          Image.asset(
            "assets/images/getting_started_home.png",
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              height: 230,
              width: 367,
              child: Center(
                child: Text('Unable to fetch Image.'),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Financial Literacy,\nlasts a lifetime",
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            "Don’t settle for financial confusion\njoin the Money Monkey Revolution",
            textAlign: TextAlign.center,
            style: GoogleFonts.baloo2(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 64,
          ),
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
        ],
      ),
    );
  }
}
