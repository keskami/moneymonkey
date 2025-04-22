// lib/Backend/Services/OpenAIService.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_monkey/Backend/Models/ChatBotConversation.dart';

class OpenAIService {
  final String _baseUrl = 'https://api.openai.com/v1';
  final String _apiKey;
  
  // Map to store thread IDs for each lesson
  final Map<String, String> _threadsByLesson = {};
  
  // Map to store assistant IDs for each lesson
  final Map<String, String> _assistantsByLesson = {};
  
  OpenAIService({required String apiKey}) : _apiKey = apiKey {
    if (_apiKey.isEmpty) {
      print('Warning: OpenAI API key is empty');
    }
  }
  
  // Initialize an assistant for a specific lesson
  Future<void> setupAssistantForLesson(String lessonId, String assistantId) async {
    _assistantsByLesson[lessonId] = assistantId;
  }
  
  // Get or create a thread for a lesson
  Future<String> _getOrCreateThreadForLesson(String lessonId) async {
    // Return existing thread if we have one
    if (_threadsByLesson.containsKey(lessonId)) {
      return _threadsByLesson[lessonId]!;
    }
    
    // Create a new thread
    final response = await http.post(
      Uri.parse('$_baseUrl/threads'),
      headers: _getHeaders(),
      body: jsonEncode({}),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final threadId = data['id'];
      _threadsByLesson[lessonId] = threadId;
      return threadId;
    } else {
      throw Exception('Failed to create thread: ${response.body}');
    }
  }
  
  // Send a message to the assistant and get the response
  Future<Message> sendMessage(String lessonId, String userMessage) async {
    try {
      // Get the thread ID for this lesson
      final threadId = await _getOrCreateThreadForLesson(lessonId);
      
      // Get the assistant ID for this lesson
      final assistantId = _assistantsByLesson[lessonId];
      if (assistantId == null) {
        throw Exception('No assistant configured for lesson: $lessonId');
      }
      
      // Add the user message to the thread
      await _addMessageToThread(threadId, userMessage);
      
      // Run the assistant on the thread
      final runId = await _runAssistant(threadId, assistantId);
      
      // Wait for the run to complete
      await _waitForRunCompletion(threadId, runId);
      
      // Get the assistant's response
      final assistantMessage = await _getAssistantResponse(threadId);
      
      return Message(
        text: assistantMessage,
        isBot: true,
        time: DateTime.now(),
      );
    } catch (e) {
      print('Error sending message to OpenAI: $e');
      return Message(
        text: "I'm having trouble connecting right now. Please try again later.",
        isBot: true,
        time: DateTime.now(),
      );
    }
  }
  
  // Add a message to a thread
  Future<void> _addMessageToThread(String threadId, String content) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/threads/$threadId/messages'),
      headers: _getHeaders(),
      body: jsonEncode({
        'role': 'user',
        'content': content,
      }),
    );
    
    if (response.statusCode != 200) {
      throw Exception('Failed to add message to thread: ${response.body}');
    }
  }
  
  // Run the assistant on a thread
  // In your OpenAIService.dart
Future<String> _runAssistant(String threadId, String assistantId) async {
  print('Attempting to run assistant with ID: $assistantId on thread: $threadId');
  
  final response = await http.post(
    Uri.parse('$_baseUrl/threads/$threadId/runs'),
    headers: _getHeaders(),
    body: jsonEncode({
      'assistant_id': assistantId,
    }),
  );
  
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Successfully created run with ID: ${data['id']}');
    return data['id'];
  } else {
    final error = 'Failed to run assistant: ${response.body}';
    print(error);
    throw Exception(error);
  }
}
  
  // Wait for a run to complete
  Future<void> _waitForRunCompletion(String threadId, String runId) async {
    bool isCompleted = false;
    int attempts = 0;
    const maxAttempts = 30; // Timeout after 30 attempts
    
    while (!isCompleted && attempts < maxAttempts) {
      final response = await http.get(
        Uri.parse('$_baseUrl/threads/$threadId/runs/$runId'),
        headers: _getHeaders(),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['status'];
        
        if (status == 'completed') {
          isCompleted = true;
        } else if (status == 'failed' || status == 'cancelled' || status == 'expired') {
          throw Exception('Run ended with status: $status');
        } else {
          // Wait before checking again
          await Future.delayed(const Duration(seconds: 1));
          attempts++;
        }
      } else {
        throw Exception('Failed to check run status: ${response.body}');
      }
    }
    
    if (!isCompleted) {
      throw Exception('Run timed out');
    }
  }
  
  // Get the assistant's response from a thread
  Future<String> _getAssistantResponse(String threadId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/threads/$threadId/messages'),
      headers: _getHeaders(),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final messages = data['data'];
      
      // Get the latest assistant message
      for (var message in messages) {
        if (message['role'] == 'assistant') {
          // Extract the content - this may need adjustment based on the actual response format
          return message['content'][0]['text']['value'];
        }
      }
      
      throw Exception('No assistant response found');
    } else {
      throw Exception('Failed to get messages: ${response.body}');
    }
  }
  
  // Load conversation history into a thread
  Future<void> loadConversationHistory(String lessonId, List<Message> messages) async {
    try {
      // Create a new thread for this conversation
      final response = await http.post(
        Uri.parse('$_baseUrl/threads'),
        headers: _getHeaders(),
        body: jsonEncode({}),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to create thread for history: ${response.body}');
      }
      
      final data = jsonDecode(response.body);
      final threadId = data['id'];
      _threadsByLesson[lessonId] = threadId;
      
      // Add each message to the thread in chronological order
      for (var message in messages) {
        await http.post(
          Uri.parse('$_baseUrl/threads/$threadId/messages'),
          headers: _getHeaders(),
          body: jsonEncode({
            'role': message.isBot ? 'assistant' : 'user',
            'content': message.text,
          }),
        );
      }
    } catch (e) {
      print('Error loading conversation history: $e');
    }
  }
  
  // Delete a thread when conversation is cleared
  Future<void> deleteThread(String lessonId) async {
    if (_threadsByLesson.containsKey(lessonId)) {
      final threadId = _threadsByLesson[lessonId]!;
      
      try {
        final response = await http.delete(
          Uri.parse('$_baseUrl/threads/$threadId'),
          headers: _getHeaders(),
        );
        
        if (response.statusCode == 200) {
          _threadsByLesson.remove(lessonId);
        }
      } catch (e) {
        print('Error deleting thread: $e');
      }
    }
  }
  
  // HTTP headers with API key and beta version
  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
      'OpenAI-Beta': 'assistants=v2', // Updated to use v2 version
    };
  }
}