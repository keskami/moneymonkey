import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/IntroPages/gs_page1.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/knowledge_bar.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/option_tile.dart';

class GettingStartedPage6 extends StatelessWidget {
  const GettingStartedPage6({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void onKnowledgeTap(int val) {
      gettingStartedController.knowledgeLevel.value = val;
    }

    final List<Widget> knowledgeOptions = [
      SizedBox(
        height: 60, // Match height with multi-line text
        child: Center(
          child: const Text(
            "I'm new",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      const Text(
        "I have a basic\nunderstanding",
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Text(
        "I am moderately\nknowledgeable",
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Text(
        "I have a good\nunderstanding",
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Text(
        "I am very\nknowledgeable",
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 17),
            Row(
              children: [
                Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      // If loadingProgress is null, the image has fully loaded
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  height: 145,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(
                    height: 145,
                    width: 137,
                    child: Center(
                      child: Text('Unable to fetch Image.'),
                    ),
                  ),
                ),
                const ChatBubbleContainer(
                  trianglePosition: TrianglePosition.left,
                  borderRadius: 12,
                  borderWidth: 1,
                  childWidget: Text(
                    "How would you rate\nyour knowledge of\nfinancial literacy?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Flexible ListView
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: knowledgeOptions.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    print("Test");
                    onKnowledgeTap(index);
                  },
                  child: CustomOptionTile(
                    childWidget: Row(
                      children: [
                        KnowledgeBar(strength: index),
                        const SizedBox(width: 20),
                        knowledgeOptions[index],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
