import 'package:flutter/material.dart';
import 'package:money_monkey/Backend/Services/alpha_vantage_services.dart';
import 'package:money_monkey/Invest/Accessory%20Pages/news_web_view.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  StockService _stockService = StockService();
  Map<String, dynamic>? teslaStockData;
  Map<String, dynamic>? appleStockData;
  Map<String, dynamic>? googleStockData;
  Map<String, dynamic>? nasdaqStockData;
  Map<String, dynamic>? dowStockData;
  Map<String, dynamic>? nyseStockData;
  List<dynamic>? newsData;

  @override
  void initState() {
    super.initState();
    _fetchStockData();
    _fetchNewsData();
  }

  void _fetchStockData() async {
    try {
      final teslaData = await _stockService.fetchStockData('TSLA');
      final appleData = await _stockService.fetchStockData('AAPL');
      final googleData = await _stockService.fetchStockData("GOOGL");
      final nasdaqData = await _stockService.fetchGlobalQuoteData('MSFT');
      final dowData = await _stockService.fetchStockData('DJI');
      final nyseData = await _stockService.fetchStockData('AACG');

      print(nasdaqData);

      setState(() {
        teslaStockData = teslaData;
        appleStockData = appleData;
        googleStockData = googleData;
        nasdaqStockData = nasdaqData;
        dowStockData = dowData;
        nyseStockData = nyseData;
      });
    } catch (e) {
      print('Error fetching stock data: $e');
    }
  }

  //
  void _fetchNewsData() async {
    try {
      final news = await _stockService.fetchLatestNews();
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

    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F4),
      body: Column(
        children: [
          CurvedHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),

                    // Market Futures Section
                    const SectionTitle(title: 'Market futures'),
                    (teslaStockData == null || appleStockData == null)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MarketCard(
                                title: 'Tesla',
                                value: teslaStockData?['Time Series (Daily)']
                                        ?['2024-10-14']?['4. close'] ??
                                    'N/A',
                                change: _calculateChange(teslaStockData),
                                isPositive: _isPositive(teslaStockData),
                              ),
                              MarketCard(
                                title: 'Apple',
                                value: appleStockData?['Time Series (Daily)']
                                        ?['2024-10-14']?['4. close'] ??
                                    'N/A',
                                change: _calculateChange(appleStockData),
                                isPositive: _isPositive(appleStockData),
                              ),
                              MarketCard(
                                title: 'Google',
                                value: googleStockData?['Time Series (Daily)']
                                        ?['2024-10-14']?['4. close'] ??
                                    'N/A',
                                change: _calculateChange(googleStockData),
                                isPositive: _isPositive(googleStockData),
                              ),
                              //                             MarketCard(
                              //   title: 'NYSE',
                              //   value: nyseStockData?['Time Series (Daily)']?['2024-10-14']?['4. close'] ?? 'N/A',
                              //   change: _calculateChange(nyseStockData),
                              //   isPositive: _isPositive(nyseStockData),
                              // // ),
                              //                           MarketCard(
                              //   title: 'NASDAQ',
                              //   value: nasdaqStockData?['Time Series (Daily)']?['2024-10-14']?['4. close'] ?? 'N/A',
                              //   change: _calculateChange(nasdaqStockData),
                              //   isPositive: _isPositive(nasdaqStockData),

                              // ),
                              //  MarketCard(
                              //   title: 'DOW',
                              //   value: dowStockData?['Time Series (Daily)']?['2024-10-14']?['4. close'] ?? 'N/A',
                              //   change: _calculateChange(dowStockData),
                              //   isPositive: _isPositive(dowStockData),
                              // ),
                            ],
                          ),
                    SizedBox(height: screenHeight * 0.03),

                    // Top 2 Stocks Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SectionTitle(title: 'Top 2 Stocks'),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'View all >',
                            style: TextStyle(
                                color: Color(0xFF57636C),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Baloo 2"),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TopStocks(
                          title: 'Tesla',
                          value: teslaStockData?['Time Series (Daily)']
                                  ?['2024-10-11']?['4. close'] ??
                              'N/A',
                          change: _calculateChange(teslaStockData),
                          isPositive: _isPositive(teslaStockData),
                        ),
                        const SizedBox(width: 20),
                        TopStocks(
                          title: 'Apple',
                          value: appleStockData?['Time Series (Daily)']
                                  ?['2024-10-11']?['4. close'] ??
                              'N/A',
                          change: _calculateChange(appleStockData),
                          isPositive: _isPositive(appleStockData),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),

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
                    SizedBox(height: screenHeight * 0.03),

                    // What's Trending Section
                    const SectionTitle(title: "What's Trending"),
                    (newsData == null)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: newsData!
                                .take(6) // Show top 3 news articles
                                .map((article) => TrendingCard(
                                      title: article['title'] ?? 'No Title',
                                      source:
                                          article['source'] ?? 'Unknown Source',
                                      timeAgo: article['time_published'] ??
                                          'Unknown Time',
                                      url: article["url"] ?? "N/A",
                                    ))
                                .toList(),
                          ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _calculateChange(Map<String, dynamic>? stockData) {
  if (stockData == null || stockData['Time Series (Daily)'] == null)
    return 'N/A';

  final timeSeries = stockData['Time Series (Daily)'] as Map<String, dynamic>?;
  if (timeSeries == null || timeSeries.isEmpty) return 'N/A';

  final latestData = timeSeries.entries.first.value as Map<String, dynamic>?;
  final previousData =
      timeSeries.entries.elementAt(1).value as Map<String, dynamic>?;

  if (latestData == null || previousData == null) return 'N/A';

  final close = double.tryParse(latestData['4. close'] ?? '');
  final previousClose = double.tryParse(previousData['4. close'] ?? '');

  if (close != null && previousClose != null) {
    final change = ((close - previousClose) / previousClose) * 100;
    return '${change.toStringAsFixed(2)}%';
  }
  return 'N/A';
}

