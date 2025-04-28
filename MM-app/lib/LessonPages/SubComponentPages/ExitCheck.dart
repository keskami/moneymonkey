import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExitCheck extends StatefulWidget {
  const ExitCheck({Key? key}) : super(key: key);
  @override
  _ExitCheckState createState() => _ExitCheckState();
}

class _ExitCheckState extends State<ExitCheck> {
  // Activity selection
  String _checkType = 'quiz';
  
  // Quiz state
  final Map<int,int> _selectedAnswers = {};
  bool _quizSubmitted = false;
  int _quizScore = 0;

  // Goal state
  String _goalText = '';
  String _goalTimeframe = 'week';
  bool _goalSubmitted = false;

  // AI feedback
  String? _aiMessage;
  List<String>? _aiTips;

  // XP
  int _xpEarned = 0;

  double get _currentProgress {
    if (_quizSubmitted && _goalSubmitted) return 1.0;
    if (_quizSubmitted || _goalSubmitted) return 0.5;
    return 0.0;
  }

  final List<Map<String,dynamic>> _quizQuestions = [
    {
      'question': 'What is a financial value?',
      'options': [
        'The exact dollar amount of your savings',
        'A personal priority that guides your financial decisions',
        'The current market value of your investments',
        'A type of bank account with high interest'
      ],
      'correct': 1,
    },
    {
      'question': 'Which of the following is NOT commonly considered a financial value?',
      'options': ['Security','Freedom','Punctuality','Generosity'],
      'correct': 2,
    },
    {
      'question': "When financial values conflict, what's the best approach?",
      'options': [
        'Always prioritize security over other values',
        'Follow whatever your friends are doing',
        'Recognize the conflict and make conscious trade-offs',
        'Ignore your values and focus only on numbers'
      ],
      'correct': 2,
    },
  ];

  void _handleQuizSubmit() {
    if (_selectedAnswers.length < _quizQuestions.length) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please answer all questions before submitting.'),
      ));
      return;
    }
    int correct = 0;
    for (var i = 0; i < _quizQuestions.length; i++) {
      if (_selectedAnswers[i] == _quizQuestions[i]['correct']) correct++;
    }
    _quizScore = (correct / _quizQuestions.length * 100).round();
    _quizSubmitted = true;
    _xpEarned += 50 + correct * 50;
    setState(() {});
  }

  void _handleGoalSubmit() {
    if (_goalText.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a financial goal before submitting.'),
      ));
      return;
    }
    _goalSubmitted = true;
    _xpEarned += 100;
    _generateGoalFeedback();
    setState(() {});
  }

  void _generateGoalFeedback() {
    final text = _goalText.toLowerCase();
    final ids = <String>[];
    if (text.contains('save') || text.contains('emergency')) ids.add('Security');
    if (text.contains('debt') || text.contains('budget')) ids.add('Freedom');
    if (text.contains('trip') || text.contains('vacation') || text.contains('purchase')) ids.add('Experiences');
    if (text.contains('donate') || text.contains('help') || text.contains('give')) ids.add('Generosity');
    if (ids.isEmpty) ids.add('Personal Growth');
    _aiMessage = 'Great goal! This $_goalTimeframe-based objective aligns with your ${ids.join(' and ')} values.';
    _aiTips = [
      'Break your goal into smaller weekly milestones',
      'Share your goal with someone who will help keep you accountable',
      'Set a calendar reminder to check your progress next $_goalTimeframe'
    ];
  }

  void _handleContinue() {
    // Navigate or pop
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Sidebar
        Container(
          width: 320,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFF007FFF),
                      child: const Text('🐵', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(height: 8),
                    Text('Money Monkey', style: GoogleFonts.baloo2(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Exit Check', style: GoogleFonts.baloo2(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
              const Divider(),
              // Activity selection
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Complete Your Learning', style: GoogleFonts.baloo2(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 8),
                    _TabButton(
                      icon: '📝',
                      label: 'Knowledge Check Quiz',
                      selected: _checkType == 'quiz',
                      onTap: () => setState(() => _checkType = 'quiz'),
                    ),
                    const SizedBox(height: 8),
                    _TabButton(
                      icon: '🎯',
                      label: 'Set a Financial Goal',
                      selected: _checkType == 'goal',
                      onTap: () => setState(() => _checkType = 'goal'),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (_quizSubmitted && _goalSubmitted)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _ReflectionBox(xp: _xpEarned, onContinue: _handleContinue),
                ),
            ],
          ),
        ),
        // Main content
        Expanded(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _checkType == 'quiz'
                          ? 'Knowledge Check: Financial Values'
                          : 'Set a Financial Goal',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _checkType == 'quiz'
                          ? "Demonstrate what you've learned about financial values."
                          : "Create a specific financial goal that aligns with your personal values.",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 768),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: _checkType == 'quiz'
                            ? _QuizContent(
                                questions: _quizQuestions,
                                selected: _selectedAnswers,
                                submitted: _quizSubmitted,
                                score: _quizScore,
                                onAnswer: (i,a) => setState(() => _selectedAnswers[i] = a),
                                onSubmit: _handleQuizSubmit,
                              )
                            : _GoalContent(
                                text: _goalText,
                                timeframe: _goalTimeframe,
                                submitted: _goalSubmitted,
                                aiMessage: _aiMessage,
                                aiTips: _aiTips,
                                onTextChanged: (v) => setState(() => _goalText = v),
                                onTimeframeChanged: (v) => setState(() => _goalTimeframe = v),
                                onSubmit: _handleGoalSubmit,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Tab button
class _TabButton extends StatelessWidget {
  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _TabButton({Key? key, required this.icon, required this.label, required this.selected, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF007FFF) : Colors.grey.shade100,
          border: Border.all(color: selected ? const Color(0xFF0066CC) : Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [Text(icon, style: TextStyle(fontSize: 18, color: selected ? Colors.white : Colors.black)), const SizedBox(width: 8), Text(label, style: TextStyle(color: selected ? Colors.white : Colors.black))],
        ),
      ),
    );
  }
}

