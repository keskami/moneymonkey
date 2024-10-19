import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Invest/Widgets/line_chart_widget.dart';
import 'package:money_monkey/Invest/Widgets/title_row.dart';
import 'package:money_monkey/Invest/Widgets/trade_button.dart';
import 'package:money_monkey/themes/color_themes.dart';

import '../Backend/Models/stock_data.dart';
import 'Widgets/investment_options_list.dart';

class InvestmentPage extends StatefulWidget {
  final String investmentType; // e.g., "Stocks", "ETFs", "Bonds"
  final dynamic investmentService; // Could be StockService, BondService, etc.
  final String defaultSymbol;
  const InvestmentPage({
    super.key,
    required this.investmentType,
    required this.investmentService,
    required this.defaultSymbol,
  });

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  Map<String, List<StockData>> _investmentDataMap = {};
  String _selectedSymbol = ""; // Start with no selected stock
  bool _isLoading = true;
  String _duration = "24H";

  @override
  void initState() {
    super.initState();
    // Initially no stock is selected
    _selectedSymbol = "";
    // You can load data similarly for any investment type
    // _loadInvestmentDataForAllSymbols();
  }

  // Function to update the selected symbol and reload the graph
  void _updateSelectedSymbol(String symbol) {
    setState(() {
      if (symbol == _selectedSymbol) {
        _selectedSymbol = ""; // Deselect if tapped again
      } else {
        _selectedSymbol = symbol;
      }
      _duration = "24H";
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
            if (_selectedSymbol == '')
              const Text(
                "Show default Portfolio Scores and\n Investments", // Display when no stock is selected
                style: TextStyle(fontSize: 24, color: Colors.grey),
              )
            else
              TitleRow(
                page: widget.investmentType, // Dynamic investment type
                selectedSymbol: _selectedSymbol,
                investmentValue:
                    _investmentDataMap[_selectedSymbol]?.isNotEmpty == true
                        ? _investmentDataMap[_selectedSymbol]![0].open
                        : 0.0, // Default value if data is unavailable
                changePercentage:
                    _investmentDataMap[_selectedSymbol]?.isNotEmpty == true
                        ? _investmentDataMap[_selectedSymbol]![0].close
                        : 0.0, // Default value if data is unavailable
              ),
            const SizedBox(height: 10),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.35,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _selectedSymbol != '' &&
                          _investmentDataMap[_selectedSymbol]?.isNotEmpty ==
                              true
                      ? Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: LineChartWidget(
                            duration: _duration,
                            stockData: _investmentDataMap[_selectedSymbol]!,
                          ),
                        )
                      : const Center(
                          child: Text(
                            "No data available",
                            style: TextStyle(color: Colors.grey),
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
            InvestmentOptionsList(
              dataMap: _investmentDataMap,
              onInvestmentSelected: _updateSelectedSymbol,
              defaultSelectedSymbol: widget.defaultSymbol,
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
                    Text("${widget.investmentType} Power >"), // Dynamic label
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
      height: MediaQuery.of(context).size.height * 0.06,
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
