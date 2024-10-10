import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Invest/Widgets/stocks_list.dart';
import 'package:money_monkey/Invest/Widgets/trade_button.dart';
import 'package:money_monkey/themes/color_themes.dart';

class InvestmentPage extends StatelessWidget {
  const InvestmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightTheme().primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: LightTheme().primaryBackgroundColor,
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
              style: GoogleFonts.baloo2(
                fontSize: 18,
              ),
            ),
            const Text(
              "🍌3000",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "🍌0.00 0.00% Today >",
              style: GoogleFonts.baloo2(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.35,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "1M",
                    style: GoogleFonts.baloo2(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "3M",
                    style: GoogleFonts.baloo2(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "6M",
                    style: GoogleFonts.baloo2(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "1Y",
                    style: GoogleFonts.baloo2(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const StocksList(),
            const Spacer(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Buying Power >"),
                    Text(
                      "🍌7,630",
                      style: GoogleFonts.baloo2(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
