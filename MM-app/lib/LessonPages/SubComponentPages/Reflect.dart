import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/Widgets/LessonPages/ReflectionPrompts.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';

class Reflection extends StatefulWidget {
  const Reflection({Key? key}) : super(key: key);

  @override
  _ReflectionState createState() => _ReflectionState();
}

class _ReflectionState extends State<Reflection> {
  late final BaseLessonController _baseController;

  String startingHint = "Reflect on your Financial Values";
  String reflectionName = "Financial Values";
  List<String> reflectionPrompts = [
    "How did your decisions in the Bean Game reflect your personal values?",
    "What surprised you about the financial trade-offs you made?",
    "Which financial value seems most important to you and why?",
    "How might your financial decisions change in the future based on what you learned?",
    "What was challenging about allocating your limited resources?"
  ];

  int clickedIndex = -1;
  final TextEditingController textController = TextEditingController();
  int characterCount = 0;
  bool isSubmitted = false;
  bool isAnalyzing = false;
  String? aiMessage;
  List<String> summaryValues = [];
  String nextSteps = '';
  static const int minChars = 20;

  @override
  void initState() {
    super.initState();
    _baseController = Get.find<BaseLessonController>();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void generateAIFeedback() {
    final text = textController.text.toLowerCase();
    String feedback;
    if (text.contains('security') || text.contains('safe')) {
      feedback =
          'Your reflection shows that security is an important financial value for you. This often means you prioritize stability and predictability.';
    } else if (text.contains('freedom') || text.contains('choice')) {
      feedback =
          'I notice that freedom is a key financial value for you. Having options and flexibility in your financial life clearly matters to you.';
    } else if (text.contains('experience') || text.contains('enjoy')) {
      feedback =
          'Your reflection highlights that experiences are important to you. You seem to value using your resources for memorable moments.';
    } else if (text.contains('difficult') || text.contains('challenge')) {
      feedback =
          'I see you found making these trade-offs challenging. That\'s normal and important for developing financial awareness.';
    } else {
      feedback =
          'Thank you for your reflection. Continue to observe how your financial decisions align with your values.';
    }
    final values = <String>[];
    if (text.contains('security') ||
        text.contains('safe') ||
        text.contains('stable')) values.add('Security');
    if (text.contains('freedom') ||
        text.contains('choice') ||
        text.contains('independence')) values.add('Freedom');
    if (text.contains('experience') ||
        text.contains('enjoy') ||
        text.contains('fun')) values.add('Experiences');
    if (text.contains('help') ||
        text.contains('others') ||
        text.contains('give')) values.add('Generosity');
    if (values.isEmpty) values.add('Financial Balance');
    setState(() {
      aiMessage = feedback;
      summaryValues = values;
      nextSteps =
          "In the next lesson, we'll explore how to align your spending decisions with these values.";
      isAnalyzing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
                  padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 24,
                          backgroundColor: const Color(0xFF007FFF),
                          child:
                              const Text('🐵', style: TextStyle(fontSize: 24))),
                      const SizedBox(height: 8),
                      Text('Money Monkey',
                          style: GoogleFonts.baloo2(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Reflect & Journal',
                          style: GoogleFonts.baloo2(
                              fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
                const Divider(),
                // Sidebar prompts/summary
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: !isSubmitted
                        // scrollable prompts
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: reflectionPrompts.length + 1,
                            itemBuilder: (ctx, idx) {
                              if (idx == 0) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Reflection Prompts',
                                        style: GoogleFonts.baloo2(
                                            fontSize: 14,
                                            color: Colors.grey)),
                                    const SizedBox(height: 8),
                                  ],
                                );
                              }
                              final i = idx - 1;
                              return ReflectionPrompts(
                                prompt: reflectionPrompts[i],
                                index: i,
                                selectedIndex: clickedIndex,
                                onTap: (sel) => setState(() => clickedIndex = sel),
                              );
                            },
                          )
                        // show summary only after analysis done
                        : (!isAnalyzing && aiMessage != null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Your Financial Values',
                                      style: GoogleFonts.baloo2(
                                          fontSize: 14, color: Colors.grey)),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE6F3FF),
                                      border: Border.all(
                                          color: const Color(0xFF007FFF)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 4,
                                          children: summaryValues
                                              .map((v) => Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                            horizontal: 8,
                                                            vertical: 4),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFF007FFF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    16)),
                                                    child: Text(v,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white)),
                                                  ))
                                              .toList(),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(nextSteps,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reflect on your $reflectionName',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                          'Take a moment to journal about what you\'ve learned about your $reflectionName from the activity.',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 768),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isSubmitted) ...[
                                if (clickedIndex >= 0)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE6F3FF),
                                      border: Border(
                                          bottom: BorderSide(
                                              color: const Color(0xFF007FFF),
                                              width: 1)),
                                    ),
                                    child: Text(reflectionPrompts[clickedIndex],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                Container(
                                  width: double.infinity,
                                  height: 320,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey.shade300)),
                                  child: TextField(
                                    controller: textController,
                                    style: const TextStyle(fontSize: 16),
                                    minLines: 10,
                                    maxLines: null,
                                    onChanged: (v) => setState(
                                        () => characterCount = v.length),
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                        border: InputBorder.none,
                                        hintText: clickedIndex >= 0
                                            ? "Type your response here..."
                                            : "Share your thoughts based on the prompt.",
                                        hintStyle: const TextStyle(
                                            fontSize: 16, color: Colors.grey)),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF2F2F2),
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey.shade300)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    children: [
                                      Text(
                                          characterCount >= minChars
                                              ? "$characterCount characters"
                                              : "$characterCount/${minChars} characters",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF707070))),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: (characterCount < minChars ||
                                                clickedIndex < 0)
                                            ? null
                                            : () {
                                                setState(() {
                                                  isSubmitted = true;
                                                  isAnalyzing = true;
                                                });
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 1500),
                                                    generateAIFeedback);
                                              },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF007FFF),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8)),
                                        child: const Text('Save Reflection',
                                            style: TextStyle(fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                ),
                              ] else ...[
                                if (isAnalyzing)
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade200)),
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          CircularProgressIndicator(),
                                          SizedBox(height: 16),
                                          Text('Analyzing your reflection...',
                                              style:
                                                  TextStyle(color: Colors.grey))
                                        ]),
                                  )
                                else ...[
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey.shade200)),
                                          padding: const EdgeInsets.all(24),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('Your Reflection',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                const SizedBox(height: 12),
                                                Text(textController.text)
                                              ]),
                                        ),
                                        const SizedBox(height: 24),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey.shade200)),
                                          padding: const EdgeInsets.all(24),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(children: [
                                                  Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: Color(
                                                                  0xFF007FFF),
                                                              shape: BoxShape
                                                                  .circle),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text('🐵',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: Colors
                                                                  .white))),
                                                  const SizedBox(width: 12),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                            "Money Monkey's Insights",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        Text(
                                                            'Based on your reflection',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey))
                                                      ])
                                                ]),
                                                const SizedBox(height: 16),
                                                Text(aiMessage ?? ''),
                                                const SizedBox(height: 24),
                                                Align(
                                                    alignment: Alignment
                                                        .centerRight,
                                                    child: ElevatedButton(
                                                        onPressed: () =>
                                                            _baseController
                                                                .nextPage(),
                                                        style: ElevatedButton.styleFrom(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        24,
                                                                    vertical:
                                                                        12),
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFF007FFF)),
                                                        child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: const [
                                                              Text(
                                                                  'Complete Lesson'),
                                                              SizedBox(
                                                                  width: 8),
                                                              Icon(Icons
                                                                  .arrow_forward)
                                                            ]))),
                                              ]),
                                        ),
                                      ]),
                                ],
                              ],
                            ],
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
      ),
    );
  }
}
