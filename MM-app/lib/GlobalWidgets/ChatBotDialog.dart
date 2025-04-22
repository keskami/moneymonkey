// lib/Frontend/Widgets/ChatBotDialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Controllers/ConversationsController.dart';
import 'package:money_monkey/Backend/Models/ChatBotConversation.dart';
import 'package:money_monkey/Backend/Models/OpenAiAssistant.dart';

class ChatBotDialog extends StatefulWidget {
  final String lessonId;
  final String? initialGreeting;

  const ChatBotDialog({
    Key? key, 
    required this.lessonId,
    this.initialGreeting,
  }) : super(key: key);

  @override
  _ChatBotDialogState createState() => _ChatBotDialogState();
}

class _ChatBotDialogState extends State<ChatBotDialog> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final ConversationController _conversationController;
  
  bool _isInitialized = false;
  String _botName = 'Minty';
  String _botImageAsset = "assets/images/monkeyNoText.png";

  @override
  void initState() {
    super.initState();
    
    // Find or create conversation controller
    _conversationController = Get.find<ConversationController>();
    
    // Initialize conversation
    _initializeConversation();
  }
  
  Future<void> _initializeConversation() async {
    // Load conversation if exists for this lesson ID
    if (widget.lessonId.isNotEmpty) {
      await _conversationController.loadConversationForLesson(widget.lessonId);
      
      // Get assistant config if available
      final config = _conversationController.getAssistantForLesson(widget.lessonId);
      if (config != null) {
        _updateBotInfo(config);
      }
    }
    
    // Add initial greeting only if this is a new conversation
    if (_conversationController.currentConversationMessages.isEmpty && widget.initialGreeting != null) {
      _conversationController.addMessage(
        Message(
          text: widget.initialGreeting!,
          isBot: true,
          time: DateTime.now(),
        ),
      );
    } else if (_conversationController.currentConversationMessages.isEmpty) {
      // Default greeting if no custom one provided
      _conversationController.addMessage(
        Message(
          text: "Hello! I'm $_botName, your personal financial assistant. How can I help you today?",
          isBot: true,
          time: DateTime.now(),
        ),
      );
    }
    
    setState(() {
      _isInitialized = true;
    });
  }
  
  void _updateBotInfo(AssistantConfig config) {
    if (config.metadata != null) {
      if (config.metadata!.containsKey('botName')) {
        _botName = config.metadata!['botName'];
      }
      
      if (config.metadata!.containsKey('botImageAsset')) {
        _botImageAsset = config.metadata!['botImageAsset'];
      }
    }
  }

  // Scroll to bottom after adding message
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;

    _textController.clear();
    
    // Send message to assistant and get response
    await _conversationController.sendMessageToAssistant(text);
    
    // Scroll to bottom
    _scrollToBottom();
  }

  @override
  void dispose() {
    // Save conversation when dialog is closed
    if (widget.lessonId.isNotEmpty) {
      _conversationController.saveConversation(widget.lessonId);
    }

    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    
    return Dialog(
      alignment: Alignment.bottomRight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth * 0.35,
            height: constraints.maxHeight * 0.95,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                // Dialog Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        _botImageAsset,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Hi, I'm $_botName, your personal financial assistant!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Chat Messages
                Expanded(
                  child: Obx(() => Stack(
                    children: [
                      ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(10),
                        itemCount: _conversationController.currentConversationMessages.length,
                        itemBuilder: (context, index) {
                          return _buildMessageWidget(_conversationController.currentConversationMessages[index]);
                        },
                      ),
                      
                      // Loading indicator
                      if (_conversationController.isLoading.value)
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.blue.shade800,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "$_botName is thinking...",
                                    style: TextStyle(color: Colors.blue.shade800),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  )),
                ),

                // Input Area
                _buildInputArea(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageWidget(Message message) {
    return Align(
      alignment: message.isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: ChatBubble(
        clipper: ChatBubbleClipper6(
          type: message.isBot ? BubbleType.receiverBubble : BubbleType.sendBubble,
        ),
        alignment: message.isBot ? Alignment.topLeft : Alignment.topRight,
        margin: const EdgeInsets.only(top: 10),
        backGroundColor: message.isBot ? Colors.blue.shade50 : Colors.green.shade50,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            message.text,
            style: TextStyle(
              color: message.isBot ? Colors.blue.shade900 : Colors.green.shade900,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: _handleSubmitted,
              enabled: !_conversationController.isLoading.value,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _conversationController.isLoading.value 
                ? null 
                : () => _handleSubmitted(_textController.text),
            color: Colors.blue,
            disabledColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}