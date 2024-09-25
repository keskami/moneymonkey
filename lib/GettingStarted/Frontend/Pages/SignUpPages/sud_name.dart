import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/sign_up_controller.dart';

class SUDetailsNamePage extends StatelessWidget {
  SUDetailsNamePage({
    super.key,
  });

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> submitName(String val) async {
      signUpController.name.value = nameController.text;
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
              controller: nameController,
              onChanged: (value) {
                submitName(value);
              },
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:
                    nameController.text.isEmpty ? "Name" : nameController.text,
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
                submitName(value);
              },
            ),
          )
        ],
      ),
    );
  }
}

SignUpController signUpController = Get.put(SignUpController());
