import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Invest/Widgets/investment_options_list.dart';
import 'package:money_monkey/Invest/Widgets/line_chart_widget.dart';
import 'package:money_monkey/Invest/Widgets/title_row.dart';
import 'package:money_monkey/Invest/Widgets/trade_button.dart';
import 'package:money_monkey/themes/color_themes.dart';

import '../../Backend/Models/StockData.dart';

class InvestmentDetailsScreen extends StatefulWidget {
  final String investmentType;
  final dynamic investmentService;
  final String defaultSymbol;

  const InvestmentDetailsScreen({
    Key? key,
    required this.investmentType,
    required this.investmentService,
    required this.defaultSymbol,
  }) : super(key: key);

  @override
  State<InvestmentDetailsScreen> createState() =>
      _InvestmentDetailsScreenState();
}

class _InvestmentDetailsScreenState extends State<InvestmentDetailsScreen> {
  Map<String, List<StockData>> _investmentDataMap = {};
  String _selectedSymbol = "";
  bool _isLoading = true;
  String _duration = "3M";
  List<StockData> _stockData = [];

  @override
  void initState() {
    super.initState();
    _selectedSymbol = "";
    _loadStockData();
  }

  Future<void> _loadStockData() async {
    setState(() {
      _isLoading = true;
    });

    final List<StockData> loadedStockData = await loadStockData();
    setState(() {
      _stockData = loadedStockData;
      _isLoading = false;
    });
  }

  // Function to load data from a local JSON file
  Future<List<StockData>> loadStockData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/sample_stock_data.json');
      final Map<String, dynamic> jsonMap = json.decode(response);
      final timeSeries = jsonMap["Time Series (Daily)"] as Map<String, dynamic>;

      List<StockData> loadedStockData = timeSeries.entries.map((entry) {
        final date = entry.key;
        final data = entry.value as Map<String, dynamic>;
        return StockData.fromJson(data, date);
      }).toList();

      // Sort the stock data in ascending order (oldest on the left)
      loadedStockData.sort(
          (a, b) => a.date.compareTo(b.date)); // Change sorting to ascending

      return loadedStockData;
    } catch (e) {
      print("Error loading data from JSON file: $e");
      return [];
    }
  }

  void _updateSelectedSymbol(String symbol) {
    setState(() {
      _selectedSymbol = (symbol == _selectedSymbol) ? "" : symbol;
      _duration = "3M";
    });
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleRow(
              page: widget.investmentType,
              selectedSymbol: _selectedSymbol,
              investmentValue:
                  _investmentDataMap[_selectedSymbol]?.isNotEmpty == true
                      ? _investmentDataMap[_selectedSymbol]![0].open
                      : 0.0,
              changePercentage:
                  _investmentDataMap[_selectedSymbol]?.isNotEmpty == true
                      ? _investmentDataMap[_selectedSymbol]![0].close
                      : 0.0,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.29,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _selectedSymbol == ''
                      ? SizedBox(
                          width: screenWidth,
                          height: screenHeight * 0.30,
                        )
                      : Container(
                          child: LineChartWidget(
                            duration: _duration,
                            stockData: _stockData,
                          ),
                        ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
            InvestmentOptionsList(
              dataMap: _investmentDataMap,
              onInvestmentSelected: _updateSelectedSymbol,
              page: widget.investmentType,
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
                  children: [
                    Text("${widget.investmentType} Power >"),
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
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: label == _duration
          ? BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: TextButton(
        onPressed: () {
          setState(() {
            _duration = label;
          });
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Duration set to $label")),
          );
        },
        child: Text(
          label,
          style: GoogleFonts.baloo2(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
