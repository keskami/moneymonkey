import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/StudentData.dart';
import 'package:money_monkey/Backend/Services/auth_service.dart';
import 'package:money_monkey/Backend/Services/firestore_service.dart';
import 'package:money_monkey/GettingStarted/Widgets/continue_button.dart';
import 'package:money_monkey/GettingStarted/Widgets/progress_bar.dart';
import 'package:money_monkey/GettingStarted/controller/intro_pages_controller.dart';
import 'package:money_monkey/GettingStarted/controller/sign_up_controller.dart';
import 'package:money_monkey/GettingStarted/controller/start_fresh_controller.dart';
import 'package:money_monkey/home.dart';
import 'package:money_monkey/themes/color_themes.dart';

class SignUpDetailsHome extends GetView<SignUpController> {
  const SignUpDetailsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return _SignUpDetailsHomeView();
  }
}

class _SignUpDetailsHomeView extends StatefulWidget {
  @override
  State<_SignUpDetailsHomeView> createState() => _SignUpDetailsHomeViewState();
}

class _SignUpDetailsHomeViewState extends State<_SignUpDetailsHomeView> {
  // ✅ Find controllers that were created by the binding
  late final SignUpController signUpController;
  
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    signUpController = Get.put(SignUpController());
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });
  }

  @override
  void dispose() {
    Get.delete<SignUpController>();
    super.dispose();
  }

  void fetchUserData() async {
    FirestoreService firestoreService = FirestoreService();

    // Pass the user's ID (you might fetch it from FirebaseAuth.currentUser.uid)
    Student? userData = await firestoreService.getUserData('someUserId');

    if (userData != null) {
      print("User Email: ${userData.email}");
      print("User Age: ${userData.age}");
      print("User Profile Name: ${userData.profile.fullName}");
    } else {
      print("User data not found.");
    }
  }

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
    // } else if (currentIndex == 2 &&
    //     signUpController.phoneNumber.value.isNotEmpty &&
    //     signUpController.phoneNumber.value.length < 10) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       backgroundColor: Colors.white,
    //       content: Text(
    //         "Enter a valid Phone Number.",
    //       ),
    //     ),
    //   );
    //   return;
    } else if (currentIndex == 2 &&
        !(await AuthService()
            .checkEmailUsed(signUpController.email.value, context))) {
      return;
    } else if (currentIndex == 3 &&
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
    } else if (currentIndex + 1 == 4) {
      try {
        await AuthService().signUpUser(context);

        // ✅ Use GetX navigation for consistency and prevent back navigation
        Get.offAll(
          () => HomePage(),
          predicate: (route) => false, // Clear entire navigation stack
        );

        return;
      } catch (e) {
        // Show error message
        Get.snackbar('Error', 'Failed to sign up. Please try again.');
      }
    }
    signUpController.pageIndex.value += 1;
  }

  // Add the toPreviousPage function like in StartFreshHome
  void toPreviousPage() {
    int currentIndex = signUpController.pageIndex.value;
    if (currentIndex > 0) {
      signUpController.pageIndex.value -= 1;
    } else {
      // ✅ Use GetX navigation for consistency
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchUserData();
    
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: LightTheme().primaryBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.02), // Add consistent padding like StartFreshHome
          child: Column(
            children: [
              const SizedBox(height: 10), // Match StartFreshHome spacing
              // Add the back button and progress bar row like in StartFreshHome
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: toPreviousPage,
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 37,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.8,
                    child: CustomProgressBar(
                      page: 1,
                    ),
                  ),
                  const Spacer(),
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
      ),
// Update your floatingActionButton Obx section with this improved validation:

      floatingActionButton: Obx(() {
        int currentPageIndex = signUpController.pageIndex.value;
        
        // Helper function to check if name is valid (not empty after trimming)
        bool isNameValid() {
          return signUpController.name.value.trim().isNotEmpty;
        }
        
        // Helper function to check if username is valid
        bool isUsernameValid() {
          return signUpController.username.value.trim().isNotEmpty;
        }
        
        // Helper function to check if email is valid
        bool isEmailValid() {
          return signUpController.email.value.trim().isNotEmpty && 
                signUpController.email.value.isEmail;
        }
        
        // Helper function to check if password is valid
        bool isPasswordValid() {
          return signUpController.password.value.isNotEmpty && 
                signUpController.password.value.length >= 6;
        }

        // Don't show button when keyboard is visible
        if (_isKeyboardVisible) {
          return const SizedBox.shrink();
        }

        // Name page validation
        if (currentPageIndex == 0) {
          return Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: NextButton(
              isEnabled: isNameValid(),
              nextPage: toNextPage,
            ),
          );
        }
        
        // Username page validation
        else if (currentPageIndex == 1) {
          return Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: NextButton(
              isEnabled: isUsernameValid(),
              nextPage: toNextPage,
            ),
          );
        }
        
        // Email page validation
        else if (currentPageIndex == 2) {
          return Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: NextButton(
              isEnabled: isEmailValid(),
              nextPage: toNextPage,
            ),
          );
        }
        
        // Password page validation
        else if (currentPageIndex == 3) {
          return Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: NextButton(
              isEnabled: isPasswordValid(),
              nextPage: toNextPage,
            ),
          );
        }
        
        // Default enabled for other pages
        else {
          return Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: NextButton(
              isEnabled: true,
              nextPage: toNextPage,
            ),
          );
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}