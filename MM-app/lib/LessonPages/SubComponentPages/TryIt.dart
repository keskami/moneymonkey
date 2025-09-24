import 'package:flutter/material.dart';
import 'dart:async';

class TryItComponent extends StatefulWidget {
  const TryItComponent({Key? key}) : super(key: key);

  @override
  _TryItComponentState createState() => _TryItComponentState();
}

class _TryItComponentState extends State<TryItComponent> {
  List<Map<String, String>> chatHistory = [
    {'sender': 'ai', 'message': "Welcome to the Bean Game! I'll help you explore your financial values through a budgeting exercise."},
    {'sender': 'ai', 'message': "You have 20 beans that represent your total resources. Let's start building your budget by allocating them to different categories. Ready to begin?"},
  ];
  final TextEditingController inputController = TextEditingController();
  final ScrollController _chatController = ScrollController();

  String gameStage = 'introduction';
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
  int remainingBeans = 20;
  List<Map<String, dynamic>> choiceButtons = [];
  int progress = 0;

  @override
  void initState() {
    super.initState();
    // no progress bar here
  }

  @override
  void dispose() {
    inputController.dispose();
    _chatController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_chatController.hasClients) {
      _chatController.jumpTo(_chatController.position.maxScrollExtent);
    }
  }

  void handleSendMessage() {
    final text = inputController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      chatHistory.add({'sender': 'user', 'message': text});
      inputController.clear();
    });
    processUserInput(text);
    Timer(Duration(milliseconds: 100), _scrollToBottom);
  }

  void processUserInput(String input) {
    setState(() { progress = (progress + 20).clamp(0, 100); });
    Future.delayed(Duration(seconds: 1), () {
      String response = 'AI response placeholder.';
      setState(() {
        chatHistory.add({'sender': 'ai', 'message': response});
      });
      Timer(Duration(milliseconds: 100), _scrollToBottom);
      // here add choiceButtons based on gameStage
    });
  }

  Widget buildSidebar() {
    return Container(
      width: 320,
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            CircleAvatar(
              radius: 24,
              backgroundColor: Color(0xFF007FFF),
              child: Text('🐵', style: TextStyle(fontSize: 24)),
            ),
            SizedBox(height: 8),
            Text('Money Monkey', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Try It: The Bean Game', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
            SizedBox(height: 16),
            // progress tracker
            Text('Your Progress', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey.shade700)),
            SizedBox(height: 4),
            Container(
              height: 6,
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(3)),
              child: FractionallySizedBox(
                widthFactor: progress / 100,
                child: Container(decoration: BoxDecoration(color: Color(0xFF007FFF), borderRadius: BorderRadius.circular(3))),
              ),
            ),
            SizedBox(height: 4),
            Text('$progress% complete', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            SizedBox(height: 16),
            // Budget
            Text('Your Budget', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey.shade700)),
            SizedBox(height: 4),
            Column(
              children: beanAllocation.entries.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('${e.key[0].toUpperCase()+e.key.substring(1)}:', style: TextStyle(fontSize: 12)),
                               Text('${e.value} beans', style: TextStyle(fontSize: 12))],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            // Stages
            Text('Activity Stages', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey.shade700)),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ['introduction','housing','food','transportation','entertainment','savings','emergency','complete']
                .map((stage) {
                  bool active = (gameStage == stage);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Container(width: 8, height: 8, decoration: BoxDecoration(color: active?Color(0xFF007FFF):Color(0xFFD1D5DB), shape: BoxShape.circle)),
                        SizedBox(width: 8),
                        Text(_stageLabel(stage), style: TextStyle(fontSize: 12, fontWeight: active?FontWeight.w500:FontWeight.normal, color: active?Color(0xFF007FFF):Colors.grey.shade500)),
                      ],
                    ),
                  );
                }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _stageLabel(String s) {
    switch(s) {
      case 'introduction': return 'Introduction';
      case 'housing': case 'food': case 'transportation': case 'entertainment': case 'savings': return 'Resource Allocation';
      case 'emergency': return 'Challenge Event';
      case 'complete': return 'Reflection & Results';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          buildSidebar(),
          Expanded(
            child: Column(
              children: [
                // Chat header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Try It: The Bean Game', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('Your teacher has assigned this interactive scenario. The AI will guide you — just respond naturally.', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                    ],
                  ),
                ),
                // Chat area
                Expanded(
                  child: ListView.builder(
                    controller: _chatController,
                    padding: const EdgeInsets.all(16),
                    itemCount: chatHistory.length,
                    itemBuilder: (ctx, i) {
                      final msg = chatHistory[i];
                      bool isUser = msg['sender']=='user';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: isUser?MainAxisAlignment.end:MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isUser) CircleAvatar(radius:16, backgroundColor:Color(0xFF007FFF), child: Text('🐵', style:TextStyle(fontSize:12))),
                            if (!isUser) SizedBox(width:8),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isUser?Color(0xFF007FFF):Colors.white,
                                  border: isUser?null:Border.all(color:Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!isUser) Text('Money Monkey', style:TextStyle(fontSize:12, fontWeight:FontWeight.w500)),
                                    Text(msg['message']!, style:TextStyle(fontSize:14, color:isUser?Colors.white:Colors.black87)),
                                  ],
                                ),
                              ),
                            ),
                            if (isUser) SizedBox(width:8),
                            if (isUser) CircleAvatar(radius:16, backgroundColor:Color(0xFF007FFF), child: Text('JD', style:TextStyle(fontSize:12))),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Input
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: inputController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal:12, vertical:8),
                            hintText: 'Type your response...',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color:Color(0xFF007FFF), width:2)),
                          ),
                        ),
                      ),
                      SizedBox(width:8),
                      GestureDetector(
                        onTap: handleSendMessage,
                        child: Container(
                          width:32, height:32,
                          decoration: BoxDecoration(color:Color(0xFF007FFF), borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.send, color:Colors.white, size:16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
