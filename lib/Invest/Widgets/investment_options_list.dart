import 'package:flutter/material.dart';
import 'package:money_monkey/Invest/Widgets/list_row_item.dart';

import '../../Backend/Models/stock_data.dart';
import '../../themes/color_themes.dart';

class InvestmentOptionsList extends StatefulWidget {
  final Map<String, List<StockData>> dataMap;
  final void Function(String)
      onInvestmentSelected; // Callback for stock selection
  final defaultSelectedSymbol;

  const InvestmentOptionsList({
    super.key,
    required this.dataMap,
    required this.onInvestmentSelected,
    required this.defaultSelectedSymbol,
  });

  @override
  _InvestmentOptionsListState createState() => _InvestmentOptionsListState();
}

class _InvestmentOptionsListState extends State<InvestmentOptionsList> {
  String _selectedInvestmentSymbol = '';
  @override
  void initState() {
    super.initState();
    _selectedInvestmentSymbol = widget.defaultSelectedSymbol;
  }

  // Define a temporary list to display if dataMap is empty
  final Map<String, List<StockData>> _tempDataMap = {
    'SPY': [
      StockData(
          date: DateTime.now(),
          open: 100.0,
          close: 120.0,
          high: 125.0,
          low: 95.0,
          volume: 100000)
    ],
    'QQQ': [
      StockData(
          date: DateTime.now(),
          open: 90.0,
          close: 85.0,
          high: 92.0,
          low: 80.0,
          volume: 80000)
    ],
    'VUG': [
      StockData(
          date: DateTime.now(),
          open: 110.0,
          close: 115.0,
          high: 118.0,
          low: 108.0,
          volume: 95000)
    ],
  };

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    // Use tempDataMap if widget.dataMap is empty
    final dataMap = widget.dataMap.isEmpty ? _tempDataMap : widget.dataMap;
    final List<String> investmentSymbols = dataMap.keys.toList();

    return Container(
      height: screenHeight * 0.28,
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.005,
      ),
      decoration: BoxDecoration(
        color: LightTheme().primaryBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: ListView.builder(
        itemCount: investmentSymbols.length,
        itemBuilder: (context, index) {
          final investmentSymbol = investmentSymbols[index];
          final dataList = dataMap[investmentSymbol];

          if (dataList == null || dataList.isEmpty) {
            return const SizedBox(); // Skip if no data available
          }

          // Assume we want the latest data point for the stock row
          final investmentData = dataList.first;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedInvestmentSymbol = investmentSymbol;
              });
              widget.onInvestmentSelected(investmentSymbol);
            },
            child: InvestmentOptionItem(
              investmentName: investmentSymbol,
              growthValue: calculateGrowthValue(investmentData),
              investmentValue: investmentData.close,
              isSelected: _selectedInvestmentSymbol == investmentSymbol,
              isLoading:
                  false, // Set this to true if you want to show a loading state
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
