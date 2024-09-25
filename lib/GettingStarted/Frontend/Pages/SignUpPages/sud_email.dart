import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/sign_up_controller.dart';

class SUDetailsEmailPage extends StatelessWidget {
  SUDetailsEmailPage({
    super.key,
  });

  final TextEditingController emailController = TextEditingController();
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
          )
        ],
      ),
    );
  }
}

SignUpController signUpController = Get.put(SignUpController());
