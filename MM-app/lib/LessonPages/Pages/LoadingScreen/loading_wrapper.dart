import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/AcademicServices.dart';
import 'package:money_monkey/Backend/Services/DirectFirebaseService.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Pages/LoadingScreen/loading.dart';

class LoadingPageWrapper extends StatelessWidget {
  final ComponentType type;
  final String componentId;

  const LoadingPageWrapper(
      {Key? key, required this.type, required this.componentId})
      : super(key: key);

  Future<void> _preLoadImagesForPeerReflection(BuildContext context) async {
    await precacheImage(
        AssetImage('assets/images/newMonkeys/Maria.png'), context);
    await precacheImage(
        AssetImage('assets/images/newMonkeys/Jason.png'), context);
    await precacheImage(
        AssetImage('assets/images/newMonkeys/Ava.png'), context);
    await precacheImage(
        AssetImage('assets/images/img_monkeymoney_52.png'), context);
  }

  Future<void> _preLoadImagesForScenario(BuildContext context) async {
    await precacheImage(
      NetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Fsneakers%201.png?alt=media&token=625bdbab-4e8d-42cd-82b4-8f79a1bedf3f",
      ),
      context,
    );
    await precacheImage(
      NetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Fcollege%201.png?alt=media&token=cd5510da-9563-41a8-a2eb-bd13594312a3",
      ),
      context,
    );
    await precacheImage(
      NetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FStory1%2Factivities%201.png?alt=media&token=8a2aa7b5-e154-4aa9-ae20-44cfc38e01a7",
      ),
      context,
    );
  }

  Future<void> _preLoadImagesForStory(BuildContext context) async {
    await precacheImage(
      NetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
      ),
      context,
    );
    await precacheImage(
      NetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FStoryPages%2FDIamond.png?alt=media&token=98ad4d6e-dbda-4112-9e0c-d0429eef9d37",
      ),
      context,
    );
  }

  Future<void> _preLoadImagesForLesson(BuildContext context) async {
    await precacheImage(
      NetworkImage(
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FCheck%20circle.png?alt=media&token=52726418-7a0a-4b6c-9207-1efa735199af"),
      context,
    );
    await precacheImage(
      NetworkImage(
          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FLessonPages%2FWrong%20X.png?alt=media&token=7502b819-8b30-4120-8222-305534358c8c"),
      context,
    );
  }

  Future<BaseLessonController> _initializeController() async {
    BaseLessonController controller;
    
    controller = Get.put<BaseLessonController>(
      BaseLessonController(componentId: componentId, type: type),
    );

    return controller;
  }

  Future<void> _preLoadImages(BuildContext context) async {
    final localService = DirectFirebaseService();
    final Component component = await localService.getComponent(componentId);

    switch (component.type) {
      case ComponentType.concept:
      case ComponentType.interactiveActivity:
        await _preLoadImagesForLesson(context);
        break;
      case ComponentType.story:
        await _preLoadImagesForStory(context);
        break;
      case ComponentType.scenarioSimulation:
        await _preLoadImagesForScenario(context);
        break;
      case ComponentType.peerReflection:
      case ComponentType.quiz:
        await _preLoadImagesForPeerReflection(context);
        break;
      case ComponentType.toolkit:
        await _preLoadImagesForLesson(context);
        break;
      default:
        print(
            "Warning: No specific preload images for component type: ${component.type}");
        // Load default images or perform minimal preloading
        await _preLoadImagesForLesson(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingPage(
      preLoadImages: () => _preLoadImages(context),
      requiresController: true,
      pageType: type,
      initializeController: _initializeController,
    );
  }
}
