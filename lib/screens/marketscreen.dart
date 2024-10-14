import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:moneymonkey/backend/models/alpha_vantage_services.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {


    final StockService _stockService = StockService();
  Map<String, dynamic>? teslaStockData;
  Map<String, dynamic>? appleStockData;
    Map<String, dynamic>?googleStockData;
  List<dynamic>? newsData; // Variable to hold the fetched news data

  @override
  void initState() {
    super.initState();
    _fetchStockData(); 
    _fetchNewsData();  
  }

  // Function to fetch stock data for Tesla and Apple
  void _fetchStockData() async {
    try {
      final teslaData = await _stockService.fetchStockData('TSLA'); 
      final appleData = await _stockService.fetchStockData('AAPL'); 
      final googleData = await _stockService.fetchStockData("GOOGL");

      setState(() {
        teslaStockData = teslaData;
        appleStockData = appleData;
        googleStockData= googleData;
      });
    } catch (e) {
      print('Error fetching stock data: $e');
    }
  }

  // Function to fetch the latest news
  void _fetchNewsData() async {
    try {
      final news = await _stockService.fetchLatestNews(); // Fetch news data
      setState(() {
        newsData = news;
      });
    } catch (e) {
      print('Error fetching news: $e');
    }
  }
  @override

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F4), // Light background color
      body: Column(
        children: [
          // Add the new curved header with back button
          CurvedHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                      
                    // Market Futures Section
                    const SectionTitle(title: 'Market futures'),
                    (teslaStockData==null || appleStockData==null)?
                    Center(child: CircularProgressIndicator(),):
                Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MarketCard(
                                title: 'Tesla',
                                value: teslaStockData?['Time Series (Daily)']?['2024-10-14']?['4. close'] ?? 'N/A',
                                change: _calculateChange(teslaStockData), 
                                isPositive: _isPositive(teslaStockData),
                              ),
                              MarketCard(
                                title: 'Apple',
                                value: appleStockData?['Time Series (Daily)']?['2024-10-14']?['4. close'] ?? 'N/A',
                                change: _calculateChange(appleStockData), 
                                isPositive: _isPositive(appleStockData),
                              ),
                              MarketCard(
                                title: 'Google',
                                value: googleStockData?['Time Series (Daily)']?['2024-10-14']?['4. close'] ?? 'N/A',
                                change: _calculateChange(googleStockData), 
                                isPositive: _isPositive(googleStockData),
                              ),
                            ],
                          ),
                    const SizedBox(height: 20),
                      
                    // Top 2 Stocks Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SectionTitle(title: 'Top 2 Stocks'),
                        GestureDetector(
                          onTap: () {
                            // Navigate to more stocks
                           
                           // _fetchStockData("TSLA");
                          },
                          child: const Text(
                            'View all >',
                            style: TextStyle(
                              color: Color(0xFF57636C),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Baloo 2"
                            ),
                          ),
                        )
                      ],
                    ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TopStocks(
                          title: 'Tesla',
                          value: teslaStockData?['Time Series (Daily)']?['2024-10-11']?['4. close'] ?? 'N/A',
                          change: _calculateChange(teslaStockData),
                          isPositive: _isPositive(teslaStockData),
                        ),
                        const SizedBox(width: 20),
                        TopStocks(
                          title: 'Apple',
                          value: appleStockData?['Time Series (Daily)']?['2024-10-11']?['4. close'] ?? 'N/A',
                          change: _calculateChange(appleStockData),
                          isPositive: _isPositive(appleStockData),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                      
                    // Bonds Section
                    const SectionTitle(title: 'Bonds'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        BondCard(title: '3M', percentage: '5.27%'),
                        BondCard(title: '6M', percentage: '5.04%'),
                        BondCard(title: '9M', percentage: '4.81%'),
                      ],
                    ),
                    const SizedBox(height: 20),
                      
                    // What's Trending Section
                    const SectionTitle(title: "What's Trending"),
                    (newsData==null)?Center(child: CircularProgressIndicator(),):
                  Column(
                            children: newsData!
                                .take(3) // Show top 3 news articles
                                .map((article) => TrendingCard(
                                      title: article['title'] ?? 'No Title',
                                      source: article['source'] ?? 'Unknown Source',
                                      timeAgo: article['time_published'] ?? 'Unknown Time',
                                      url: article["url"]??"gay",
                                    ))
                                .toList(),
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
 bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set the active tab
        selectedItemColor: Colors.black, 
        unselectedItemColor: Colors.grey, 
        showUnselectedLabels: true,
        backgroundColor: Colors.white, // Background color
        selectedLabelStyle: const TextStyle(
          fontSize: 20,
          fontFamily: "Baloo 2",
          fontWeight: FontWeight.bold,
          
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: "Baloo 2",
          fontSize: 20,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore, color: Colors.transparent), 
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart, color: Colors.transparent), 
            label: 'Markets',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.house, color: Colors.transparent), 
            label: 'Real Estate',
          ),
        ],
      ),
    );
  }
}
  // Function to calculate the percentage change in stock price
  String _calculateChange(Map<String, dynamic>? stockData) {
    if (stockData == null || stockData['Time Series (Daily)'] == null) return 'N/A';

    final timeSeries = stockData['Time Series (Daily)'] as Map<String, dynamic>?;
    if (timeSeries == null || timeSeries.isEmpty) return 'N/A';

    final latestData = timeSeries.entries.first.value as Map<String, dynamic>?;
    final previousData = timeSeries.entries.elementAt(1).value as Map<String, dynamic>?;

    if (latestData == null || previousData == null) return 'N/A';

    final close = double.tryParse(latestData['4. close'] ?? '');
    final previousClose = double.tryParse(previousData['4. close'] ?? '');

    if (close != null && previousClose != null) {
      final change = ((close - previousClose) / previousClose) * 100;
      return '${change.toStringAsFixed(2)}%';
    }
    return 'N/A';
  }

  // Function to determine if the stock price change is positive
  bool _isPositive(Map<String, dynamic>? stockData) {
    if (stockData == null || stockData['Time Series (Daily)'] == null) return false;

    final timeSeries = stockData['Time Series (Daily)'] as Map<String, dynamic>?;
    if (timeSeries == null || timeSeries.isEmpty) return false;

    final latestData = timeSeries.entries.first.value as Map<String, dynamic>?;
    final previousData = timeSeries.entries.elementAt(1).value as Map<String, dynamic>?;

    if (latestData == null || previousData == null) return false;

    final close = double.tryParse(latestData['4. close'] ?? '');
    final previousClose = double.tryParse(previousData['4. close'] ?? '');

    if (close != null && previousClose != null) {
      return close > previousClose;
    }
    return false;
  }


