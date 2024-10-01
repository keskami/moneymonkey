import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moneymonkey/widgets/custom_app_bar.dart';
import 'package:moneymonkey/widgets/lesson_card.dart';


import '../controller/controller.dart';

 // Import AppRoutes

class LessonPage extends StatelessWidget {
  final ProgressController progressController = Get.put(ProgressController());

  LessonPage({Key? key}) : super(key: key);

  @override
Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF),
        appBar: CustomAppBar(progressController: progressController), // Use the custom app bar
        body: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  child: const LessonCard(), // Use the LessonCard widget
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

