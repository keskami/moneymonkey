import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Invest/Widgets/line_chart_widget.dart';
import 'package:money_monkey/Invest/Widgets/title_row.dart';
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
  String _duration = "24H";

  // Function to load data from the StockService for all symbols
  Future<void> _loadStockDataForAllSymbols() async {
    List<String> symbols = ["AAPL", "PG", "JNJ", "JPM"];
    try {
      for (String symbol in symbols) {
        await _stockService.preloadStockData(symbol);
        setState(() {
          _stockDataMap[symbol] = _stockService.getCachedData(
              symbol, _duration == 24 ? 'intraday' : 'daily', _duration);
        });
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
    _loadStockDataForAllSymbols();
  }

  // Function to update the selected symbol and reload the graph
  void _updateSelectedSymbol(String symbol) {
    setState(() {
      _selectedSymbol = symbol;
    });
  }

  // Calculate the percentage change for a given duration
  double _calculateChangeForDuration(int days) {
    List<StockData> data = _stockDataMap[_selectedSymbol] ?? [];
    if (data.isEmpty || data.length <= days) return 0.0;

    double currentValue = data[0].close;
    double pastValue = data[days].close;
    return ((currentValue - pastValue) / pastValue) * 100;
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
            TitleRow(
              selectedSymbol: _selectedSymbol,
              stockValue: _stockDataMap[_selectedSymbol] == null
                  ? 233.86
                  : _stockDataMap[_selectedSymbol]![0].open,
              changePercentage: _stockDataMap[_selectedSymbol] == null
                  ? 3
                  : _stockDataMap[_selectedSymbol]![0].close,
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
                _buildDurationButton("24H"),
                const Spacer(),
                _buildDurationButton("7D"),
                const Spacer(),
                _buildDurationButton("1M"),
                const Spacer(),
                _buildDurationButton("3M"),
                const Spacer(),
                _buildDurationButton("1Y"),
                const Spacer(),
                _buildDurationButton("ALL"),
                const Spacer(),
              ],
            ),
            if (!_stockDataMap.isEmpty)
              StocksList(
                stockDataMap: _stockDataMap,
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
      floatingActionButton: TradeButton(
        selectedSymbol: _selectedSymbol,
      ),
    );
  }

  Widget _buildDurationButton(String label) {
    return TextButton(
      onPressed: () {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Duration set to $label")));

        setState(() {
          _duration = label;

          _stockDataMap[_selectedSymbol] = _stockService.getCachedData(
              _selectedSymbol,
              _duration == 24 ? 'intraday' : 'daily',
              _duration);
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Duration set to $label")));
      },
      child: Text(
        label,
        style: GoogleFonts.baloo2(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
