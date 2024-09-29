import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Backend/Models/auth_service.dart'; // Import AuthService
import 'package:money_monkey/GettingStarted/Frontend/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/sign_in_button.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/sign_up_controller.dart';

class SUDetailsEmailPage extends StatefulWidget {
  const SUDetailsEmailPage({
    super.key,
  });

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

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 17,
          ),
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
          const SizedBox(
            height: 20,
          ),
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
          const Spacer(),
          // Sign in with Google button
          CustomSignInButton(
            color: Colors.white,
            isBordered: true,
            toNextPage: () async {
              await authService.googleAuth();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/google.png",
                  height: 41,
                ),
                const SizedBox(
                  width: 10,
                ),
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
          // Other sign-in buttons...
          CustomSignInButton(
            color: Colors.white,
            isBordered: true,
            toNextPage: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/facebook.png",
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
          CustomSignInButton(
            color: Colors.white,
            isBordered: true,
            toNextPage: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/apple.png",
                  height: 41,
                ),
                const SizedBox(
                  width: 10,
                ),
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
          const SizedBox(
            height: 134,
          ),
        ],
      ),
    );
  }
}

SignUpController signUpController = Get.put(SignUpController());
