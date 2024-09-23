import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Pages/IntroPages/gs_page1.dart';
import 'package:money_monkey/GettingStarted/Widgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/Widgets/option_tile.dart';

class GettingStartedPage5 extends StatelessWidget {
  const GettingStartedPage5({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> submitAge(int val) async {
      gettingStartedController.age.value = val;
    }

    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 17,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/money_monkey.png",
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
                    "How old are you?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomOptionTile(
              childWidget: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: gettingStartedController.age.value == 0
                      ? "Age"
                      : gettingStartedController.age.value.toString(),
                  hintStyle: const TextStyle(
                    fontSize: 23,
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(),
                style: const TextStyle(
                  color: Color.fromARGB(255, 178, 182, 182),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                onSubmitted: (value) {
                  submitAge(int.parse(value));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
