import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemChrome
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Backend/Models/auth_service.dart';
import 'package:money_monkey/GettingStarted/Backend/Models/firestore_service.dart';
import 'package:money_monkey/GettingStarted/Backend/Models/user_data.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/emptyLoggedIn.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/next_button.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/progress_bar.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/sign_up_controller.dart';
import 'package:money_monkey/themes/color_themes.dart';

class SignUpDetailsHome extends StatefulWidget {
  const SignUpDetailsHome({super.key});

  @override
  State<SignUpDetailsHome> createState() => _SignUpDetailsHomeState();
}

class _SignUpDetailsHomeState extends State<SignUpDetailsHome> {
  final SignUpController signUpController = Get.put(SignUpController());

  void fetchUserData() async {
    FirestoreService firestoreService = FirestoreService();

    // Pass the user's ID (you might fetch it from FirebaseAuth.currentUser.uid)
    UserData? userData = await firestoreService.getUserData('someUserId');

    if (userData != null) {
      print("User Email: ${userData.email}");
      print("User Age: ${userData.age}");
      print("User Profile Name: ${userData.profile.fullName}");
    } else {
      print("User data not found.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: LightTheme().primaryGreen,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    fetchUserData();
    void toNextPage() async {
      int currentIndex = signUpController.pageIndex.value;

      if (currentIndex == 0 && signUpController.name.value.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Enter a Name.")));
        return;
      }
      if (currentIndex == 1 && !signUpController.email.value.isEmail) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Enter a valid email.")));
        return;
      }
      if (currentIndex == 0 && signUpController.name.value.isEmpty ||
          signUpController.password.value.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Enter a valid Password.")));
        return;
      }
      if (currentIndex == 2) {
        // This is the final step, where user data is completed

        try {
          await AuthService().signUpUser();

          // Navigate to the next page (e.g., dashboard)
          // Get.to(DashboardPage());
        } catch (e) {
          // Show error message
          Get.snackbar('Error', 'Failed to sign up. Please try again.');
        }
      }
      if (currentIndex + 1 == 3) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => const PopScope(
                      canPop: false,
                      child: Emptyloggedin(),
                    )));
      } else {
        signUpController.pageIndex.value += 1;
      }
    }

    void toPreviousPage() {
      int currentIndex = signUpController.pageIndex.value;
      if (currentIndex > 0) {
        signUpController.pageIndex.value -= 1;
      } else {
        Navigator.pop(context);
      }
    }

    return Scaffold(
      backgroundColor: LightTheme().primaryBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Distribute space between widgets
              children: [
                SizedBox(
                  width: 70,
                ),
                Expanded(
                  child: CustomProgressBar(
                    page: 1,
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                int pageIndex = signUpController.pageIndex.value;
                if (pageIndex < signUpController.pages.length) {
                  return signUpController.pages[pageIndex];
                } else {
                  return const Center(child: Text('Invalid page index'));
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => signUpController.pageIndex.value >= 0 &&
                signUpController.pageIndex.value < signUpController.pages.length
            ? Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: NextButton(
                  pages: 2,
                  nextPage: toNextPage,
                ),
              )
            : const SizedBox.shrink(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
