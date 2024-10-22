import 'package:flutter/material.dart';

import 'Backend/Services/stock_service.dart';
import 'Invest/investment_page.dart';

class TemporarySelectPage extends StatelessWidget {
  const TemporarySelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InvestmentPage(
                    investmentService: StockService(),
                    investmentType: "Stocks",
                    defaultSymbol: 'AAPL',
                  ),
                ));
              },
              child: const Text(
                "Stocks",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InvestmentPage(
                    investmentService: StockService(),
                    investmentType: "ETFs",
                    defaultSymbol: 'SPY',
                  ),
                ));
              },
              child: const Text(
                "ETF",
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Bonds",
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Mutual Funds",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
