import 'package:flutter/material.dart';
import 'package:money_monkey/Invest/Widgets/stock_row.dart';

import '../../Backend/Models/stock_data.dart';
import '../../Backend/Services/stock_service.dart';

class StocksList extends StatefulWidget {
  const StocksList({super.key});

  @override
  State<StocksList> createState() => _StocksListState();
}

class _StocksListState extends State<StocksList> {
  final StockService _stockService = StockService();
  List<StockData> _stockDataList = [];
  final List<String> symbols = [
    "AAPL",
    "PG",
    "JNJ",
    "JPM"
  ]; // List of stock symbols

  Future<void> _loadStockData() async {
    try {
      List<StockData> allStockData = [];

      // Fetch data for all symbols
      for (String symbol in symbols) {
        final data = await _stockService.fetchStockData(symbol);
        allStockData.addAll(
            data); // Assuming fetchStockData returns a list of StockData
      }

      setState(() {
        _stockDataList = allStockData; // Update state with fetched data
      });
    } catch (e) {
      // Handle error (e.g., show a snackbar or an error message)
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadStockData(); // Load stock data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.25,
      decoration: BoxDecoration(
        color: Colors.white, // Set the desired background color here
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(10)), // Optional: rounded corners
      ),
      child: ListView.builder(
        itemCount: _stockDataList.length,
        itemBuilder: (context, index) {
          // Create a stock row for each stock symbol
          final stockData = _stockDataList[index];

          return StockRow(
            stockName:
                symbols[index], // Assuming symbols is aligned with stockData
            growthValue: calculateGrowthValue(
                stockData), // Implement this method to calculate growth
            stockValue: stockData.close, // Get the close price
            isSelected: index == 0, // Example selection logic
          );
        },
      ),
    );
  }

  double calculateGrowthValue(StockData stockData) {
    // Placeholder implementation for growth calculation
    return ((stockData.close - stockData.open) / stockData.open) * 100;
  }
}
