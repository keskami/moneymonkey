// lib/Backend/Controllers/ConversationsController.dart

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_monkey/Backend/Models/ChatBotConversation.dart';
import 'package:money_monkey/Backend/Models/OpenAiAssistant.dart';
import 'package:money_monkey/Backend/Services/OpenAIService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConversationController extends GetxController {
  // Storage keys
  final String _storageKey = 'chatbot_conversations';
  final String _assistantsKey = 'lesson_assistants';
  final storage = GetStorage();
  
  // Store conversation history by lesson ID
  final RxMap<String, Conversation> _conversationsByLesson = <String, Conversation>{}.obs;
  
  // Current conversation messages
  final RxList<Message> currentConversationMessages = <Message>[].obs;
  
  // Current lesson ID
  String _currentLessonId = '';
  
  // OpenAI service
  late OpenAIService _openAIService;
  
  // Map of assistants by lesson ID
  final RxMap<String, AssistantConfig> _assistantsByLesson = <String, AssistantConfig>{}.obs;
  
  // Loading state for API calls
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize OpenAI service with API key
    _initOpenAIService();
    
    // Load conversations and assistants from storage
    loadConversationsFromStorage();
    _loadAssistantsFromStorage();
  }
  
  void _initOpenAIService() {
    // Get API key from environment variables
    final apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      print('Warning: OpenAI API key not found');
    }
    _openAIService = OpenAIService(apiKey: apiKey);
  }

  // Register a new assistant for a specific lesson
  Future<void> registerAssistantForLesson(
    String lessonId, 
    String assistantId, 
    String name, 
    {String description = '', Map<String, dynamic>? metadata}
  ) async {
    // Create assistant config
    final config = AssistantConfig(
      assistantId: assistantId,
      name: name,
      description: description,
      metadata: metadata,
    );
    
    // Store in map
    _assistantsByLesson[lessonId] = config;
    
    // Setup with OpenAI service
    await _openAIService.setupAssistantForLesson(lessonId, assistantId);
    
    // Save to storage
    _saveAssistantsToStorage();
  }

  // Load a specific conversation based on lesson ID
  Future<void> loadConversationForLesson(String lessonId) async {
    // Clear current conversation messages
    currentConversationMessages.clear();
    
    // Set current lesson ID
    _currentLessonId = lessonId;
    
    // Check if we have a saved conversation for this lesson
    if (_conversationsByLesson.containsKey(lessonId)) {
      // Load existing conversation
      currentConversationMessages.addAll(_conversationsByLesson[lessonId]!.messages);
      
      // Load conversation history into OpenAI thread
      await _openAIService.loadConversationHistory(lessonId, currentConversationMessages);
    }
  }

  // Send user message to OpenAI assistant and get response
  Future<void> sendMessageToAssistant(String message) async {
    try {
      isLoading.value = true;
      
      // Add user message to conversation
      final userMessage = Message(
        text: message,
        isBot: false,
        time: DateTime.now(),
      );
      currentConversationMessages.add(userMessage);
      
      // Send to OpenAI and get response
      final assistantMessage = await _openAIService.sendMessage(_currentLessonId, message);
      currentConversationMessages.add(assistantMessage);
      
      // Save conversation
      saveConversation(_currentLessonId);
    } catch (e) {
      print('Error sending message to assistant: $e');
      
      // Add error message
      currentConversationMessages.add(
        Message(
          text: "I'm having trouble connecting right now. Please try again later.",
          isBot: true,
          time: DateTime.now(),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Add a message to the current conversation (for non-API messages)
  void addMessage(Message message) {
    currentConversationMessages.add(message);
  }

  // Save current conversation to history with lesson ID
  void saveConversation(String lessonId) {
    if (currentConversationMessages.isNotEmpty) {
      // Create a new conversation with current messages
      _conversationsByLesson[lessonId] = Conversation(
        messages: List.from(currentConversationMessages)
      );
      
      // Save to storage
      saveConversationsToStorage();
    }
  }

  // Clear current conversation
  Future<void> clearCurrentConversation() async {
    // Delete thread from OpenAI
    if (_currentLessonId.isNotEmpty) {
      await _openAIService.deleteThread(_currentLessonId);
    }
    
    // Clear local messages
    currentConversationMessages.clear();
  }

  // Persist conversations to local storage
  Future<void> saveConversationsToStorage() async {
    try {
      // Convert conversation map to a serializable format
      Map<String, dynamic> serializableMap = {};
      
      _conversationsByLesson.forEach((lessonId, conversation) {
        List<Map<String, dynamic>> serializedMessages = conversation.messages.map((message) => {
          'text': message.text,
          'isBot': message.isBot,
          'time': message.time.toIso8601String(),
        }).toList();
        
        serializableMap[lessonId] = {
          'messages': serializedMessages,
        };
      });
      
      // Save to GetStorage
      await storage.write(_storageKey, jsonEncode(serializableMap));
    } catch (e) {
      print('Error saving conversations: $e');
    }
  }

  // Load conversations from storage
  Future<void> loadConversationsFromStorage() async {
    try {
      final String? storedData = storage.read(_storageKey);
      
      if (storedData != null) {
        // Decode the JSON string
        Map<String, dynamic> decodedData = jsonDecode(storedData);
        
        // Clear existing conversations
        _conversationsByLesson.clear();
        
        // Rebuild conversations map
        decodedData.forEach((lessonId, conversationData) {
          List<dynamic> messagesData = conversationData['messages'];
          List<Message> messages = messagesData.map((messageData) => Message(
            text: messageData['text'],
            isBot: messageData['isBot'],
            time: DateTime.parse(messageData['time']),
          )).toList();
          
          _conversationsByLesson[lessonId] = Conversation(messages: messages);
        });
      }
    } catch (e) {
      print('Error loading conversations: $e');
    }
  }
  
  // Save assistants mapping to storage
  Future<void> _saveAssistantsToStorage() async {
    try {
      Map<String, dynamic> serializableMap = {};
      
      _assistantsByLesson.forEach((lessonId, config) {
        serializableMap[lessonId] = config.toMap();
      });
      
      await storage.write(_assistantsKey, jsonEncode(serializableMap));
    } catch (e) {
      print('Error saving assistants: $e');
    }
  }
  
  // Load assistants from storage
  Future<void> _loadAssistantsFromStorage() async {
    try {
      final String? storedData = storage.read(_assistantsKey);
      
      if (storedData != null) {
        Map<String, dynamic> decodedData = jsonDecode(storedData);
        
        _assistantsByLesson.clear();
        
        decodedData.forEach((lessonId, configData) {
          final config = AssistantConfig.fromMap(configData);
          _assistantsByLesson[lessonId] = config;
          
          // Setup with OpenAI service
          _openAIService.setupAssistantForLesson(lessonId, config.assistantId);
        });
      }
    } catch (e) {
      print('Error loading assistants: $e');
    }
  }

  // Get all conversations
  Map<String, Conversation> getAllConversations() {
    return _conversationsByLesson;
  }
  
  // Get assistant config for a lesson
  AssistantConfig? getAssistantForLesson(String lessonId) {
    return _assistantsByLesson[lessonId];
  }

  // Clear all conversation history
  Future<void> clearAllHistory() async {
    // Delete all threads
    for (var lessonId in _conversationsByLesson.keys) {
      await _openAIService.deleteThread(lessonId);
    }
    
    _conversationsByLesson.clear();
    currentConversationMessages.clear();
    storage.remove(_storageKey);
  }
  
  // Clear history for a specific lesson
  Future<void> clearConversationForLesson(String lessonId) async {
    if (_conversationsByLesson.containsKey(lessonId)) {
      // Delete thread
      await _openAIService.deleteThread(lessonId);
      
      _conversationsByLesson.remove(lessonId);
      saveConversationsToStorage();
      
      // If this was the current conversation, clear it
      if (lessonId == _currentLessonId) {
        clearCurrentConversation();
      }
    }
  }
  
  // Check if assistant is available for a lesson
  bool hasAssistantForLesson(String lessonId) {
    return _assistantsByLesson.containsKey(lessonId);
  }
}