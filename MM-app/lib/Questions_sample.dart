import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  // Example question to add
  final question = Question(
    type: QuestionType.multipleChoice,
    data: MultipleChoice(
      questionId: 1,
      options: [
        "Once I have a full-time job",
        "As soon as I start earning money (even if it’s part-time or allowance)",
        "After I graduate from college.",
        "Only when I’m ready to plan for retirement.",
      ],
      correctAnswers: [
        "As soon as I start earning money (even if it’s part-time or allowance)"
      ],
      prompts: Prompt(
        correct: "Great job! That’s the right time to start saving.",
        incorrect: "That’s not quite right. Think about when you have income.",
      ),
    ),
  );

  // Replace "Lesson1" with the actual lesson ID
  await addQuestion("Lesson1", question);
}
