import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page1.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page2.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page3.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page4.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page5.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page6.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Page8.dart';
import 'package:money_monkey/LessonPages/LessonOnePages/Reflection.dart';
import 'package:money_monkey/LessonPages/Models/Question_Model.dart';

import '../LessonOnePages/Page7.dart';

class LessonOneController extends GetxController {
  RxInt pageIndex = 0.obs;

  // To store fetched questions
  List<Question> questions = <Question>[];

  var pages = [
    L1Page1(),
    L1Page2(),
    L1Page3(),
    L1Page4(),
    L1Page5(),
    L1Page6(),
    L1Page7(),
    L1Page8(),
    L1Reflection(),
  ];

  DocumentReference<Map<String, dynamic>> getLessonDocRef(String lessonId) {
    return FirebaseFirestore.instance.collection('Lessons').doc(lessonId);
  }

  Future<void> fetchQuestions(String lessonId) async {
    try {
      final docRef = getLessonDocRef(lessonId);
      final snapshot = await docRef.get();
      if (snapshot.exists) {
        print("Document found for lesson: $lessonId");
        final data = snapshot.data()!;
        questions = data.entries
            .where((entry) => entry.key.startsWith('Question'))
            .map((entry) {
          return Question.fromMap(entry.value as Map<String, dynamic>);
        }).toList();
        print("Questions stored in RxList: ${questions}"); // Updated line
      } else {
        print("No document found for lesson: $lessonId");
      }
    } catch (e) {
      print("Error fetching questions: $e");
      rethrow;
    }
  }

  Future<void> addQuestion(
      String lessonId, String fieldName, Question question) async {
    try {
      final docRef = getLessonDocRef(lessonId);
      await docRef.update({fieldName: question.toMap()});
      print("Question added successfully!");
    } catch (e) {
      print("Error adding question: $e");
      rethrow;
    }
  }

  /// Get the current question based on the page index
  Question? get currentQuestion {
    if (pageIndex.value < questions.length) {
      return questions[pageIndex.value];
    }
    return null;
  }
}
