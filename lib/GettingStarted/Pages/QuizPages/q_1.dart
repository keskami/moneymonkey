import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';

import '../../Widgets/chat_bubble.dart';

class Question1 extends StatefulWidget {
  const Question1({
    super.key,
  });

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  List<int> answer = [];
  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      "To use it as a distraction",
      "To exchange it for things we want or need",
      "To hide it away from others",
      "To keep it only in banks",
      "I don’t know"
    ];
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
                height: 145,
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
                  " What is the main\npurpose of money?",
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    if (answer.contains(index)) {
                      answer.remove(index);
                    } else {
                      answer.add(index);
                    }
                  });
                },
                child: CustomOptionTile(
                  isSelected: answer.contains(index),
                  childWidget: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Text(
                      options[index],
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
