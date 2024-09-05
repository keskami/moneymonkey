import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GettingStarted/Widgets/custom_button.dart';
import 'package:money_monkey/themes/color_themes.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({super.key});

  @override
  State<GettingStartedPage> createState() => GettingStartedPageState();
}

class GettingStartedPageState extends State<GettingStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightTheme().primaryGreen,
      ),
      backgroundColor: LightTheme().primaryBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            ),
            Custombutton(
              text: 'Log In',
              color: LightTheme().primaryBackgroundColor,
              isBordered: true,
            ),
          ],
        ),
      ),
    );
  }
}
