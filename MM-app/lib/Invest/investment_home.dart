import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Invest/Screens/discover_screen.dart';
import 'package:money_monkey/Invest/Screens/market_screen.dart';
import 'package:money_monkey/Invest/Screens/real_estate_screen.dart';

class InvestmentHomePage extends StatefulWidget {
  InvestmentHomePage({
    super.key,
  });

  @override
  State<InvestmentHomePage> createState() => _InvestmentHomePageState();
}

class _InvestmentHomePageState extends State<InvestmentHomePage> {
  PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: [
          DiscoverScreen(),
          MarketScreen(),
          RealEstateScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          size: 30,
        ),
      ),
      bottomNavigationBar: _buildInvestBottomBar(context),
    );
  }

  Widget _buildInvestBottomBar(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              _pageController.animateToPage(0,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            },
            child: Text(
              "Discover",
              style: GoogleFonts.baloo2(
                fontSize: 18,
                fontWeight: currentPage == 0 ? FontWeight.bold : null,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _pageController.animateToPage(1,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            },
            child: Text(
              "Markets",
              style: GoogleFonts.baloo2(
                fontSize: 18,
                fontWeight: currentPage == 1 ? FontWeight.bold : null,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _pageController.animateToPage(
                2,
                duration: Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            },
            child: Text("Real Estate",
                style: GoogleFonts.baloo2(
                  fontSize: 18,
                  fontWeight: currentPage == 2 ? FontWeight.bold : null,
                  color: Colors.black,
                )),
          )
        ],
      ),
    );
  }
}
