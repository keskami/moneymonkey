import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Invest/Widgets/line_chart_widget.dart';
import 'package:money_monkey/Invest/Widgets/trade_button.dart';
import 'package:money_monkey/themes/color_themes.dart';

import '../Backend/Models/stock_data.dart';
import '../Backend/Services/stock_service.dart';
import 'Widgets/stocks_list.dart';

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({super.key});

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  final StockService _stockService = StockService();
  Map<String, List<StockData>> _stockDataMap = {};
  String _selectedSymbol = "AAPL";
  bool _isLoading = true;
  int _duration = 30;

  // Function to load data from the local JSON asset
  Future<void> _loadLocalStockData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/sample_stock_data.json');
      final Map<String, dynamic> jsonMap = json.decode(response);
      Map<String, dynamic> timeSeries = jsonMap["Time Series (Daily)"];

      List<StockData> loadedStockData = timeSeries.entries.map((entry) {
        return StockData.fromJson(entry.value, entry.key);
      }).toList();

      // Store loaded data for the AAPL symbol, replace as needed for multiple stocks
      setState(() {
        _stockDataMap["AAPL"] = loadedStockData;
        _isLoading = false;
      });
      print('Local data loaded successfully');
    } catch (e) {
      print("Error loading data from JSON file: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to load data from the StockService for all symbols
  Future<void> _loadStockDataForAllSymbols() async {
    List<String> symbols = ["AAPL", "PG", "JNJ", "JPM"];
    try {
      for (String symbol in symbols) {
        final data = await _stockService.fetchStockData(symbol);
        setState(() {
          _stockDataMap[symbol] = data;
        });
        print('Loaded data for $symbol: ${data.length} entries');
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // _loadLocalStockData();
    _loadStockDataForAllSymbols();
  }

  // Function to update the selected symbol and reload the graph
  void _updateSelectedSymbol(String symbol) {
    setState(() {
      _selectedSymbol = symbol;
    });
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
            Navigator.of(context).pop();
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
            if (_stockDataMap[_selectedSymbol]?.isNotEmpty ?? false)
              Text(
                _stockDataMap[_selectedSymbol]![0].open.toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (_stockDataMap[_selectedSymbol]?.isNotEmpty ?? false)
              Text(
                "🍌${_stockDataMap[_selectedSymbol]![0].close.toString()}% Today >",
                style: GoogleFonts.baloo2(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            const SizedBox(height: 10),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.35,
              child: _isLoading
                  ? Center(
                      child: const CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: LineChartWidget(
                        duration: _duration,
                        stockData: _stockDataMap[_selectedSymbol] ?? [],
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
                      _duration = 30;
                    });
                  },
                  child: Text(
                    "1M",
                    style: GoogleFonts.baloo2(fontSize: 16),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _duration = 90;
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
                      _duration = 180;
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
                      _duration = 365;
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
            if (!_stockDataMap.isEmpty)
              StocksList(
                stockDataList:
                    _stockDataMap.values.expand((data) => data).toList(),
                onStockSelected: _updateSelectedSymbol,
              ),
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
