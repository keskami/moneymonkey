import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/option_tile.dart';
import 'package:money_monkey/GettingStarted/Frontend/controller/sign_up_controller.dart';

class SUDetailsUsernamePage extends StatefulWidget {
  SUDetailsUsernamePage({
    super.key,
  });

  @override
  State<SUDetailsUsernamePage> createState() => _SUDetailsUsernamePageState();
}

class _SUDetailsUsernamePageState extends State<SUDetailsUsernamePage> {
  final TextEditingController nameController = TextEditingController();

  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    void submitUsername(String val) {
      signUpController.username.value = val;
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
              "Choose a Username",
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
              controller: nameController,
              onChanged: (value) {
                submitUsername(value);
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
                submitUsername(value);
              },
            ),
          )
        ],
      ),
    );
  }
}
