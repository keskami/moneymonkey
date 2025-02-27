import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/ScenarioController.dart';
import 'package:money_monkey/LessonPages/Widgets/NextButton.dart';
import 'package:money_monkey/LessonPages/Widgets/OptionsTile.dart';
import 'package:money_monkey/themes/color_themes.dart';

class MonkeyMCQPage extends StatefulWidget {
  MonkeyMCQPage({
    super.key,
    required this.question,
    required this.options,
    required this.correctMessages,
    required this.scores,
  });
  final String question;
  final List<List<String>> options;
  final Map<String, String> correctMessages;
  final Map<String, int> scores;

  @override
  State<MonkeyMCQPage> createState() => _MonkeyMCQPageState();
}

class _MonkeyMCQPageState extends State<MonkeyMCQPage> {
  final ScenarioController scenarioController = Get.find();
  String selectedAns = "";
  bool feedbackShown = false;
  bool optionsDisabled = false;
  int score = 0;
  GlobalKey monkeyImageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    score = scenarioController.responsibilityScore.value;
  }

  void answerQuestion(String ans) {
    if (!optionsDisabled) {
      setState(() {
        selectedAns = ans;
      });
    }
  }

  void showFeedback() {
    if (selectedAns.isNotEmpty && !feedbackShown) {
      setState(() {
        feedbackShown = true;
        optionsDisabled = true;
        // Update score when feedback is shown
        score = score + (widget.scores[selectedAns] ?? 0);
      });
      
      // Show feedback SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        FeedbackSnackBar(message: widget.correctMessages[selectedAns] ?? '')
      );
    }
  }

  void moveToNextPage() {
    // Hide any active SnackBars before navigating
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    
    // Update the controller's score before moving to next question
    scenarioController.responsibilityScore.value = score;
    setState(() {
      selectedAns = "";
      feedbackShown = false;
      optionsDisabled = false;
    });
    scenarioController.pageIndex.value += 1;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Financial Responsibility Score
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: "Financial Responsibility Score: ",
                  style: GoogleFonts.baloo2().copyWith(
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: "${score.toStringAsFixed(2)}",
                      style: GoogleFonts.baloo2().copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "%",
                      style: GoogleFonts.baloo2().copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: screenHeight * 0.02),
            
            // Monkey and Chat Bubble
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Monkey image with key for measurement
                Container(
                  key: monkeyImageKey,
                  child: Image.network(
                    height: screenHeight * 0.2,
                    "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMinty.png?alt=media&token=50e15d9a-3fc7-4fdb-9beb-ef2857b68793",
                  ),
                ),
                Expanded(
                  child: ChatBubble(
                    clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                    backGroundColor: Colors.grey.shade200,
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth * 0.7,
                      ),
                      child: Text(
                        widget.question,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ).marginSymmetric(
                        horizontal: screenWidth * 0.01,
                        vertical: screenHeight * 0.01,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: screenHeight * 0.03),
            
            // Full width options
            ...widget.options.map(
              (option) => Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                child: GestureDetector(
                  onTap: () => answerQuestion(option[0]),
                  child: CustomOptionTile(
                    isSelected: selectedAns == option[0],
                    isDisabled: optionsDisabled,
                    title: option[0],
                    subtitle: option[1],
                  ),
                ),
              ),
            ).toList(),
            
            SizedBox(height: screenHeight * 0.03),
            
            // Continue Button - Right aligned
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                onPressed: feedbackShown ? moveToNextPage : showFeedback,
                text: feedbackShown ? "Continue" : "Next",
                isEnabled: selectedAns.isNotEmpty,
              ),
            ),
          ],
        );
      },
    );
  }
  
  // Custom option tile that spans full width
  Widget CustomOptionTile({
    required bool isSelected, 
    required bool isDisabled,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: isSelected
              ? isDisabled
                  ? Colors.grey.shade400
                  : LightTheme().pastelGreen
              : Colors.transparent,
        ),
        color: isSelected
            ? isDisabled
                ? Colors.grey.shade100
                : LightTheme().pastelGreen.withAlpha(30)
            : Colors.grey.shade200,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: optionsDisabled ? Colors.grey : Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              color: optionsDisabled ? Colors.grey : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
  
  // Custom button widget
  Widget CustomButton({
    required VoidCallback onPressed,
    required String text,
    required bool isEnabled,
  }) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? LightTheme().pastelGreen : Colors.grey,
        padding: EdgeInsets.symmetric(
          horizontal: 48,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}