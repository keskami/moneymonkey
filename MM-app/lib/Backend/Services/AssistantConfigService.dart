// lib/Backend/Services/AssistantConfigService.dart

import 'package:get/get.dart';
import 'package:money_monkey/Backend/Controllers/ConversationsController.dart';
import 'package:money_monkey/Backend/Models/Curriculum%20Models/ExitCheck.dart';
import 'package:money_monkey/Backend/Models/Curriculum%20Models/Lesson.dart';

/// Service for managing assistant configurations for lessons
class AssistantConfigService extends GetxService {
  // Get conversation controller
  final ConversationController _conversationController =
      Get.find<ConversationController>();

  // Map of default assistant IDs by lesson type or component
  final Map<String, String> _defaultAssistants = {
    'General Financial': 'asst_lE0rWT5ClaMGRGVFOBP44QR2',
    'Budgeting Education': 'asst_6pdI9EAQ0GoaiA5b5yx7zE1R',
    'Investing Education': 'asst_Jn3NnhTQ80HXAnFYXYXf5rRD',
    'Try-It Scenario': 'asst_vEUIdTbI3c6iMWGYc3JoeJV7',
    'Reflection': 'asst_R5uiQO3lB06XGS2MxqCeenFH',
    'Exit Check': 'asst_IZgxSKH40t9EpW7gDhpnKYIM',
  };

  /// Initialize the service (call this during app startup)
  Future<void> init() async {
    // Any initialization logic here
  }

  /// Configure assistants for a specific lesson
  /// This loads appropriate assistants based on lesson content
  Future<void> configureAssistantsForLesson(Lesson lesson) async {
    // Main lesson assistant
    await _conversationController.registerAssistantForLesson(
      lesson.id,
      _getAssistantIdForLesson(lesson),
      'Minty',
      description: 'Financial assistant for ${lesson.title}',
      metadata: {
        'botName': 'Minty',
        'botImageAsset': 'assets/images/monkeyNoText.png',
        'lessonTitle': lesson.title,
      },
    );

    // TryIt scenario assistant
    await _conversationController.registerAssistantForLesson(
      '${lesson.id}_tryit',
      _defaultAssistants['tryit'] ?? _defaultAssistants['general']!,
      'Scenario Guide',
      description: 'Guide for ${lesson.tryItScenario.title}',
      metadata: {
        'botName': 'Scenario Guide',
        'botImageAsset': 'assets/images/scenario_guide.png',
        'scenarioTitle': lesson.tryItScenario.title,
      },
    );

    // Reflection assistant
    await _conversationController.registerAssistantForLesson(
      '${lesson.id}_reflection',
      _defaultAssistants['reflection'] ?? _defaultAssistants['general']!,
      'Reflection Helper',
      description: 'Reflection helper for ${lesson.title}',
      metadata: {
        'botName': 'Reflection Helper',
        'botImageAsset': 'assets/images/reflection_helper.png',
      },
    );

    // Exit check assistant
    if (lesson.exitCheck.format == ExitCheckFormat.aiReflection) {
      await _conversationController.registerAssistantForLesson(
        '${lesson.id}_exitcheck',
        _defaultAssistants['exitcheck'] ?? _defaultAssistants['general']!,
        'Quiz Helper',
        description: 'Exit check helper for ${lesson.title}',
        metadata: {
          'botName': 'Quiz Helper',
          'botImageAsset': 'assets/images/quiz_helper.png',
        },
      );
    }
  }

  /// Determine the best assistant ID for a lesson based on its content
  String _getAssistantIdForLesson(Lesson lesson) {
    // This is a simplistic example - you'd want to analyze the lesson content
    // to determine the most appropriate assistant

    final title = lesson.title.toLowerCase();

    if (title.contains('budget') || title.contains('spending')) {
      return _defaultAssistants['budgeting'] ?? _defaultAssistants['general']!;
    } else if (title.contains('invest') || title.contains('stock')) {
      return _defaultAssistants['investing'] ?? _defaultAssistants['general']!;
    } else if (title.contains('save') || title.contains('saving')) {
      return _defaultAssistants['saving'] ?? _defaultAssistants['general']!;
    }

    // Default general assistant
    return _defaultAssistants['general']!;
  }

  /// Get component-specific lesson ID
  String getLessonComponentId(String lessonId, String component) {
    return '${lessonId}_$component';
  }
}
