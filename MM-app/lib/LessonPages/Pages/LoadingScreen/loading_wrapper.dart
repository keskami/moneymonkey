import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
import 'package:money_monkey/LessonPages/Controllers/StoryController.dart';
import 'package:money_monkey/LessonPages/Controllers/ScenarioController.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionQuizController.dart';
import 'package:money_monkey/LessonPages/Pages/LoadingScreen/loading.dart';

class LoadingPageWrapper extends StatelessWidget {
  final Widget destinationPage;
  final String pageType;
  final int lessonNumber;  
  final int unitNumber;

  const LoadingPageWrapper({
    Key? key,
    required this.destinationPage,
    required this.pageType,
    required this.lessonNumber,
    required this.unitNumber,
  }) : super(key: key);

  Future<void> _preLoadImagesForToolkit(BuildContext context) async {
    await precacheImage(
      NetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fl1toolkit1%2Fpiggy.png?alt=media&token=67260651-2b47-40bf-8d11-9cdd6e5cf6e4",
      ),
      context,
    );
    await precacheImage(
      NetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fl1toolkit1%2Fhouse.png?alt=media&token=870308c5-a116-429f-a711-6bc7186fb15c",
      ),
      context,
    );
    await precacheImage(
      NetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fl1toolkit1%2Fgrad.png?alt=media&token=110526d2-737d-4e6e-9dcf-8d1fd205d36a",
      ),
      context,
    );
  }

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

  Future<void> _initializeController() async {
    switch (pageType) {
      case 'concept':
        Get.put(ComponentOneTwoController(unitNumber: unitNumber, lessonNumber: lessonNumber, conceptNumber: 1));
        break;
      case 'concept2':
        Get.put(ComponentOneTwoController(unitNumber: unitNumber, lessonNumber: lessonNumber, conceptNumber: 2));
        break;
      case 'story':
        Get.put(StoryController(unitNumber: unitNumber, lessonNumber: lessonNumber));
        break;
      case 'scenario':
        Get.put(ScenarioController(unitNumber: unitNumber, lessonNumber: lessonNumber));
        break;
      case 'peer_reflection':
        Get.put(PeerReflectioncontroller(unitNumber: unitNumber, lessonNumber: lessonNumber));
        break;
      case 'peer_reflection_quiz':
        Get.put(PeerReflectionQuizcontroller(unitNumber: unitNumber, lessonNumber: lessonNumber));
        break;
    }
  }

  Future<void> _preLoadImages(BuildContext context) async {
    switch (pageType) {
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
      case 'toolkit':
        await _preLoadImagesForToolkit(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingPage(
      destinationPage: destinationPage,
      preLoadImages: () => _preLoadImages(context),
      requiresController: true,
      pageType: pageType,
      initializeController: _initializeController,
    );
  }
}