// Reflection Box
class _ReflectionBox extends StatelessWidget {
  final int xp;
  final VoidCallback onContinue;
  const _ReflectionBox({Key? key, required this.xp, required this.onContinue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: const Color(0xFF007FFF)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('✅', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Exit Check Complete!', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('You earned $xp XP', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007FFF)),
              child: const Text('Continue to Reflection'),
            ),
          ),
        ],
      ),
    );
  }
}

// Quiz Content Widget
class _QuizContent extends StatelessWidget {
  final List<Map<String,dynamic>> questions;
  final Map<int,int> selected;
  final bool submitted;
  final int score;
  final void Function(int,int) onAnswer;
  final VoidCallback onSubmit;
  const _QuizContent({Key? key, required this.questions, required this.selected, required this.submitted, required this.score, required this.onAnswer, required this.onSubmit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (!submitted) {
      return Column(
        children: [
          for (var i = 0; i < questions.length; i++) ...[
            _QuizQuestion(
              index: i,
              question: questions[i]['question'],
              options: List<String>.from(questions[i]['options']),
              selected: selected[i],
              onTap: (a) => onAnswer(i,a),
            ),
            const SizedBox(height: 16),
          ],
          Align(alignment: Alignment.centerRight, child: ElevatedButton(onPressed: onSubmit, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007FFF)), child: const Text('Submit Quiz')))
        ],
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black12, blurRadius:4)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              CircleAvatar(backgroundColor: score>=70 ? const Color(0xFF007FFF) : Colors.orange, child: Text('$score%', style: const TextStyle(color: Colors.white))),
              const SizedBox(width:16),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Quiz Results', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('You answered ${questions.asMap().entries.where((e) => selected[e.key] == e.value['correct']).length} out of ${questions.length} correctly'),
              ])
            ]),
            const SizedBox(height:16),
            for (var i=0;i<questions.length;i++)
              _AnswerReview(question: questions[i]['question'], correct: questions[i]['correct'], your: selected[i], options: List<String>.from(questions[i]['options'])),
          ],
        ),
      );
    }
  }
}

