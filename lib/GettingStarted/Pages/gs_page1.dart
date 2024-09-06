import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GettingStarted/Widgets/custom_button.dart';
import 'package:money_monkey/GettingStarted/controller/gs_controller.dart';
import 'package:money_monkey/themes/color_themes.dart';

class GettingStartedPage1 extends StatefulWidget {
  const GettingStartedPage1({super.key});

  @override
  State<GettingStartedPage1> createState() => GettingStartedPage1State();
}

GettingStartedController gettingStartedController =
    Get.put(GettingStartedController());
void toLoginPage() {}
void toGettingStarted() {
  gettingStartedController.pageIndex.value = 1;
}

void toNextPage() {
  gettingStartedController.pageIndex.value += 1;
}

class GettingStartedPage1State extends State<GettingStartedPage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 17,
            ),
            Image.asset(
              "assets/gs_home_title.png",
            ),
            const SizedBox(
              height: 45,
            ),
            Image.asset(
              "assets/getting_started_home.png",
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
              toNextPage: toNextPage,
            ),
          ],
        ),
      ),
    );
  }
}
