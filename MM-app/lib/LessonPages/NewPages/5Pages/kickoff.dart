import 'package:flutter/material.dart';
import 'dart:async';

class KickoffComponent extends StatefulWidget {
  final double height;
  final double width;
  KickoffComponent({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  _KickoffComponentState createState() => _KickoffComponentState();
}

class _KickoffComponentState extends State<KickoffComponent> {
  // Fill with some example prompts
  final List<String> messagePrompts = [
    "I feel anxious when I think about money.",
    "Money represents freedom and opportunity.",
    "I'm not sure how I feel about money.",
    "I enjoy spending money on experiences."
  ];
  // Fill with starting message
  final String startingMessage =
      "What emotions come to mind when you think about money? Do you feel excited, anxious, confident, or something else?";
  List<Map<String, dynamic>> messages = [];

  TextEditingController inputController = TextEditingController();
  bool isTyping = false;

  final ScrollController _scrollController = ScrollController();

  Map<String, dynamic> currentProgress = {
    'currentSection': 0,
    'showLearnIt': false,
  };

  @override
  void initState() {
    super.initState();
    messages = [
      {
        'id': 1,
        'sender': 'ai',
        'content': startingMessage,
      }
    ];
  }

  @override
  void dispose() {
    inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void handleSubmit() {
    if (inputController.text.trim().isEmpty) return;

    final userMessage = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'sender': 'user',
      'content': inputController.text,
    };

    setState(() {
      messages.add(userMessage);
      inputController.clear();
      isTyping = true;
    });

    Timer(const Duration(seconds: 1), () {
      final aiResponse = generateAIResponse(
          userMessage['content'] as String, messages.length - 1);
      setState(() {
        messages.add(aiResponse);
        isTyping = false;
      });

      Timer(const Duration(milliseconds: 100), _scrollToBottom);
    });

    Timer(const Duration(milliseconds: 100), _scrollToBottom);
  }

  void handlePromptClick(String prompt) {
    inputController.text = prompt;
    handleSubmit();
  }

  void navigateToLearnIt() {
    setState(() {
      currentProgress = {'currentSection': 1, 'showLearnIt': true};
    });
  }

  // REPLACE THIS WITH THE AI RESPONSE GENERATION LOGIC
  Map<String, dynamic> generateAIResponse(String userInput, int messageCount) {
    String response = "";
    final input = userInput.toLowerCase();
    response = "Need to fill with AI response logic";

    return {
      'id': DateTime.now().millisecondsSinceEpoch,
      'sender': 'ai',
      'content': response,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFF8FAFC),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          right: BorderSide(
                            color: Colors.grey.shade300,
                            width: .6,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(widget.width * 24),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Try responding with:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                SizedBox(height: widget.height * 10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: messagePrompts.map((prompt) {
                                    return GestureDetector(
                                      onTap: () => handlePromptClick(prompt),
                                      child: Container(
                                        padding:
                                            EdgeInsets.all(widget.width * 20),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE6F3FF),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          prompt,
                                          style: TextStyle(
                                              fontSize: widget.height * 26),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.all(widget.height * 26),
                              itemCount: messages.length + (isTyping ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (isTyping && index == messages.length) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: widget.width * 65,
                                        height: widget.height * 65,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    0, 127, 255, 1),
                                                width: 2)),
                                        child: Center(
                                          child: Image.network(
                                            "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
                                            height: widget.height * 50,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.all(widget.width * 18),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                        ),
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Money Monkey',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: widget.height * 24,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                _buildBouncingDot(0),
                                                _buildBouncingDot(200),
                                                _buildBouncingDot(400),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                final message = messages[index];
                                final isUser = message['sender'] == 'user';

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: isUser
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      if (!isUser)
                                        Container(
                                          width: widget.width * 65,
                                          height: widget.height * 65,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Color.fromRGBO(
                                                      0, 127, 255, 1),
                                                  width: 2)),
                                          child: Center(
                                            child: Image.network(
                                              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
                                              height: widget.height * 50,
                                            ),
                                          ),
                                        ),
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: isUser
                                              ? const Color(0xFF64748B)
                                              : Colors.grey.shade100,
                                          borderRadius: isUser
                                              ? const BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                )
                                              : const BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                        ),
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (!isUser)
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 4),
                                                child: Text(
                                                  'Money Monkey',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            Text(
                                              message['content'],
                                              style: TextStyle(
                                                color: isUser
                                                    ? Colors.white
                                                    : Colors.black87,
                                                fontSize: widget.height * 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isUser)
                                        Container(
                                          width: widget.width * 60,
                                          height: widget.height * 60,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Color.fromRGBO(
                                                      0, 127, 255, 1),
                                                  width: 2)),
                                          child: Center(
                                            child: Text(
                                              "JD",
                                              style: TextStyle(
                                                fontSize: widget.height * 30,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(
                                                    0, 127, 255, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: .6,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: inputController,
                                    decoration: InputDecoration(
                                      hintText: 'Type your response...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(12),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Color(0xFF007FFF),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: widget.width * 14,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (inputController.text
                                        .trim()
                                        .isNotEmpty) {
                                      handleSubmit();
                                    }
                                    setState(() {
                                      inputController.clear();
                                    });
                                  },
                                  child: Container(
                                    height: widget.height * 90,
                                    width: widget.width * 90,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 127, 255, 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: widget.height * 60,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Activity panel - narrower
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        // Fixed header
                        Container(
                          width: double.infinity,
                          padding:  EdgeInsets.symmetric(
                              vertical: widget.height * 26, horizontal: widget.width * 26),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade300,
                                width: .6,
                              ),
                            ),
                          ),
                          child:  Text(
                            'Kickoff Activity',
                            style: TextStyle(
                              fontSize: widget.height * 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Money Monkey Face
                                  Container(
                                    width: 128,
                                    height: 128,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE6F3FF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 112,
                                        height: 112,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFC2E1FF),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Stack(
                                          children: [
                                            // Left eye
                                            Positioned(
                                              top: 28,
                                              left: 28,
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF007FFF),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            // Right eye
                                            Positioned(
                                              top: 28,
                                              right: 28,
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF007FFF),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            // Mouth
                                            Positioned(
                                              bottom: 28,
                                              left: 36,
                                              child: Container(
                                                width: 40,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  border: const Border(
                                                    left: BorderSide(
                                                      color: Color(0xFF007FFF),
                                                      width: 2,
                                                    ),
                                                    right: BorderSide(
                                                      color: Color(0xFF007FFF),
                                                      width: 2,
                                                    ),
                                                    bottom: BorderSide(
                                                      color: Color(0xFF007FFF),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  // Description text
                                  Text(
                                    'Chat with Money Monkey about your feelings toward money. Your responses will help identify your personal money values.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  // Skip button
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                     
                                      
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.grey.shade700,
                                      backgroundColor: Colors.grey.shade100,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                    child: const Text(
                                      'Skip to Learn It',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for bouncing typing indicator dots
  Widget _buildBouncingDot(int delayMilliseconds) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        shape: BoxShape.circle,
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, -4 * sin(value * 3.14)),
            child: child,
          );
        },
      ),
    );
  }
}

// This is a math helper function for the animation
double sin(double value) {
  return (value - value.floor()) * 4 - 2;
}