// Custom Widget for the Market Card (used for futures and stocks)
class MarketCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final bool isPositive;

  const MarketCard({
    Key? key,
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double cardWidth = screenSize.width * 0.3; // Adjust card width
    double cardHeight = screenSize.height * 0.10; 

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
                   fontFamily: "Baloo 2"
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
             color: Color(0xFFFF5963),
                   fontFamily: "Baloo 2"
            ),
          ),
          SizedBox(height: 2,),
          Text(
            change,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.green : Colors.red,
              fontFamily: "Baloo 2"
            ),
          ),
        ],
      ),
    );
  }
}


class TopStocks extends StatelessWidget{
  final String title;
  final String value;
  final String change;
  
  final bool isPositive;

  const TopStocks({
        Key? key,
        required this.title,
        required this.value,
        required this.change,
      
        required this.isPositive
  }): super(key: key);
 @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double cardWidth = screenSize.width * 0.4; // Adjust card width
    double cardHeight = screenSize.height * 0.08; 

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "Baloo 2"
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF5963),
                  fontFamily: "Baloo 2"
                ),
              ),
           
              Text(
            change,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.green : Colors.red,
              fontFamily: "Baloo 2"
            ),
          ),
            ],
          ),
          
        ],
      ),
    );
  }

}


// Custom Widget for Bonds
class BondCard extends StatelessWidget {
  final String title;
  final String percentage;

  const BondCard({
    Key? key,
    required this.title,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double cardWidth = screenSize.width * 0.26;
    double cardHeight = screenSize.height * 0.06;

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
        
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "Baloo 2"
            ),
          ),
          Text(
            percentage,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Widget for the Trending Section
class TrendingCard extends StatelessWidget {
  final String title;
  final String source;
  final String timeAgo;
  final String url;

  const TrendingCard({
    Key? key,
    required this.title,
    required this.source,
    required this.timeAgo,
    required this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double cardHeight = screenSize.height * 0.12;

    return GestureDetector(
      onTap:() async{
         if (await canLaunch(url)) {
          await launch(url);  // Open the URL in the browser
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Container(
        width: double.infinity,
        height: cardHeight,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Baloo 2"
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$source - $timeAgo',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontFamily: "Baloo 2"
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CurvedHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150, // Height of the header
      decoration: BoxDecoration(
        color: const Color(0xFFFFEB99), // Yellow background
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0), // Rounded corner on the top left
          topRight: Radius.circular(0), // Rounded corner on the top right
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 40, // Adjust top padding for the back button
            left: 16, // Left padding for the back button
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back on button tap
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 28, // Icon size
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0), // Adjust top padding for the title
              child: Text(
                'Market',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Baloo 2',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Section title widget
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: "Baloo 2"
        ),
      ),
    );
  }
}

