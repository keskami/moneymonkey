import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';
import 'package:money_monkey/LessonPages/Controllers/ScenarioController.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionQuizController.dart';
import 'package:money_monkey/LessonPages/Pages/LoadingScreen/loading.dart';

class LoadingPageWrapper extends StatelessWidget {
  final Widget destinationPage;
  final String componentId;

  const LoadingPageWrapper(
      {Key? key, required this.destinationPage, required this.componentId})
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
    switch (componentId[6]) {
      case '1':
        controller = Get.put<ComponentOneTwoController>(
          ComponentOneTwoController(componentId: componentId),
        );
        break;
      case '2':
        controller = Get.put<ComponentOneTwoController>(
            ComponentOneTwoController(componentId: componentId));
        break;
      case '3':
        controller =
            Get.put<StoryController>(
              StoryController(componentId: componentId));
        break;
      case '4':
        controller = Get.put<ScenarioController>(
            ScenarioController(componentId: componentId));
        break;
      case '5':
        controller = Get.put<PeerReflectioncontroller>(
            PeerReflectioncontroller(componentId: componentId));
        break;
      case '6':
        controller = Get.put<PeerReflectionQuizcontroller>(
            PeerReflectionQuizcontroller(componentId: componentId));
        break;
      default:
        throw Exception("Unknown component type");
    }
    return controller;
  }

  Future<void> _preLoadImages(BuildContext context) async {
    switch (componentId[6]) {
      case 'concept':
        await _preLoadImagesForLesson(context);
        break;
      case 'concept2':
        await _preLoadImagesForLesson(context);
        break;
      case 'story':
        await _preLoadImagesForStory(context);
        break;
      case 'scenario':
        await _preLoadImagesForScenario(context);
        break;
      case 'peer_reflection':
        await _preLoadImagesForPeerReflection(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingPage(
      destinationPage: destinationPage,
      preLoadImages: () => _preLoadImages(context),
      requiresController: true,
      pageType: componentId[6],
      initializeController: _initializeController,
    );
  }
}
