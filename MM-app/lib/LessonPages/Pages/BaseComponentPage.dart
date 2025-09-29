import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/LessonPages/Widgets/LessonPages/lesson_progress_bar.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/home.dart';

class BaseComponentPage extends StatefulWidget {
  final ComponentType pageType;
  const BaseComponentPage({super.key, required this.pageType});

  @override
  State<BaseComponentPage> createState() => _BaseComponentPage();
}

class _BaseComponentPage extends State<BaseComponentPage> {
  final String lessonId = "Lesson1";
  late BaseLessonController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<BaseLessonController>();
  }

  @override
  void dispose() {
    // Preserve lesson controller to maintain progress on re-entry
    super.dispose();
  }

  Future<void> _preLoadImages() async {
    await precacheImage(
        NetworkImage(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FCheck%20circle.png?alt=media&token=52726418-7a0a-4b6c-9207-1efa735199af"),
        context);
    await precacheImage(
        NetworkImage(
            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FWrong%20X.png?alt=media&token=7502b819-8b30-4120-8222-305534358c8c"),
        context);
  }

  @override
  Widget build(BuildContext context) {
    _preLoadImages();
    return Scaffold(
      body: Obx(
        () {
          final pages = controller.pages;
          final idx = controller.pageIndex.value;
          return Column(
            children: [
              LessonProgressBar(
                currentPage: idx,
                currentProgress: 1.0,
                totalPages: pages.length,
              ),
              Expanded(child: pages[idx]),
            ],
          );
        },
      ),
    );
  }
}
