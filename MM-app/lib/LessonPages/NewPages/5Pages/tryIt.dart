import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class TryItPage extends StatefulWidget {
  final double width;
  final double height;

  TryItPage({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  State<TryItPage> createState() => _TryItPageState();
}

class _TryItPageState extends State<TryItPage> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  

  final List<String> startingMessages = [
    "Welcome to the Bean Game! I'll help you explore your financial values through a budgeting exercise.",
    "You have 20 beans that represent your total resources. Let's start building your budget by allocating them to different categories. Ready to begin?",
  ];
  final List<String> categories = [
    'Housing',
    'Food',
    'Transportation',
    'Entertainment',
    'Savings',
    'Education',
    'Healthcare',
    'Clothing'
  ];
  Map<String, int> beanAllocation = {
    'housing': 0,
    'food': 0,
    'transportation': 0,
    'entertainment': 0,
    'savings': 0,
    'education': 0,
    'healthcare': 0,
    'clothing': 0,
  };


  List<ChatMessage> chatHistory = [];

  @override
  void initState() {
    super.initState();
    chatHistory = [
      ChatMessage(
        sender: "ai",
        message: startingMessages[0],
      ),
      ChatMessage(
        sender: "ai",
        message: startingMessages[1],
      ),
    ];
  }

  String gameStage = "introduction";

  int remainingBeans = 20;
  List<ChoiceButton> choiceButtons = [];
  double progress = 0;
  double lessonProgress = 0;

  @override
  void dispose() {
    _inputController.dispose();
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

  void handleSendMessage() {
    if (_inputController.text.trim().isEmpty) return;

    setState(() {
      chatHistory.add(ChatMessage(
        sender: "user",
        message: _inputController.text,
      ));
    });

    processUserInput(_inputController.text);
    _inputController.clear();
  }

  void processUserInput(String input) {
    Future.delayed(const Duration(seconds: 1), () {
      if (gameStage == "introduction") {
        setState(() {
          chatHistory.add(ChatMessage(
            sender: "ai",
            message:
                "Great! Here are the categories you can allocate your beans to: Housing, Food, Transportation, Entertainment, Savings, Education, Healthcare, and Clothing. Let's start with Housing - how many beans would you like to allocate? (1-8 beans)",
          ));
          gameStage = "housing";
          choiceButtons = List.generate(
            8,
            (index) => ChoiceButton(
              label: (index + 1).toString(),
              action: () => handleBeanAllocation("housing", index + 1),
            ),
          );
        });
      } else if (gameStage == "housing") {
        int beans = int.tryParse(input) ?? 0;
        if (beans < 1 || beans > 8) {
          setState(() {
            chatHistory.add(ChatMessage(
              sender: "ai",
              message: "Please choose a number between 1 and 8 for Housing.",
            ));
          });
          return;
        }

        handleBeanAllocation("housing", beans);
      } else if (gameStage == "food") {
        int beans = int.tryParse(input) ?? 0;
        int maxBeans = 8 < remainingBeans ? 8 : remainingBeans;

        if (beans < 1 || beans > maxBeans) {
          setState(() {
            chatHistory.add(ChatMessage(
              sender: "ai",
              message:
                  "Please choose a number between 1 and $maxBeans for Food.",
            ));
          });
          return;
        }

        handleBeanAllocation("food", beans);
      } else if (gameStage == "transportation") {
        int beans = int.tryParse(input) ?? 0;
        int maxBeans = 6 < remainingBeans ? 6 : remainingBeans;

        if (beans < 0 || beans > maxBeans) {
          setState(() {
            chatHistory.add(ChatMessage(
              sender: "ai",
              message:
                  "Please choose a number between 0 and $maxBeans for Transportation.",
            ));
          });
          return;
        }

        handleBeanAllocation("transportation", beans);
      } else if (gameStage == "entertainment") {
        int beans = int.tryParse(input) ?? 0;
        int maxBeans = 5 < remainingBeans ? 5 : remainingBeans;

        if (beans < 0 || beans > maxBeans) {
          setState(() {
            chatHistory.add(ChatMessage(
              sender: "ai",
              message:
                  "Please choose a number between 0 and $maxBeans for Entertainment.",
            ));
          });
          return;
        }

        handleBeanAllocation("entertainment", beans);
      } else if (gameStage == "savings") {
        int beans = int.tryParse(input) ?? 0;
        int maxBeans = remainingBeans;

        if (beans < 0 || beans > maxBeans) {
          setState(() {
            chatHistory.add(ChatMessage(
              sender: "ai",
              message:
                  "Please choose a number between 0 and $maxBeans for Savings.",
            ));
          });
          return;
        }

        handleBeanAllocation("savings", beans);
      } else if (gameStage == "emergency") {
        setState(() {
          chatHistory.add(ChatMessage(
            sender: "ai",
            message:
                "I see how you've allocated your resources. Now, let's introduce a challenge. Imagine your work hours were cut, and you need to remove 5 beans from your budget. Which categories would you reduce?",
          ));
          gameStage = "emergency_selection";
        });
      } else if (gameStage == "emergency_selection") {
        setState(() {
          chatHistory.add(ChatMessage(
            sender: "ai",
            message:
                "Thank you for making those tough choices. This exercise reveals something about your financial values. Based on your decisions, it seems you prioritize ${determineValues()}. These insights can help guide your real-world financial decisions.",
          ));
          chatHistory.add(ChatMessage(
            sender: "ai",
            message:
                "You've completed the Bean Game! This activity was designed to help you understand how your personal values influence your financial decisions. Next, we'll move to the Reflect section to think more about what we've learned. Send another message to complete the activity.",
          ));
          progress = 100;
          lessonProgress = 1.0;
          gameStage = "complete";

        });
      }else if (gameStage == "complete") {
        handleNavigateToReflect();
      }

      // Auto-scroll after adding AI message
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    });
  }

  void handleBeanAllocation(String category, int beans) {
    int newRemainingBeans = remainingBeans - beans;

    setState(() {
      beanAllocation[category] = beans;
      remainingBeans = newRemainingBeans;
      progress += 15;
      lessonProgress = progress / 100;

      if (category == "housing") {
        chatHistory.add(ChatMessage(
          sender: "ai",
          message:
              "You've allocated $beans beans to Housing. Now, how many beans would you like to allocate to Food? (1-${8 < newRemainingBeans ? 8 : newRemainingBeans} beans)",
        ));
        gameStage = "food";
        int maxBeans = 8 < newRemainingBeans ? 8 : newRemainingBeans;
        choiceButtons = List.generate(
          maxBeans,
          (index) => ChoiceButton(
            label: (index + 1).toString(),
            action: () => handleBeanAllocation("food", index + 1),
          ),
        );
      } else if (category == "food") {
        chatHistory.add(ChatMessage(
          sender: "ai",
          message:
              "You've allocated $beans beans to Food. Now, how many beans would you like to allocate to Transportation? (0-${6 < newRemainingBeans ? 6 : newRemainingBeans} beans)",
        ));
        gameStage = "transportation";
        int maxBeans = 6 < newRemainingBeans ? 6 : newRemainingBeans;
        choiceButtons = List.generate(
          maxBeans + 1,
          (index) => ChoiceButton(
            label: index.toString(),
            action: () => handleBeanAllocation("transportation", index),
          ),
        );
      } else if (category == "transportation") {
        chatHistory.add(ChatMessage(
          sender: "ai",
          message:
              "You've allocated $beans beans to Transportation. Now, how many beans would you like to allocate to Entertainment? (0-${5 < newRemainingBeans ? 5 : newRemainingBeans} beans)",
        ));
        gameStage = "entertainment";
        int maxBeans = 5 < newRemainingBeans ? 5 : newRemainingBeans;
        choiceButtons = List.generate(
          maxBeans + 1,
          (index) => ChoiceButton(
            label: index.toString(),
            action: () => handleBeanAllocation("entertainment", index),
          ),
        );
      } else if (category == "entertainment") {
        chatHistory.add(ChatMessage(
          sender: "ai",
          message:
              "You've allocated $beans beans to Entertainment. Finally, how many beans would you like to allocate to Savings? (0-$newRemainingBeans beans)",
        ));
        gameStage = "savings";
        choiceButtons = List.generate(
          newRemainingBeans + 1,
          (index) => ChoiceButton(
            label: index.toString(),
            action: () => handleBeanAllocation("savings", index),
          ),
        );
      } else if (category == "savings") {
        chatHistory.add(ChatMessage(
          sender: "ai",
          message:
              """You've allocated $beans beans to Savings. Here's your final budget:
        
Housing: ${beanAllocation['housing']} beans
Food: ${beanAllocation['food']} beans
Transportation: ${beanAllocation['transportation']} beans
Entertainment: ${beanAllocation['entertainment']} beans
Savings: $beans beans
        
You have $newRemainingBeans beans remaining.Ready to continue with the next part of the activity?""",
        ));
        gameStage = "emergency";
        choiceButtons = [
          ChoiceButton(
            label: "Continue",
            action: () => processUserInput("continue"),
          ),
        ];
      }
    });

    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  String determineValues() {
    if (beanAllocation['savings']! > 5) {
      return "security and long-term planning";
    } else if (beanAllocation['entertainment']! > 3) {
      return "experiences and enjoying the present";
    } else if (beanAllocation['housing']! + beanAllocation['food']! > 10) {
      return "meeting basic needs and stability";
    } else {
      return "balancing different aspects of life";
    }
  }

  void handleNavigateToReflect() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: widget.width * 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(right: BorderSide(color: Color(0xFFE5E7EB))),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(widget.height * 55),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: widget.width * 90,
                              height: widget.height * 90,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color.fromRGBO(0, 127, 255, 1),
                                      width: 2)),
                              child: Center(
                                child: Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
                                  height: widget.height * 70,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: widget.height * 20),
                          Text(
                            "Money Monkey",
                            style: GoogleFonts.baloo2(
                                fontSize: widget.height * 40,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ]),
                        SizedBox(height: widget.height * 5),
                        Text(
                          "Try it: The Bean Game",
                          style: GoogleFonts.baloo2(
                              fontSize: widget.height * 24,
                              color: Color.fromRGBO(112, 118, 124, 1),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: widget.height * 35),
                        Text(
                          'Your Progress',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                            fontSize: widget.height * 20,
                          ),
                        ),
                        SizedBox(height: widget.height * 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress / 100,
                            backgroundColor: const Color(0xFFE5E7EB),
                            color: const Color(0xFF007FFF),
                            minHeight: widget.height * 12,
                          ),
                        ),
                        SizedBox(height: widget.height * 5),
                        Text(
                          '${progress.toInt()}% complete',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: widget.height * 16,
                          ),
                        ),
                        SizedBox(height: widget.height * 35),
                        Text(
                          'Your Budget',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                            fontSize: widget.height * 18,
                          ),
                        ),
                        SizedBox(height: widget.height * 15),
                        _buildBudgetRow('Housing', beanAllocation['housing']!),
                        _buildBudgetRow('Food', beanAllocation['food']!),
                        _buildBudgetRow('Transportation',
                            beanAllocation['transportation']!),
                        _buildBudgetRow(
                            'Entertainment', beanAllocation['entertainment']!),
                        _buildBudgetRow('Savings', beanAllocation['savings']!),
                        SizedBox(height: widget.height * 6),
                        _buildBudgetRow('Remaining', remainingBeans,
                            isTotal: true),
                        SizedBox(height: widget.height * 35),
                        Text(
                          'Activity Stages',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                            fontSize: widget.height * 18,
                          ),
                        ),
                        SizedBox(height: widget.height * 12),
                        _buildStageIndicator(
                          'Introduction',
                          gameStage == 'introduction',
                          gameStage != 'introduction',
                        ),
                        _buildStageIndicator(
                          'Resource Allocation',
                          [
                            'housing',
                            'food',
                            'transportation',
                            'entertainment',
                            'savings'
                          ].contains(gameStage),
                          !['introduction'].contains(gameStage),
                        ),
                        _buildStageIndicator(
                          'Challenge Event',
                          ['emergency', 'emergency_selection']
                              .contains(gameStage),
                          gameStage == 'complete',
                        ),
                        _buildStageIndicator(
                          'Reflection & Results',
                          gameStage == 'complete',
                          false,
                        ),
                      ],
                    ),
                  ),
                ),

                // Main chat area
                Expanded(
                  child: Column(
                    children: [
                      // Chat header
                      Container(
                        width: widget.width * 1800,
                        padding: EdgeInsets.all(widget.height * 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(color: Color(0xFFE5E7EB))),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Try It: The Bean Game',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: widget.height * 30,
                              ),
                            ),
                            SizedBox(height: widget.height * 6),
                            Text(
                              'Your teacher has assigned this interactive scenario. The AI will guide you — just respond naturally.',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: widget.height * 22,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.symmetric(
                              horizontal: widget.width * 180,
                              vertical: widget.height * 20),
                          itemCount: chatHistory.length,
                          itemBuilder: (context, index) {
                            final message = chatHistory[index];
                            return Padding(
                              padding:
                                  EdgeInsets.only(bottom: widget.height * 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: widget.width * 60,
                                    height: widget.height * 60,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                            color:
                                                Color.fromRGBO(0, 127, 255, 1),
                                            width: 2)),
                                    child: Center(
                                      child: message.sender == 'ai'
                                          ? Image.network(
                                              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
                                              height: widget.height * 40,
                                            )
                                          : Text(
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
                                  SizedBox(width: widget.width * 20),
                                  Flexible(
                                    child: Container(
                                      padding:
                                          EdgeInsets.all(widget.height * 20),
                                      decoration: BoxDecoration(
                                        color: message.sender == 'user'
                                            ? const Color(0xFF007FFF)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: message.sender == 'user'
                                            ? null
                                            : Border.all(
                                                color: const Color(0xFFE5E7EB)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (message.sender == 'ai')
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: widget.height * 12),
                                              child: Text(
                                                'Money Monkey',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          Text(
                                            message.message,
                                            style: TextStyle(
                                              color: message.sender == 'user'
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ],
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
                        padding: EdgeInsets.only(
                            left: widget.width * 20,
                            right: widget.width * 20,
                            top: widget.height * 20,
                            bottom: widget.height * 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border(top: BorderSide(color: Color(0xFFE5E7EB))),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _inputController,
                                    decoration: InputDecoration(
                                      hintText: 'Type your response...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Color(0xFFD1D5DB)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Color(0xFF007FFF)),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: widget.width * 30,
                                        vertical: widget.height * 20,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: widget.width * 20),
                                InkWell(
                                  onTap: handleSendMessage,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: widget.width * 30,
                                      vertical: widget.height * 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF007FFF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Send',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: widget.height * 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
        ],
      ),
    );
  }

  Widget _buildBudgetRow(String label, int value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
          Text(
            '$value beans',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageIndicator(
      String stageName, bool isActive, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: isActive || isCompleted
                  ? const Color(0xFF007FFF)
                  : const Color(0xFFD1D5DB),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            stageName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
              color: isActive
                  ? const Color(0xFF007FFF)
                  : isCompleted
                      ? const Color(0xFF007FFF)
                      : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String sender;
  final String message;

  ChatMessage({
    required this.sender,
    required this.message,
  });
}

class ChoiceButton {
  final String label;
  final VoidCallback action;

  ChoiceButton({
    required this.label,
    required this.action,
  });
}
