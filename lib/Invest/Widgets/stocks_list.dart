import 'package:flutter/material.dart';
import 'package:money_monkey/Invest/Widgets/stock_row.dart';
import 'package:money_monkey/themes/color_themes.dart';

import '../../Backend/Models/stock_data.dart';

class StocksList extends StatefulWidget {
  final Map<String, List<StockData>> stockDataMap;
  final void Function(String) onStockSelected; // Callback for stock selection

  const StocksList({
    super.key,
    required this.stockDataMap,
    required this.onStockSelected,
  });

  @override
  _StocksListState createState() => _StocksListState();
}

class _StocksListState extends State<StocksList> {
  String _selectedStockSymbol =
      'AAPL'; // State variable to hold the selected stock symbol

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final List<String> stockSymbols = ["AAPL", "PG", "JNJ", "JPM"];

    return Container(
      height: screenHeight * 0.27,
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.005,
      ),
      decoration: BoxDecoration(
        color: LightTheme().primaryBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: ListView.builder(
        itemCount: stockSymbols.length,
        itemBuilder: (context, index) {
          final stockSymbol = stockSymbols[index];
          // Fetch the appropriate stock data based on the symbol
          final stockData = widget.stockDataMap[stockSymbol]?.first;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedStockSymbol =
                    stockSymbol; // Update selected stock symbol
              });
              widget.onStockSelected(stockSymbol); // Trigger callback
            },
            child: stockData != null
                ? StockRow(
                    stockName: stockSymbol,
                    growthValue: calculateGrowthValue(stockData),
                    stockValue: stockData.close,
                    isSelected: _selectedStockSymbol ==
                        stockSymbol, // Set isSelected based on current selection
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }

  double calculateGrowthValue(StockData stockData) {
    if (stockData.open == 0) return 0;
    return ((stockData.close - stockData.open) / stockData.open) * 100;
  }
}
