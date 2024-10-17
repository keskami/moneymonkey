import 'package:flutter/material.dart';
import 'package:money_monkey/Invest/Widgets/stock_row.dart';

import '../../Backend/Models/stock_data.dart';
import '../../themes/color_themes.dart';

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
  String _selectedStockSymbol = 'AAPL';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final List<String> stockSymbols = widget.stockDataMap.keys.toList();

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
          final stockDataList = widget.stockDataMap[stockSymbol];

          if (stockDataList == null || stockDataList.isEmpty) {
            return const SizedBox(); // Skip if no data available
          }

          // Assume we want the latest data point for the stock row
          final stockData = stockDataList.first;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedStockSymbol = stockSymbol;
              });
              widget.onStockSelected(stockSymbol);
            },
            child: StockRow(
              stockName: stockSymbol,
              growthValue: calculateGrowthValue(stockData),
              stockValue: stockData.close,
              isSelected: _selectedStockSymbol == stockSymbol,
            ),
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
