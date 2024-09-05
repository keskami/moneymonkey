import 'package:flutter/material.dart';
import 'package:money_monkey/themes/colorThemes.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({super.key});

  @override
  State<GettingStartedPage> createState() => GettingStartedPageState();
}

class GettingStartedPageState extends State<GettingStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightTheme().primaryGreen,
      ),
      backgroundColor: LightTheme().primaryBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image(
          //   image: const NetworkImage("url"),
          //   loadingBuilder: (context, child, loadingProgress) =>
          //       const CircularProgressIndicator(),
          // )
          const Text(
              "Don’t settle for financial confusion\njoin the Money Monkey Revolution"),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(LightTheme().primaryBlue),
            ),
            child: Text(
              'Get Started',
            ),
          ),
        ],
      ),
    );
  }
}
