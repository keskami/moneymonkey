import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Component1_2Controller.dart';
import 'package:money_monkey/LessonPages/Models/Question_Model.dart';

// Assuming your model classes and extensions are already imported

Future<void> addQuestion(String lessonId, Question question) async {
  try {
    final questionRef = FirebaseFirestore.instance
        .collection('Lessons')
        .doc(lessonId)
        .collection('Questions');
    print(questionRef);
    // await questionRef.add(question.toMap());
    print("Question added successfully!");
  } catch (e) {
    print("Failed to add question: $e");
  }
}

void main() async {
  ComponentOneTwoController lessonOneController =
      Get.put(ComponentOneTwoController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  // Example question to add
  await lessonOneController.initializeFirebaseWithSampleQuestions("Lesson1");
}
