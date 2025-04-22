import 'package:cloud_firestore/cloud_firestore.dart';

enum ReflectionFormat {
  textbox,
  chatBased,
  slider,
}

/// Represents the reflection component
class ReflectionPrompt {
  final String id;
  final List<String> prompts;
  final ReflectionFormat format;
  final bool enableAiSummary;
  final String? placeholderText;
  
  // For slider type
  final double? minValue;
  final double? maxValue;
  final String? minLabel;
  final String? maxLabel;

  ReflectionPrompt({
    required this.id,
    required this.prompts,
    required this.format,
    this.enableAiSummary = true,
    this.placeholderText,
    this.minValue,
    this.maxValue,
    this.minLabel,
    this.maxLabel,
  });

  factory ReflectionPrompt.fromMap(Map<String, dynamic> data) {
    return ReflectionPrompt(
      id: data['id'] ?? '',
      prompts: data['prompts'] != null 
          ? List<String>.from(data['prompts'])
          : [],
      format: ReflectionFormat.values.byName(data['format'] ?? 'textbox'),
      enableAiSummary: data['enableAiSummary'] ?? true,
      placeholderText: data['placeholderText'],
      minValue: data['minValue'],
      maxValue: data['maxValue'],
      minLabel: data['minLabel'],
      maxLabel: data['maxLabel'],
    );
  }

  factory ReflectionPrompt.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ReflectionPrompt(
      id: doc.id,
      prompts: data['prompts'] != null 
          ? List<String>.from(data['prompts'])
          : [],
      format: ReflectionFormat.values.byName(data['format'] ?? 'textbox'),
      enableAiSummary: data['enableAiSummary'] ?? true,
      placeholderText: data['placeholderText'],
      minValue: data['minValue'],
      maxValue: data['maxValue'],
      minLabel: data['minLabel'],
      maxLabel: data['maxLabel'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prompts': prompts,
      'format': format.name,
      'enableAiSummary': enableAiSummary,
      'placeholderText': placeholderText,
      'minValue': minValue,
      'maxValue': maxValue,
      'minLabel': minLabel,
      'maxLabel': maxLabel,
    };
  }

  Map<String, dynamic> toFirestore() {
    return toMap();
  }
}
