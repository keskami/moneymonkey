import 'package:cloud_firestore/cloud_firestore.dart';

enum ExitCheckFormat {
  quiz,
  goalSetting,
  aiReflection,
}

/// Represents a quiz question for the exit check
class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final String correctOption;
  final String? explanation;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOption,
    this.explanation,
  });

  factory QuizQuestion.fromMap(Map<String, dynamic> data) {
    return QuizQuestion(
      id: data['id'] ?? '',
      question: data['question'] ?? '',
      options: data['options'] != null
          ? List<String>.from(data['options'])
          : [],
      correctOption: data['correctOption'] ?? '',
      explanation: data['explanation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctOption': correctOption,
      'explanation': explanation,
    };
  }
}

/// Represents the exit check component
class ExitCheck {
  final String id;
  final ExitCheckFormat format;
  final List<QuizQuestion>? quizQuestions;
  final String? goalPrompt;
  final String? reflectionPrompt;
  final bool enableAiFeedback;
  final Map<String, dynamic>? progressConfig;

  ExitCheck({
    required this.id,
    required this.format,
    this.quizQuestions,
    this.goalPrompt,
    this.reflectionPrompt,
    this.enableAiFeedback = true,
    this.progressConfig,
  });

  factory ExitCheck.fromMap(Map<String, dynamic> data) {
    return ExitCheck(
      id: data['id'] ?? '',
      format: ExitCheckFormat.values.byName(data['format'] ?? 'quiz'),
      quizQuestions: data['quizQuestions'] != null
          ? (data['quizQuestions'] as List)
              .map((q) => QuizQuestion.fromMap(q))
              .toList()
          : null,
      goalPrompt: data['goalPrompt'],
      reflectionPrompt: data['reflectionPrompt'],
      enableAiFeedback: data['enableAiFeedback'] ?? true,
      progressConfig: data['progressConfig'],
    );
  }

  factory ExitCheck.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ExitCheck(
      id: doc.id,
      format: ExitCheckFormat.values.byName(data['format'] ?? 'quiz'),
      quizQuestions: data['quizQuestions'] != null
          ? (data['quizQuestions'] as List)
              .map((q) => QuizQuestion.fromMap(q))
              .toList()
          : null,
      goalPrompt: data['goalPrompt'],
      reflectionPrompt: data['reflectionPrompt'],
      enableAiFeedback: data['enableAiFeedback'] ?? true,
      progressConfig: data['progressConfig'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'format': format.name,
      'quizQuestions': quizQuestions?.map((q) => q.toMap()).toList(),
      'goalPrompt': goalPrompt,
      'reflectionPrompt': reflectionPrompt,
      'enableAiFeedback': enableAiFeedback,
      'progressConfig': progressConfig,
    };
  }

  Map<String, dynamic> toFirestore() {
    return toMap();
  }
}
