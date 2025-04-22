import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:money_monkey/Backend/Controllers/ConversationsController.dart';
import 'package:money_monkey/Backend/Services/AssistantConfigService.dart';

/// Service for initializing all AI-related services
class AIServiceInitializer extends GetxService {
  
  /// Initialize all AI-related services
  /// Call this during app startup
  static Future<void> initAIServices() async {
    // Load environment variables for API keys
    await dotenv.load(fileName: "keys.env");
    
    // Initialize conversation controller
    final conversationController = ConversationController();
    Get.put(conversationController);
    
    // Initialize assistant config service
    final assistantConfigService = AssistantConfigService();
    Get.put(assistantConfigService);
    await assistantConfigService.init();
    
    print('AI services initialized successfully');
  }
}