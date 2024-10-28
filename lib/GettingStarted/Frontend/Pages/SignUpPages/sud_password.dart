import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/sign_up_controller.dart';

class SUDetailsPasswordPage extends StatefulWidget {
  SUDetailsPasswordPage({
    super.key,
  });

  @override
  State<SUDetailsPasswordPage> createState() => _SUDetailsPasswordPageState();
}

class _SUDetailsPasswordPageState extends State<SUDetailsPasswordPage> {
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> submitPassword(String val) async {
      signUpController.password.value = val;
    }

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 17,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 22),
            child: Text(
              "What is your password?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomOptionTile(
            isSelected: false,
            childWidget: TextField(
              autofocus: true,
              onChanged: (value) {
                submitPassword(value);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: passwordController.text.isEmpty
                    ? "Password"
                    : passwordController.text,
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
                submitPassword(value);
              },
            ),
          )
        ],
      ),
    );
  }
}

SignUpController signUpController = Get.put(SignUpController());
