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
  String? imageUrl;

  @override
  void initState() {
    super.initState();
  }

  void toLoginPage() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));

    //To Login Page
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const UserProfileScreen(),
    //     ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 17),
          Image.network(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgs_home_title.png?alt=media&token=e07fe466-46a3-4bbe-8d23-ff197ec67ce8",
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                // If loadingProgress is null, the image has fully loaded
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          const SizedBox(height: 45),
          Image.network(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fgetting_started_home.png?alt=media&token=c16b00a6-23b1-486b-bdb6-71effbf4fb24",
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                // If loadingProgress is null, the image has fully loaded
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              height: 230,
              width: 367,
              child: Center(
                child: Text('Unable to fetch Image.'),
              ),
            ),
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
          const Spacer(),
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
          const Spacer(),
        ],
      ),
    );
  }
}
