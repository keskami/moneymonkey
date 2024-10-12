import 'package:flutter/material.dart';
import 'package:money_monkey/Invest/Widgets/stock_row.dart';

import '../../Backend/Models/stock_data.dart';

class StocksList extends StatelessWidget {
  final List<StockData> stockDataList;

  const StocksList({super.key, required this.stockDataList});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    final List<String> stockSymbols = ["AAPL", "PG", "JNJ", "JPM"];

    return Container(
      height: screenHeight * 0.25,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: ListView.builder(
        itemCount: stockSymbols.length,
        itemBuilder: (context, index) {
          final stockSymbol = stockSymbols[index];
          StockData stockData = stockSymbol == "AAPL"
              ? stockDataList.isNotEmpty
                  ? stockDataList[0]
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
    if (stockData.open == 0) return 0;
    return ((stockData.close - stockData.open) / stockData.open) * 100;
  }
}
