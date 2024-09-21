import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';

class SUDetailsEmailPage extends StatelessWidget {
  SUDetailsEmailPage({
    super.key,
    required this.signUpController,
  });
  final signUpController;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 17),
          const Text(
            "What is your name?",
            style: TextStyle(fontSize: 27),
          ),
          const SizedBox(height: 20),
          CustomOptionTile(
            childWidget: TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: signUpController.name.value.isEmpty
                    ? "Name"
                    : signUpController.name.value,
                hintStyle: const TextStyle(fontSize: 23),
              ),
              style: const TextStyle(
                color: Color.fromARGB(255, 178, 182, 182),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              onSubmitted: (value) {
                signUpController.name.value =
                    value; // Update the name in controller
              },
            ),
          ),
        ],
      ),
    );
  }
}
