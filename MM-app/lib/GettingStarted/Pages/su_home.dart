import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/user_data.dart';
import 'package:money_monkey/Backend/Services/auth_service.dart';
import 'package:money_monkey/Backend/Services/firestore_service.dart';
import 'package:money_monkey/GettingStarted/Widgets/continue_button.dart';
import 'package:money_monkey/GettingStarted/Widgets/progress_bar.dart';
import 'package:money_monkey/GettingStarted/controller/intro_pages_controller.dart';
import 'package:money_monkey/GettingStarted/controller/sign_up_controller.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';
import 'package:money_monkey/home.dart';
import 'package:money_monkey/themes/color_themes.dart';

class SignUpDetailsHome extends StatefulWidget {
  const SignUpDetailsHome({super.key});

  @override
  State<SignUpDetailsHome> createState() => _SignUpDetailsHomeState();
}

class _SignUpDetailsHomeState extends State<SignUpDetailsHome> {
  final SignUpController signUpController = Get.put(SignUpController());
  bool _isKeyboardVisible = false;

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
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });
  }

  StartFreshController startFreshController = Get.put(StartFreshController());
  GettingStartedController gettingStartedController =
      Get.put(GettingStartedController());
  @override
  Widget build(BuildContext context) {
    fetchUserData();
    void toNextPage() async {
      int currentIndex = signUpController.pageIndex.value;

      print(currentIndex);
      if (currentIndex == 0 && signUpController.name.value.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Enter a Name.",
            ),
          ),
        );
        return;
      } else if (currentIndex == 2 &&
          signUpController.phoneNumber.value.isNotEmpty &&
          signUpController.phoneNumber.value.length < 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "Enter a valid Phone Number.",
            ),
          ),
        );
        return;
      } else if (currentIndex == 3 &&
          !(await AuthService()
              .checkEmailUsed(signUpController.email.value, context))) {
        return;
      } else if (currentIndex == 4 &&
          (signUpController.password.value.isEmpty ||
              signUpController.password.value.length < 6)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Enter a valid password (min 6 characters).",
            ),
          ),
        );
        return;
      } else if (currentIndex + 1 == 5) {
        try {
          await AuthService().signUpUser(context);

          // Navigate to the next page (e.g., dashboard)
          // Get.to(DashboardPage());
        } catch (e) {
          // Show error message
          Get.snackbar('Error', 'Failed to sign up. Please try again.');
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => PopScope(
              canPop: false,
              child: HomePage(),
            ),
          ),
        );
      }
      signUpController.pageIndex.value += 1;
    }

    // void toPreviousPage() {
    //   int currentIndex = signUpController.pageIndex.value;
    //   if (currentIndex > 0) {
    //     signUpController.pageIndex.value -= 1;
    //   } else {
    //     Navigator.pop(context);
    //   }
    // }

    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: toPreviousPage,
      //       icon: Icon(
      //         Icons.arrow_back,
      //       ),
      //     ),
      //   ],
      // ),
      backgroundColor: LightTheme().primaryBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            Row(
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
      floatingActionButton: Obx(() {
        //For No Empty Name
        if (!_isKeyboardVisible &&
            signUpController.pageIndex.value == 0 &&
            signUpController.name.value.isEmpty) {
          return Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: NextButton(
              isEnabled: false,
              nextPage: toNextPage,
            ),
          );
        }
        //For Non Empty Username
        else if (!_isKeyboardVisible &&
            signUpController.pageIndex.value == 1 &&
            signUpController.username.value.isEmpty) {
          return Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: NextButton(
              isEnabled: false,
              nextPage: toNextPage,
            ),
          );
        }
        //For non empty Email
        else if (!_isKeyboardVisible &&
            signUpController.pageIndex.value == 3 &&
            (signUpController.pageIndex.value == 3 ||
                signUpController.email.value.isEmpty) &&
            !signUpController.email.value.isEmail) {
          return Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: NextButton(
              isEnabled: false,
              nextPage: toNextPage,
            ),
          );
        }
        //For Non Empty Password
        else if (!_isKeyboardVisible &&
            signUpController.pageIndex.value == 4 &&
            (signUpController.pageIndex.value == 4 ||
                signUpController.password.value.isEmpty) &&
            signUpController.password.value.length < 6) {
          return Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: NextButton(
              isEnabled: false,
              nextPage: toNextPage,
            ),
          );
        } else if (!_isKeyboardVisible) {
          return Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: NextButton(
              isEnabled: true,
              nextPage: toNextPage,
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
