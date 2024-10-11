import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
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
  String symbol = "AAPL";
  bool _isLoading = true; // Track loading state
  int duration = 30;

  // Function to load data from the local JSON asset
  Future<void> _loadLocalStockData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/sample_stock_data.json');
      final Map<String, dynamic> jsonMap = json.decode(response);
      Map<String, dynamic> timeSeries = jsonMap["Time Series (Daily)"];

      // Map entries to StockData objects
      List<StockData> loadedStockData = timeSeries.entries.map((entry) {
        return StockData.fromJson(entry.value, entry.key);
      }).toList();

      setState(() {
        _stockDataList = loadedStockData; // Set loaded data
        _isLoading = false; // Set loading to false after loading data
      });
    } catch (e) {
      print("Error loading data from JSON file: $e");
      setState(() {
        _isLoading = false; // Set loading to false even if there's an error
      });
    }
  }

  // Existing function to load data from the StockService
  Future<void> _loadStockData() async {
    try {
      final data = await _stockService.fetchStockData(symbol);
      print(data.length);
      setState(() {
        _stockDataList = data;
        _isLoading = false; // Set loading to false when data is fetched
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false; // Set loading to false even if there's an error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Temporarily load local stock data
    _loadLocalStockData();
    // If you want to load data from StockService, uncomment this line
    // _loadStockData();
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
          onPressed: () {
            Navigator.of(context).pop(); // Go back when pressed
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Stocks Value",
              style: GoogleFonts.baloo2(fontSize: 18),
            ),
            Text(
              _stockDataList[0].open.toString(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "🍌${_stockDataList[0].close.toString()}% Today >",
              style: GoogleFonts.baloo2(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRect(
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: screenWidth,
                height: screenHeight * 0.35,
                child: _isLoading
                    ? Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : LineChartWidget(
                        duration: duration,
                        symbol: symbol,
                        stockData: _stockDataList,
                      ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      duration = 30;
                    });
                  }, // Implement the functionality for different time ranges
                  child: Text(
                    "1M",
                    style: GoogleFonts.baloo2(fontSize: 16),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      duration = 90;
                    });
                  },
                  child: Text(
                    "3M",
                    style: GoogleFonts.baloo2(fontSize: 16),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      duration = 180;
                    });
                  },
                  child: Text(
                    "6M",
                    style: GoogleFonts.baloo2(fontSize: 16),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      duration = 365;
                    });
                  },
                  child: Text(
                    "1Y",
                    style: GoogleFonts.baloo2(fontSize: 16),
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
                  vertical: screenHeight * 0.02,
                ),
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
