import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymonkey/controller/controller.dart';
import 'package:moneymonkey/widgets/custom_app_bar.dart';
import 'package:moneymonkey/widgets/image_grid.dart';
import 'package:moneymonkey/widgets/continue_button.dart';

class QuestionPage extends StatelessWidget {
  final ProgressController progressController = Get.put(ProgressController()); // Initializing ProgressController

  QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF),
        appBar: CustomAppBar(progressController: progressController),
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 16),
              const SizedBox(
                width: 306,
                child: Text(
                  "Which of the following\nhas been used as money the longest?",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 28,
                    fontFamily: 'Baloo 2',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 52),
              ImageGrid(), // Moved to its own widget
            ],
          ),
        ),
        bottomNavigationBar: const ContinueButtonSection(), // Moved to its own widget
      ),
    );
  }
}
