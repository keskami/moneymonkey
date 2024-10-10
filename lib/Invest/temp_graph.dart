import 'package:flutter/material.dart';

import '../Backend/Models/stock_data.dart';
import '../Backend/Services/stock_service.dart';
import 'Widgets/line_chart_widget.dart';

class StockChartScreen extends StatefulWidget {
  final String symbol;
  const StockChartScreen({Key? key, required this.symbol}) : super(key: key);

  @override
  _StockChartScreenState createState() => _StockChartScreenState();
}

class _StockChartScreenState extends State<StockChartScreen> {
  final StockService _stockService = StockService();
  List<StockData> _stockDataList = [];

  @override
  void initState() {
    super.initState();
    _loadStockData();
  }

  Future<void> _loadStockData() async {
    try {
      final data = await _stockService.fetchStockData(widget.symbol);
      setState(() {
        _stockDataList = data;
      });
    } catch (e) {
      // Handle error (e.g., show a snackbar or an error message)
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.symbol} Stock Chart')),
      body: _stockDataList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SizedBox(
              height: 340, child: LineChartWidget(stockData: _stockDataList)),
    );
  }
}
