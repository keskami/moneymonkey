import 'package:flutter/material.dart';
import 'package:money_monkey/Invest/Widgets/trade_button.dart';
import 'package:money_monkey/themes/color_themes.dart';

class InvestmentPage extends StatelessWidget {
  const InvestmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Stocks Value",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              "🍌3000",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "🍌0.00 0.00% Today >",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.4,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      LightTheme().primaryBlue,
                      LightTheme().primaryBackgroundColor,
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    "*Graph to be inserted.*",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const TradeButton(),
    );
  }
}

bool isExpanded = false;
