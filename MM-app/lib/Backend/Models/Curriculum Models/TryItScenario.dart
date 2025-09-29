import 'package:cloud_firestore/cloud_firestore.dart';

class ScenarioStep {
  final String id;
  final String scenarioContext;
  final List<ScenarioChoice> choices;
  final Map<String, dynamic>? metadata;

  ScenarioStep({
    required this.id,
    required this.scenarioContext,
    required this.choices,
    this.metadata,
  });

  factory ScenarioStep.fromMap(Map<String, dynamic> data) {
    return ScenarioStep(
      id: data['id'] ?? '',
      scenarioContext: data['content'] ?? '',
      choices: (data['choices'] as List?)
          ?.map((choice) => ScenarioChoice.fromMap(choice))
          .toList() ?? [],
      metadata: data['metadata'],
    );
  }

  factory ScenarioStep.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ScenarioStep(
      id: doc.id,
      scenarioContext: data['content'] ?? '',
      choices: (data['choices'] as List?)
          ?.map((choice) => ScenarioChoice.fromMap(choice))
          .toList() ?? [],
      metadata: data['metadata'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': scenarioContext,
      'choices': choices.map((choice) => choice.toMap()).toList(),
      'metadata': metadata,
    };
  }

  Map<String, dynamic> toFirestore() {
    return toMap();
  }
}

/// Represents a choice in a scenario step
class ScenarioChoice {
  final String id;
  final String text;
  final String nextStepId;
  final Map<String, dynamic>? valueTrackingData;

  ScenarioChoice({
    required this.id,
    required this.text,
    required this.nextStepId,
    this.valueTrackingData,
  });

  factory ScenarioChoice.fromMap(Map<String, dynamic> data) {
    return ScenarioChoice(
      id: data['id'] ?? '',
      text: data['text'] ?? '',
      nextStepId: data['nextStepId'] ?? '',
      valueTrackingData: data['valueTrackingData'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'nextStepId': nextStepId,
      'valueTrackingData': valueTrackingData,
    };
  }
}

/// Represents a complete scenario for the Try It section
class TryItScenario {
  final String id;
  final String title;
  final String description;
  final List<ScenarioStep> steps;
  final Map<String, ScenarioStep> stepMap;
  final String initialStepId;
  final Map<String, dynamic>? dynamicEventConfig;

  TryItScenario({
    required this.id,
    required this.title,
    required this.description,
    required this.steps,
    required this.initialStepId,
    this.dynamicEventConfig,
  }) : stepMap = {for (var step in steps) step.id: step};

  factory TryItScenario.fromMap(Map<String, dynamic> data) {
    final steps = (data['steps'] as List?)
        ?.map((step) => ScenarioStep.fromMap(step))
        .toList() ?? [];
    
    return TryItScenario(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      steps: steps,
      initialStepId: data['initialStepId'] ?? '',
      dynamicEventConfig: data['dynamicEventConfig'],
    );
  }

  factory TryItScenario.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    final steps = (data['steps'] as List?)
        ?.map((step) => ScenarioStep.fromMap(step))
        .toList() ?? [];
    
    return TryItScenario(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      steps: steps,
      initialStepId: data['initialStepId'] ?? '',
      dynamicEventConfig: data['dynamicEventConfig'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'steps': steps.map((step) => step.toMap()).toList(),
      'initialStepId': initialStepId,
      'dynamicEventConfig': dynamicEventConfig,
    };
  }

  Map<String, dynamic> toFirestore() {
    return toMap();
  }

  ScenarioStep? getStepById(String id) {
    return stepMap[id];
  }
}

