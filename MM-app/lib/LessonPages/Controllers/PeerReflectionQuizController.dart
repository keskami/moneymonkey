// peer_reflection_quiz_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/academics_service.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
import 'package:money_monkey/LessonPages/Services/lesson_services.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/QuizPages/QuizMCQ.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/QuizPages/QuizMCQImages.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/QuizPages/page3.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/QuizPages/page4.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/QuizPages/page5.dart';

class PeerReflectionQuizcontroller extends BaseLessonController {
  final LocalAcademicService localAcademicService = LocalAcademicService();
  final String componentId;

  PeerReflectionQuizcontroller({required this.componentId});

  RxInt pageIndex = 0.obs;
  RxBool isLoading = true.obs;

  RxList<Question> pageData = <Question>[].obs;

  String question = "";
  List<String> answers = [];
  Map<String, String> feedback = {};
  String correctAnswer = "";
  List<String> answerImages = [];

  List<Widget> pages = [];

  @override
  void onInit() {
    super.onInit();
    loadQuizData();
  }

  Future<void> loadQuizData() async {
    try {
      final Component data =
          await localAcademicService.getComponent(componentId);
      for (int i = 0; i < data.questionData.length; i++) {
        pageData.add(data.questionData[i]);
        if (pageData[i].type == QuestionType.quiztextmcquestion) {
          question = pageData[i].data.question;
          answers = pageData[i].data.options;
          correctAnswer = pageData[i].data.correctAnswers[0];
          feedback = pageData[i].data.feedbackMessages ?? {};
          pages.add(QuizMCQPage(
              question: question,
              answers: answers,
              feedback: feedback,
              correctAnswer: correctAnswer));
          print("REACHED");
        } else if (pageData[i].type == QuestionType.quizimagemcquestion) {
          try {
            question = pageData[i].data.question;

            // Add explicit type casting to String
            answers = pageData[i]
                .data
                .options
                .map<String>((QuizOption option) => option.text)
                .toList();

            answerImages = pageData[i]
                .data
                .options
                .map<String>((QuizOption option) => option.imageUrl ?? "")
                .toList();

            correctAnswer = pageData[i].data.correctAnswers[0];
            feedback = pageData[i].data.feedbackMessages ?? {};

            pages.add(QuizMCQImagesPage(
                question: question,
                answers: answers,
                answerImages: answerImages,
                feedback: feedback,
                correctAnswer: correctAnswer));
          } catch (e) {
            print("ERROR in image MCQ processing: $e");
          }
        }
      }
    } catch (e) {
      print("Error fetching quiz data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
