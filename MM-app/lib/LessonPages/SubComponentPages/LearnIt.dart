import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';

class LearnIt extends StatefulWidget {
  const LearnIt({Key? key}) : super(key: key);

  @override
  _LearnItState createState() => _LearnItState();
}

class _LearnItState extends State<LearnIt> {
  final baseCtrl = Get.find<BaseLessonController>();
  double currentProgress = 0;
  int visibleSections = 1;
  bool allShown = false;
  int activeHelp = -1;

  final List<Map<String, String>> contentSections = [
    {
      'title': 'Understanding Value-Based Decisions',
      'content': "Value-based financial decisions align your spending with what matters most to you. When your money choices reflect your personal values, you're more likely to feel satisfied with them. This approach isn't about figuring out the 'right' way to spend, but rather the way that brings you the most fulfillment.",
      'image': '⚖️',
      'aiHelp': "Value-based decisions aren't about right or wrong choices, but about what fits YOU best. For example, someone who values adventure might spend on travel, while someone who values security might prioritize saving for emergencies. Think about your recent purchases - which ones left you feeling good afterward? Those likely align with your core values.",
    },
    {
      'title': 'Common Financial Values',
      'content': "People commonly value security, freedom, generosity, status, and experiences when making money choices. None are inherently right or wrong - they reflect your personal priorities. Security might lead you to save more, while valuing experiences might mean you spend more on travel or entertainment.",
      'image': '🧭',
      'aiHelp': "Let me give you some examples of how values translate to financial decisions:\n\n- Security: Someone might maintain a 6-month emergency fund and avoid debt\n- Freedom: Another person might choose a lower-paying job with flexible hours\n- Experiences: Someone might budget less for housing to afford frequent travel\n- Generosity: Setting aside money each month for charitable giving\n- Status: Investing in quality clothing or a nice car that builds professional image",
    },
    {
      'title': 'Identifying Your Own Values',
      'content': "Reflect on moments when you felt good about money decisions versus times you regretted choices. The difference often reveals what you truly value. Try tracking your spending for a month and noting which purchases brought you lasting satisfaction versus momentary pleasure. This exercise can reveal patterns about what you truly value.",
      'image': '🔍',
      'aiHelp': "Try this practical exercise: Look through your last month of spending. For each expense over \$20, rate how happy it made you from 1-10. Notice any patterns? For example, if dining out with friends consistently rates 8-9 while impulse online shopping rates 3-4, you likely value social connection more than material possessions. These insights can help guide future spending.",
    },
    {
      'title': 'Value Conflicts in Financial Decisions',
      'content': "Sometimes your values compete with each other. Recognizing these conflicts helps you make more intentional trade-offs. For example, you might value both security (saving money) and experiences (traveling), which requires thoughtful balancing. Being conscious of these conflicts helps you make decisions you won't regret later.",
      'image': '⚔️',
      'aiHelp': "Value conflicts happen to everyone! For instance:\n\n- Wanting to be generous (buying gifts for family) vs. needing security (building savings)\n- Desiring experiences (vacation) vs. wanting freedom (less debt)\n\nHere's how to handle these: First, acknowledge the conflict. Then, explore creative compromises - maybe you can find a less expensive way to be generous, or save for experiences without sacrificing long-term security. The key is making these trade-offs consciously rather than impulsively.",
    }
  ];

  final ScrollController _chatScroll = ScrollController();
  final ScrollController _contentScroll = ScrollController();
  final TextEditingController _chatController = TextEditingController();
  final List<Map<String, String>> _chatHistory = [];

  // Simple AI response generator
  String _generateAiResponse(String message) {
    final text = message.toLowerCase();
    if (text.contains('value') || text.contains('decision')) {
      return 'Values guide your financial choices. For example, if you value security, you might prioritize saving for emergencies over luxury purchases.';
    } else if (text.contains('example') || text.contains('instance')) {
      return 'Here\'s an example: Someone who values family experiences might spend more on a vacation with loved ones, while someone who values status might prefer to buy a luxury car.';
    } else {
      return 'That\'s a great question about financial decision-making! Would you like to know more about how your personal values might influence your choices?';
    }
  }