bool _isPositive(Map<String, dynamic>? stockData) {
  if (stockData == null || stockData['Time Series (Daily)'] == null)
    return false;

  final timeSeries = stockData['Time Series (Daily)'] as Map<String, dynamic>?;
  if (timeSeries == null || timeSeries.isEmpty) return false;

  final latestData = timeSeries.entries.first.value as Map<String, dynamic>?;
  final previousData =
      timeSeries.entries.elementAt(1).value as Map<String, dynamic>?;

  if (latestData == null || previousData == null) return false;

  final close = double.tryParse(latestData['4. close'] ?? '');
  final previousClose = double.tryParse(previousData['4. close'] ?? '');

  if (close != null && previousClose != null) {
    return close > previousClose;
  }
  return false;
}

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
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Container(
      width: screenWidth * 0.3,
      height: screenHeight * 0.12,
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      padding: EdgeInsets.all(screenHeight * 0.012),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: screenWidth * 0.02 * textScaleFactor,
            offset: Offset(0, screenHeight * 0.005),
          ),
        ],
      ),
      child: Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: "Baloo 2"),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF5963),
                  fontFamily: "Baloo 2"),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              change,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isPositive ? Colors.green : Colors.red,
                  fontFamily: "Baloo 2"),
            ),
          ],
        ),
      ),
    );
  }
}

class TopStocks extends StatelessWidget {
  final String title;
  final String value;
  final String change;

  final bool isPositive;

  const TopStocks(
      {Key? key,
      required this.title,
      required this.value,
      required this.change,
      required this.isPositive})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // double cardWidth = screenSize.width * 0.4;
    // double cardHeight = screenSize.height * 0.08;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Container(
      width: screenWidth * 0.43,
      height: screenHeight * 0.1,
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.0),
      padding: EdgeInsets.all(screenHeight * 0.014),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
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
            style: TextStyle(
                fontSize: screenHeight * 0.02,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "Baloo 2"),
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF5963),
                    fontFamily: "Baloo 2"),
              ),
              Text(
                change,
                style: TextStyle(
                    fontSize: screenHeight * 0.018,
                    fontWeight: FontWeight.bold,
                    color: isPositive ? Colors.green : Colors.red,
                    fontFamily: "Baloo 2"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
                fontFamily: "Baloo 2"),
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

class TrendingCard extends StatelessWidget {
  final String title;
  final String source;
  final String timeAgo;
  final String url;

  const TrendingCard(
      {Key? key,
      required this.title,
      required this.source,
      required this.timeAgo,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double cardHeight = screenSize.height * 0.12;

    double paddingSize = screenSize.width * 0.03; // Relative padding

    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewApp(url: url),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: cardHeight,
        margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
        padding: EdgeInsets.all(paddingSize),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenSize.width * 0.03),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: screenSize.width * 0.02,
              offset: Offset(0, screenSize.height * 0.002),
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
              style: TextStyle(
                  fontSize: screenSize.height * 0.022,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Baloo 2"),
            ),
            const SizedBox(height: 4),
            Text(
              '$source - $timeAgo',
              style: TextStyle(
                  fontSize: screenSize.height * 0.015,
                  color: Colors.grey,
                  fontFamily: "Baloo 2"),
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
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.15, // Height of the header
      decoration: BoxDecoration(
        color: const Color(0xFFFFEB99),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
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
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
      child: Text(
        title,
        style: TextStyle(
            fontSize: screenSize.height * 0.025,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "Baloo 2"),
      ),
    );
  }
}