class _QuizQuestion extends StatelessWidget {
  final int index;
  final String question;
  final List<String> options;
  final int? selected;
  final void Function(int) onTap;
  const _QuizQuestion({Key? key, required this.index, required this.question, required this.options, this.selected, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black12, blurRadius:4)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Question ${index+1}', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height:8),
        Text(question),
        const SizedBox(height:8),
        for (var i=0;i<options.length;i++) GestureDetector(
          onTap: () => onTap(i),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom:8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selected==i ? const Color(0xFF007FFF) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(options[i], style: TextStyle(color: selected==i ? Colors.white : Colors.black)),
          ),
        ),
      ]),
    );
  }
}

class _AnswerReview extends StatelessWidget {
  final String question;
  final int correct;
  final int? your;
  final List<String> options;
  const _AnswerReview({Key? key, required this.question, required this.correct, this.your, required this.options}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isCorrect = your==correct;
    return Container(
      margin: const EdgeInsets.only(bottom:16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect ? Colors.blue.shade50 : Colors.orange.shade50,
        border: Border.all(color: isCorrect ? const Color(0xFF007FFF) : Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height:8),
        if (isCorrect)
          Text('Correct: ${options[correct]}')
        else ...[
          Text('Your answer: ${options[your!]}' , style: const TextStyle(color: Colors.red)),
          const SizedBox(height:4),
          Text('Correct answer: ${options[correct]}', style: const TextStyle(color: Color(0xFF007FFF))),
        ]
      ]),
    );
  }
}

// Goal Content Widget
class _GoalContent extends StatelessWidget {
  final String text;
  final String timeframe;
  final bool submitted;
  final String? aiMessage;
  final List<String>? aiTips;
  final ValueChanged<String> onTextChanged;
  final ValueChanged<String> onTimeframeChanged;
  final VoidCallback onSubmit;
  const _GoalContent({Key? key, required this.text, required this.timeframe, required this.submitted, this.aiMessage, this.aiTips, required this.onTextChanged, required this.onTimeframeChanged, required this.onSubmit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (!submitted) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black12, blurRadius:4)]), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Create a Financial Goal', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height:8),
          Text('Set a specific, measurable financial goal that aligns with your personal values.'),
          const SizedBox(height:12),
          TextField(onChanged: onTextChanged, decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'e.g., Save \$500 for an emergency fund')), 
          const SizedBox(height:12),
          Text('I plan to accomplish this in:', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height:8),
          Wrap(spacing:8, children: ['week','month','3 months','year'].map((t) => ChoiceChip(
                label: Text(t[0].toUpperCase() + t.substring(1)),
                selected: timeframe == t,
                onSelected: (_) => onTimeframeChanged(t),
                selectedColor: const Color(0xFF007FFF),
                backgroundColor: Colors.grey.shade100,
                labelStyle: TextStyle(color: timeframe == t ? Colors.white : Colors.black),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: timeframe == t ? const Color(0xFF0066CC) : Colors.transparent)),
          )).toList()),
          const SizedBox(height:16),
          ElevatedButton(onPressed: onSubmit, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007FFF)), child: const Text('Set This Goal'))
        ])),
      ]);
    } else {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black12, blurRadius:4)]), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Your Financial Goal', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height:8),
          Text(text, style: const TextStyle(color: Color(0xFF007FFF))),
          Text('Timeframe: ${timeframe[0].toUpperCase()}${timeframe.substring(1)}', style: const TextStyle(color: Color(0xFF0066CC))),
          const SizedBox(height:12),
          Text('Tips for Success:', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height:8),
          for (var tip in aiTips ?? []) Padding(padding: const EdgeInsets.symmetric(vertical:2), child: Row(children: [Text('•', style: const TextStyle(color: Color(0xFF007FFF))), const SizedBox(width:4), Expanded(child: Text(tip))]))
        ])),
        const SizedBox(height:16),
        if (aiMessage != null) Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black12, blurRadius:4)]), child: Text(aiMessage!)),
      ]);
    }
  }
}