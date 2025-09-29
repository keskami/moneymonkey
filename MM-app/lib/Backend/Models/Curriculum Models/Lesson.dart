// lib/models/lesson.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_monkey/Backend/Models/Curriculum%20Models/ExitCheck.dart';
import 'package:money_monkey/Backend/Models/Curriculum%20Models/KickOffPrompt.dart';
import 'package:money_monkey/Backend/Models/Curriculum%20Models/LearnIt.dart';
import 'package:money_monkey/Backend/Models/Curriculum%20Models/ReflectionPrompt.dart';
import 'package:money_monkey/Backend/Models/Curriculum%20Models/TryItScenario.dart';

/// Represents a complete lesson with all its components
class Lesson {
  final String id;
  final String title;
  final String description;
  final KickoffPrompt kickoffPrompt;
  final List<LearnIt> learnItCards;
  final TryItScenario tryItScenario;
  final ReflectionPrompt reflectionPrompt;
  final ExitCheck exitCheck;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.kickoffPrompt,
    required this.learnItCards,
    required this.tryItScenario,
    required this.reflectionPrompt,
    required this.exitCheck,
    this.isPublished = false,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a Lesson from a Firestore DocumentSnapshot
  factory Lesson.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Lesson(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      kickoffPrompt: KickoffPrompt.fromMap(data['kickoffPrompt']),
      learnItCards: (data['learnItCards'] as List)
          .map((card) => LearnIt.fromMap(card))
          .toList(),
      tryItScenario: TryItScenario.fromMap(data['tryItScenario']),
      reflectionPrompt: ReflectionPrompt.fromMap(data['reflectionPrompt']),
      exitCheck: ExitCheck.fromMap(data['exitCheck']),
      isPublished: data['isPublished'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert lesson to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'kickoffPrompt': kickoffPrompt.toMap(),
      'learnItCards': learnItCards.map((card) => card.toMap()).toList(),
      'tryItScenario': tryItScenario.toMap(),
      'reflectionPrompt': reflectionPrompt.toMap(),
      'exitCheck': exitCheck.toMap(),
      'isPublished': isPublished,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}

/// Represents the kickoff prompt component (AI-Led)


/// Represents a scenario step in the Try It section
/// Format options for reflection component

/// Format options for exit check component

// lib/models/student_progress.dart
class ComponentProgress {
  final String componentId;
  final bool isCompleted;
  final DateTime? completedAt;
  final Map<String, dynamic>? data;

  ComponentProgress({
    required this.componentId,
    required this.isCompleted,
    this.completedAt,
    this.data,
  });

  factory ComponentProgress.fromMap(Map<String, dynamic> data) {
    return ComponentProgress(
      componentId: data['componentId'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      completedAt: data['completedAt'] != null 
          ? (data['completedAt'] as Timestamp).toDate()
          : null,
      data: data['data'],
    );
  }

  factory ComponentProgress.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ComponentProgress(
      componentId: data['componentId'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      completedAt: data['completedAt'] != null 
          ? (data['completedAt'] as Timestamp).toDate()
          : null,
      data: data['data'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'componentId': componentId,
      'isCompleted': isCompleted,
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'data': data,
    };
  }

  Map<String, dynamic> toFirestore() {
    return toMap();
  }
}

class LessonProgress {
  final String lessonId;
  final String studentId;
  final bool isCompleted;
  final DateTime startedAt;
  final DateTime? completedAt;
  final ComponentProgress? kickoffProgress;
  final ComponentProgress? learnItProgress;
  final ComponentProgress? tryItProgress;
  final ComponentProgress? reflectionProgress;
  final ComponentProgress? exitCheckProgress;
  final Map<String, dynamic>? analytics;

  LessonProgress({
    required this.lessonId,
    required this.studentId,
    required this.isCompleted,
    required this.startedAt,
    this.completedAt,
    this.kickoffProgress,
    this.learnItProgress,
    this.tryItProgress,
    this.reflectionProgress,
    this.exitCheckProgress,
    this.analytics,
  });

  factory LessonProgress.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return LessonProgress(
      lessonId: data['lessonId'] ?? '',
      studentId: data['studentId'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      startedAt: (data['startedAt'] as Timestamp).toDate(),
      completedAt: data['completedAt'] != null 
          ? (data['completedAt'] as Timestamp).toDate() 
          : null,
      kickoffProgress: data['kickoffProgress'] != null 
          ? ComponentProgress.fromMap(data['kickoffProgress']) 
          : null,
      learnItProgress: data['learnItProgress'] != null 
          ? ComponentProgress.fromMap(data['learnItProgress']) 
          : null,
      tryItProgress: data['tryItProgress'] != null 
          ? ComponentProgress.fromMap(data['tryItProgress']) 
          : null,
      reflectionProgress: data['reflectionProgress'] != null 
          ? ComponentProgress.fromMap(data['reflectionProgress']) 
          : null,
      exitCheckProgress: data['exitCheckProgress'] != null 
          ? ComponentProgress.fromMap(data['exitCheckProgress']) 
          : null,
      analytics: data['analytics'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'lessonId': lessonId,
      'studentId': studentId,
      'isCompleted': isCompleted,
      'startedAt': Timestamp.fromDate(startedAt),
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'kickoffProgress': kickoffProgress?.toMap(),
      'learnItProgress': learnItProgress?.toMap(),
      'tryItProgress': tryItProgress?.toMap(),
      'reflectionProgress': reflectionProgress?.toMap(),
      'exitCheckProgress': exitCheckProgress?.toMap(),
      'analytics': analytics,
    };
  }
}

// lib/models/ai_response.dart
class AIResponse {
  final String id;
  final String prompt;
  final String response;
  final String type;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;

  AIResponse({
    required this.id,
    required this.prompt,
    required this.response,
    required this.type,
    this.metadata,
    required this.createdAt,
  });

  factory AIResponse.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return AIResponse(
      id: doc.id,
      prompt: data['prompt'] ?? '',
      response: data['response'] ?? '',
      type: data['type'] ?? '',
      metadata: data['metadata'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'prompt': prompt,
      'response': response,
      'type': type,
      'metadata': metadata,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}