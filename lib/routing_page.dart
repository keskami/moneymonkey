import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_monkey/Backend/Services/stock_service.dart';
import 'package:money_monkey/GettingStarted/Frontend/Pages/gs_home.dart';
import 'package:money_monkey/Invest/investment_page.dart';

import 'Backend/Models/stock_data.dart';

// ignore: camel_case_types
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            volume: 95000),
      ],
      'QUAL': [
        StockData(
            date: DateTime.now(),
            open: 110.0,
            close: 115.0,
            high: 118.0,
            low: 108.0,
            volume: 95000)
      ],
    };
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = FirebaseAuth.instance.currentUser;
            String userId = user?.uid ?? '';
            if (userId.isEmpty) {
              return GettingStartedHome();
            } else {
              // return ProfilePage(
              //   userID: userId,
              //   user: user!,
              // );
              return InvestmentPage(
                investmentService: StockService(),
                investmentType: "ETFs",
                defaultSymbol: 'SPY',
              );
            }
          } else {
            return GettingStartedHome();
          }
        },
      ),
    );
  }
}
