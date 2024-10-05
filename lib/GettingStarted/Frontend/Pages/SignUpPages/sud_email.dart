import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Services/auth_service.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/sign_in_button.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/sign_up_controller.dart';
import 'package:money_monkey/temporary_login.dart';

class SUDetailsEmailPage extends StatefulWidget {
  const SUDetailsEmailPage({super.key});

  @override
  State<SUDetailsEmailPage> createState() => _SUDetailsEmailPageState();
}

class _SUDetailsEmailPageState extends State<SUDetailsEmailPage> {
  final TextEditingController emailController = TextEditingController();
  final AuthService authService =
      AuthService(); // Create an instance of AuthService

  @override
  Widget build(BuildContext context) {
    Future<void> submitEmail(String val) async {
      signUpController.email.value = val;
    }

    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Automatically resize when keyboard pops up
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.all(16.0), // Optional padding for better UI
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 17),
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Text(
                    "What is your email, ${signUpController.name.value}?",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomOptionTile(
                  childWidget: TextField(
                    onChanged: (value) {
                      submitEmail(value);
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: emailController.text.isEmpty
                          ? "Email"
                          : emailController.text,
                      hintStyle: const TextStyle(
                        fontSize: 23,
                      ),
                    ),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 178, 182, 182),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    onSubmitted: (value) {
                      submitEmail(value);
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.5,
                ),
                // Sign in with Google button
                CustomSignInButton(
                  color: Colors.white,
                  isBordered: true,
                  toNextPage: () async {
                    await authService.googleAuth(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fgoogle_logo.png?alt=media&token=b1cc9b7e-785b-4af5-9e37-9af74d69eeb9",
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
                        height: 41,
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "Sign in with Google",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // Sign in with Facebook button
                CustomSignInButton(
                  color: Colors.white,
                  isBordered: true,
                  toNextPage: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Ffacebook_logo.png?alt=media&token=a1810c16-71d9-4537-9201-6d7c47d22577",
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
                        height: 41,
                      ),
                      const Text(
                        "Sign in with Facebook",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // Sign in with Apple button
                CustomSignInButton(
                  color: Colors.white,
                  isBordered: true,
                  toNextPage: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
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
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fapple_logo.png?alt=media&token=151b1835-0e40-4bf7-b6d2-61dc70de963b",
                        height: 41,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Sign in with Apple",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 134), // For spacing at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}

SignUpController signUpController = Get.put(SignUpController());
