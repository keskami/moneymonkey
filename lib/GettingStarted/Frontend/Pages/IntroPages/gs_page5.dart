import 'package:flutter/material.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/IntroPages/gs_page1.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/chat_bubble.dart';
import 'package:money_monkey/GettingStarted/Frontend/Widgets/option_tile.dart';

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
                Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMoneyMonkey%2Fmoney_monkey.png?alt=media&token=28f5bc02-2a06-42e5-94db-5aaeeaaae5f6",
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
