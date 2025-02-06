import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_monkey/LessonPages/Models/Concept1_2.dart';

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
