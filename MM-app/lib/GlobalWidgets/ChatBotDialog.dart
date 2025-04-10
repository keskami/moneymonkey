import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Controllers/ConversationsController.dart';
import 'package:money_monkey/Backend/Models/ChatBotConversation.dart';

class ChatBotDialog extends StatefulWidget {
  final String lessonId; // Add a unique identifier for the lesson

  const ChatBotDialog({Key? key, required this.lessonId}) : super(key: key);

  @override
  _ChatBotDialogState createState() => _ChatBotDialogState();
}

class _ChatBotDialogState extends State<ChatBotDialog> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ConversationController _conversationController =
      Get.find<ConversationController>();

  @override
  void initState() {
    super.initState();

    // Load conversation if exists for this lesson ID
    _loadConversation();

    // Add initial greeting only if this is a new conversation
    if (_conversationController.currentConversationMessages.isEmpty) {
      _addMessage(
        Message(
          text:
              "Hello! I'm your personal financial assistant. How can I help you today?",
          isBot: true,
          time: DateTime.now(),
        ),
      );
    }
  }

  void _loadConversation() {
    // Check if we have a saved conversation for this lesson
    if (widget.lessonId.isNotEmpty) {
      // Find existing conversation or create new one
      _conversationController.loadConversationForLesson(widget.lessonId);
    }
  }

  void _addMessage(Message message) {
    _conversationController.addMessage(message);

    // Scroll to bottom after adding message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Bot response logic
    if (!message.isBot) {
      _generateBotResponse(message.text);
    }
  }

  void _generateBotResponse(String userMessage) {
    // Simple response logic - you can make this more sophisticated
    Future.delayed(const Duration(seconds: 1), () {
      String response;
      userMessage = userMessage.toLowerCase().trim();

      if (userMessage.contains('budget') || userMessage.contains('spending')) {
        response =
            "Great! I can help you track and manage your budget. What specific aspect would you like to discuss?";
      } else if (userMessage.contains('save') ||
          userMessage.contains('saving')) {
        response =
            "Saving money is crucial. I can provide tips on creating an effective saving strategy. What are your current saving goals?";
      } else if (userMessage.contains('invest') ||
          userMessage.contains('investment')) {
        response =
            "Investing can be a great way to grow your money. Would you like to explore some investment options?";
      } else {
        response =
            "I'm here to help with your financial questions. Feel free to ask about budgeting, saving, or investing.";
      }

      _addMessage(
        Message(text: response, isBot: true, time: DateTime.now()),
      );
    });
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    _addMessage(
      Message(text: text, isBot: false, time: DateTime.now()),
    );
  }

  @override
  void dispose() {
    // Save conversation when dialog is closed
    if (widget.lessonId.isNotEmpty) {
      _conversationController.saveConversation(widget.lessonId);
    } else {
      _conversationController.saveConversation("general");
    }

    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                        "assets/images/monkeyNoText.png",
                        height: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Hi, I\'m Minty, your personal financial assistant!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                ),

                // Chat Messages
                Expanded(
                  child: Obx(() => ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(10),
                        itemCount: _conversationController
                            .currentConversationMessages.length,
                        itemBuilder: (context, index) {
                          return _buildMessageWidget(_conversationController
                              .currentConversationMessages[index]);
                        },
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
          type:
              message.isBot ? BubbleType.receiverBubble : BubbleType.sendBubble,
        ),
        alignment: message.isBot ? Alignment.topLeft : Alignment.topRight,
        margin: const EdgeInsets.only(top: 10),
        backGroundColor:
            message.isBot ? Colors.blue.shade50 : Colors.green.shade50,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            message.text,
            style: TextStyle(
              color:
                  message.isBot ? Colors.blue.shade900 : Colors.green.shade900,
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
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
