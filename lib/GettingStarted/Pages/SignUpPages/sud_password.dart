import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/controller/sign_up_controller.dart';

class SUDetailsPasswordPage extends StatefulWidget {
  const SUDetailsPasswordPage({
    super.key,
  });

  @override
  State<SUDetailsPasswordPage> createState() => _SUDetailsNamePageState();
}

SignUpController signUpController = Get.put(SignUpController());

class _SUDetailsNamePageState extends State<SUDetailsPasswordPage> {
  @override
  Widget build(BuildContext context) {
    Future<void> submitAge(String val) async {
      signUpController.name.value = val;
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
              "What is your name?",
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
            childWidget: TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: signUpController.name.value.isEmpty
                    ? "Name"
                    : signUpController.name.value.toString(),
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
                submitAge(value);
              },
            ),
          )
        ],
      ),
    );
  }
}
