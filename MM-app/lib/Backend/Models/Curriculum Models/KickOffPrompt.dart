import 'package:cloud_firestore/cloud_firestore.dart';

class KickoffPrompt {
  final String id;
  final String prompt;
  final bool isSkippable;
  final List<String> followUpQuestions;

  KickoffPrompt({
    required this.id,
    required this.prompt,
    this.isSkippable = true,
    this.followUpQuestions = const [],
  });

  factory KickoffPrompt.fromMap(Map<String, dynamic> data) {
    return KickoffPrompt(
      id: data['id'] ?? '',
      prompt: data['prompt'] ?? '',
      isSkippable: data['isSkippable'] ?? true,
      followUpQuestions: data['followUpQuestions'] != null
          ? List<String>.from(data['followUpQuestions'])
          : [],
    );
  }

  factory KickoffPrompt.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return KickoffPrompt(
      id: doc.id,
      prompt: data['prompt'] ?? '',
      isSkippable: data['isSkippable'] ?? true,
      followUpQuestions: data['followUpQuestions'] != null
          ? List<String>.from(data['followUpQuestions'])
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prompt': prompt,
      'isSkippable': isSkippable,
      'followUpQuestions': followUpQuestions,
    };
  }

  Map<String, dynamic> toFirestore() {
    return toMap();
  }
}
