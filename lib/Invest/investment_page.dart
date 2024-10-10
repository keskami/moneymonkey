import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Invest/Widgets/line_chart_widget.dart';
import 'package:money_monkey/Invest/Widgets/stocks_list.dart';
import 'package:money_monkey/Invest/Widgets/trade_button.dart';
import 'package:money_monkey/themes/color_themes.dart';

import '../Backend/Models/stock_data.dart';
import '../Backend/Services/stock_service.dart';

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({super.key});

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  final StockService _stockService = StockService();
  List<StockData> _stockDataList = [];
  String symbol = "JPM";
  Future<void> _loadStockData() async {
    try {
      final data = await _stockService.fetchStockData(symbol);
      setState(() {
        _stockDataList = data;
      });
    } catch (e) {
      // Handle error (e.g., show a snackbar or an error message)
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadStockData();
  }

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
              child: _stockDataList.isEmpty
                  ? Center(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: const CircularProgressIndicator()))
                  : LineChartWidget(
                      stockData: _stockDataList,
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
