import 'dart:convert';
import 'package:http/http.dart' as http;

class StockService {
  final String apiKey = '53090LJ6HW4RM4VH'; // Replace with your Alpha Vantage API key

  // Function to fetch stock data for a specific symbol
  Future<Map<String, dynamic>> fetchStockData(String symbol) async {
    final String url =
        'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to load stock data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  // Function to fetch the latest news
  Future<List<dynamic>> fetchLatestNews() async {
    final String url = 'https://www.alphavantage.co/query?function=NEWS_SENTIMENT&apikey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['feed'] ?? [];
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching news: $e');
    }
  }
}
