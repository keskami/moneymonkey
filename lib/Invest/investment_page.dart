import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Invest/Widgets/chat_bubble.dart';
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
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2FmonkeyNoText.png?alt=media&token=d364a03e-40c7-48c8-a97b-887f1a180e2a",
                                height: 100,
                              ),
                              ChatBubbleContainer(
                                borderWidth: 1,
                                trianglePosition: TrianglePosition.left,
                                childWidget: Text(
                                  "${_duration == 30 ? 'Today' : 'Change over past ${_duration == 90 ? '3M' : _duration == 180 ? '6M' : '1Y'}'}",
                                  style: GoogleFonts.baloo2(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${_stockDataMap[_selectedSymbol]![_duration].open.toStringAsFixed(2)} "
                              "to ${_stockDataMap[_selectedSymbol]![0].close.toStringAsFixed(2)}",
                              style: GoogleFonts.baloo2(fontSize: 16),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "🍌${_stockDataMap[_selectedSymbol]![_duration == 30 ? 0 : _duration].open.toString()} ${_duration == 30 ? 'Today >' : ' ${_calculateChangeForDuration(_duration).toStringAsFixed(2)}% >'}",
                  style: GoogleFonts.baloo2(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
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
}
