import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressionModel {
  final String userId;
  final int level;
  final int unit;
  final int lesson;
  final Map<String,dynamic> lessonDetails;

  ProgressionModel({
  required this.userId,
  required this.level,
  required this.unit,
  required this.lesson,
  required this.lessonDetails
});

 // Convert Firestore document to ProgressionModel
  factory ProgressionModel.fromDocument(DocumentSnapshot doc) {
    return ProgressionModel(
      userId: doc.id,
      level: doc['level'],
      unit: doc['unit'],
      lesson: doc['lesson'],
      lessonDetails: doc['lessonDetails'],
    );
  }

  // Convert ProgressionModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'unit': unit,
      'lesson': lesson,
      'lessonDetails': lessonDetails,
    };
  }
}