  void _sendChat(String text) {
    setState(() {
      _chatHistory.add({'sender': 'user', 'text': text});
    });
    _chatScroll.animateTo(_chatScroll.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void _handleUserMessage(String text) {
    _sendChat(text);
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        _chatHistory.add({'sender': 'ai', 'text': _generateAiResponse(text)});
      });
      _chatScroll.animateTo(_chatScroll.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    });
  }

  void _submitChat() {
    final text = _chatController.text.trim();
    if (text.isNotEmpty) {
      _handleUserMessage(text);
      _chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar - chatbot
          Container(
            width: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with avatar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(radius: 24, backgroundColor: Color(0xFF007FFF), child: Text('🐵', style: TextStyle(color: Colors.white, fontSize: 24))),
                      SizedBox(height: 8),
                      Text('Money Monkey', style: GoogleFonts.baloo2(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Learn & Ask', style: GoogleFonts.baloo2(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
                Divider(),
                // Suggestion prompts (match React)
                Padding(
                  padding: const EdgeInsets.all(16), // p-4
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ask About Value-Based Decisions',
                        style: GoogleFonts.baloo2(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8), // mb-2
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE6F3FF),
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.all(12), // p-3
                          textStyle: TextStyle(fontSize: 14), // text-sm
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () => _handleUserMessage('How do I identify my values?'),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('How do I identify my values?'),
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE6F3FF),
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.all(12),
                          textStyle: TextStyle(fontSize: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () => _handleUserMessage('Why are values important for money?'),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Why are values important for money?'),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                // Chat message list
                Expanded(
                  child: ListView.builder(
                    controller: _chatScroll,
                    padding: const EdgeInsets.all(16),
                    itemCount: _chatHistory.length,
                    itemBuilder: (context, idx) {
                      final msg = _chatHistory[idx];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(radius: 16, backgroundColor: msg['sender']=='ai'?Color(0xFF007FFF):Colors.grey, child: Text(msg['sender']=='ai'?'🐵':'JD', style: TextStyle(color: Colors.white, fontSize: 16))),
                            SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: msg['sender']=='ai'?Color(0xFFE6F3FF):Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(msg['text']!),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Input field
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _chatController,
                          decoration: InputDecoration(
                            hintText: 'Type your question...',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onSubmitted: (_) => _submitChat(),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(onPressed: _submitChat, icon: Icon(Icons.send, color: Color(0xFF007FFF))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main
          Expanded(
            child: Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical:16,horizontal:24),
                  child: Text('Money Monkey Learning', style: TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
                ),
                // Main content with animated cards and floating button
                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        controller: _contentScroll,
                        padding: const EdgeInsets.all(24),
                        itemCount: visibleSections,
                        itemBuilder: (ctx, i) {
                          final sec = contentSections[i];
                          final isNew = i == visibleSections - 1;
                          return Align(
                            alignment: Alignment.topCenter,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 800), // match React container max-w-3xl
                              child: TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: isNew ? 0.0 : 1.0, end: 1.0),
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                                builder: (context, value, cardChild) {
                                  return Opacity(
                                    opacity: value,
                                    child: Transform.translate(
                                      offset: Offset(0, 20 * (1 - value)),
                                      child: cardChild,
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 32),
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(sec['image']!, style: TextStyle(fontSize: 32)),
                                          SizedBox(width: 8),
                                          Text(
                                            sec['title']!,
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // text-xl
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      Text(sec['content']!, style: TextStyle(fontSize: 16)),
                                      TextButton(
                                        onPressed: () => setState(() => activeHelp = activeHelp == i ? -1 : i),
                                        child: Row(children: [Text(activeHelp == i ? 'Hide AI tips' : 'Show AI tips'), SizedBox(width: 4), Icon(Icons.smart_toy)]),
                                      ),
                                      if (activeHelp == i)
                                        Container(
                                          margin: EdgeInsets.only(top: 16), // mt-4
                                          decoration: BoxDecoration(
                                            color: Color(0xFFEFF6FF), // bg-blue-50
                                            border: Border.all(color: Color(0xFFBFDBFE)), // border-blue-200
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          padding: EdgeInsets.all(16), // p-4
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(radius: 16, backgroundColor: Color(0xFF007FFF), child: Text('🐵', style: TextStyle(color: Colors.white, fontSize: 16))),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Money Monkey's Tips",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      sec['aiHelp']!,
                                                      style: TextStyle(fontSize: 14),
                                                      textAlign: TextAlign.left,
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
                              ),
                            ),
                          );
                        },
                      ),
                      // Floating Next/Start button
                      Positioned(
                        bottom: 24,
                        right: 24,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: allShown ? Color(0xFF007FFF) : Colors.white, foregroundColor: allShown ? Colors.white : Colors.black, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), elevation: 4),
                          onPressed: () {
                            if (!allShown) {
                              setState(() {
                                visibleSections++;
                                currentProgress = visibleSections / contentSections.length;
                                if (visibleSections == contentSections.length) allShown = true;
                              });
                              // scroll to new card
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _contentScroll.animateTo(_contentScroll.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                              });
                            } else {
                              baseCtrl.nextPage();
                            }
                          },
                          child: Row(children: [Text(allShown ? 'Start Practice' : 'Next'), SizedBox(width: 8), Icon(Icons.arrow_forward)]),
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
}