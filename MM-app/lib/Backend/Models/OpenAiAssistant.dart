// lib/Backend/Models/AssistantConfig.dart

class AssistantConfig {
  final String assistantId;
  final String name;
  final String description;
  final Map<String, dynamic>? metadata;
  
  AssistantConfig({
    required this.assistantId,
    required this.name,
    this.description = '',
    this.metadata,
  });
  
  factory AssistantConfig.fromMap(Map<String, dynamic> data) {
    return AssistantConfig(
      assistantId: data['assistantId'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      metadata: data['metadata'],
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'assistantId': assistantId,
      'name': name,
      'description': description,
      'metadata': metadata,
    };
  }
}