import 'package:flutter/material.dart';
import 'package:money_monkey/Invest/Widgets/stock_row.dart';

class StocksList extends StatefulWidget {
  const StocksList({super.key});

  @override
  State<StocksList> createState() => _StocksListState();
}

class _StocksListState extends State<StocksList> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.25,
      //Border added for testing sizing
      // decoration: BoxDecoration(
      //   border: Border.all(),
      // ),
      child: ListView(
        children: const [
          StockRow(
            stockName: "APPL",
            growthValue: -4.86,
            stockValue: 209.97,
            isSelected: true,
          ),
          StockRow(
            stockName: "PG",
            growthValue: -4.86,
            stockValue: 170.02,
          ),
          StockRow(
            stockName: "JNJ",
            growthValue: 4.82,
            stockValue: 158.90,
          ),
          StockRow(
            stockName: "JPM",
            growthValue: -4.82,
            stockValue: 200.40,
          ),
        ],
      ),
    );
  }
}
