import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_monkey/Backend/Models/ChatBotConversation.dart';

class ConversationController extends GetxController {
  // Storage key
  final String _storageKey = 'chatbot_conversations';
  final storage = GetStorage();
  
  // Store conversation history by lesson ID
  final RxMap<String, Conversation> _conversationsByLesson = <String, Conversation>{}.obs;
  
  // Current conversation messages
  final RxList<Message> currentConversationMessages = <Message>[].obs;
  
  // Current lesson ID
  String _currentLessonId = '';

  @override
  void onInit() {
    super.onInit();
    // Load conversations from storage when controller initializes
    loadConversationsFromStorage();
  }

  // Load a specific conversation based on lesson ID
  void loadConversationForLesson(String lessonId) {
    // Clear current conversation messages
    currentConversationMessages.clear();
    
    // Set current lesson ID
    _currentLessonId = lessonId;
    
    // Check if we have a saved conversation for this lesson
    if (_conversationsByLesson.containsKey(lessonId)) {
      // Load existing conversation
      currentConversationMessages.addAll(_conversationsByLesson[lessonId]!.messages);
    }
  }

  // Log a new message to the current conversation
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
  void clearCurrentConversation() {
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

  // Get all conversations
  Map<String, Conversation> getAllConversations() {
    return _conversationsByLesson;
  }

  // Clear all conversation history
  void clearAllHistory() {
    _conversationsByLesson.clear();
    currentConversationMessages.clear();
    storage.remove(_storageKey);
  }
  
  // Clear history for a specific lesson
  void clearConversationForLesson(String lessonId) {
    if (_conversationsByLesson.containsKey(lessonId)) {
      _conversationsByLesson.remove(lessonId);
      saveConversationsToStorage();
      
      // If this was the current conversation, clear it
      if (lessonId == _currentLessonId) {
        clearCurrentConversation();
      }
    }
  }
}