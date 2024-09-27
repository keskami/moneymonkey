import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller.dart'; // Import the controller

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ProgressController progressController;

  const CustomAppBar({Key? key, required this.progressController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.black),
        onPressed: () {
          Get.back(); // Close the screen
        },
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Obx(() => ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: progressController.progress.value, // Use progress value
                  backgroundColor: const Color(0xFFF0F0F0), // Light gray background
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                  minHeight: 20,
                ),
              )),
            ),
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/img_monkeymoney_52.png',
                height: 35,
              ),
              const SizedBox(width: 6),
              const Text(
                '3',
                style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
