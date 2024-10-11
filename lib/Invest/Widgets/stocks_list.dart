import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:money_monkey/Invest/Widgets/stock_row.dart';

import '../../Backend/Models/stock_data.dart';

class StocksList extends StatefulWidget {
  const StocksList({super.key});

  @override
  State<StocksList> createState() => _StocksListState();
}

class _StocksListState extends State<StocksList> {
  List<StockData> _stockDataList = [];

  Future<void> _loadStockData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/sample_stock_data.json');
      final Map<String, dynamic> jsonMap = json.decode(response);

      Map<String, dynamic> timeSeries = jsonMap["Time Series (Daily)"];
      List<StockData> loadedStockData = timeSeries.entries.map((entry) {
        return StockData.fromJson(entry.value, entry.key);
      }).toList();

      setState(() {
        _stockDataList = loadedStockData;
      });
    } catch (e) {
      print("Error loading data from JSON file: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadStockData(); // Load stock data from JSON file on init
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    // List of stock symbols
    final List<String> stockSymbols = ["AAPL", "PG", "JNJ", "JPM"];

    return Container(
      height: screenHeight * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: ListView.builder(
        itemCount: stockSymbols.length,
        itemBuilder: (context, index) {
          final stockSymbol = stockSymbols[index];

          // Get stock data for AAPL or set defaults for others
          StockData stockData = stockSymbol == "AAPL"
              ? _stockDataList.isNotEmpty
                  ? _stockDataList[0]
                  : StockData(
                      date: DateTime.now(),
                      open: 0,
                      high: 0,
                      low: 0,
                      close: 0,
                      volume: 0,
                    )
              : StockData(
                  date: DateTime.now(),
                  open: 0,
                  high: 0,
                  low: 0,
                  close: 0,
                  volume: 0,
                );

          return StockRow(
            stockName: stockSymbol,
            growthValue: calculateGrowthValue(stockData),
            stockValue: stockData.close,
            isSelected: index == 0,
          );
        },
      ),
    );
  }

  double calculateGrowthValue(StockData stockData) {
    if (stockData.open == 0) return 0; // Avoid division by zero
    return ((stockData.close - stockData.open) / stockData.open) * 100;
  }
}
