import 'dart:convert';
import 'package:http/http.dart' as http;

class StockService {
  final String apiKey = '4L9AN2G6OVNXRY23'; 

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
Future<Map<String, dynamic>> fetchGlobalQuoteData(String symbol) async {
  final url = 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final responseBody = response.body;
    print('Response: $responseBody'); 
    final data = json.decode(responseBody);

    if (data.containsKey("Note")) {
      throw Exception("API rate limit exceeded. ${data["Note"]}");
    }

    if (data.containsKey("Error Message")) {
      throw Exception("Invalid API request. ${data["Error Message"]}");
    }

    if (data['Global Quote'] != null && data['Global Quote'].isNotEmpty) {
      return data['Global Quote'];
    } else {
      throw Exception('No data available for $symbol');
    }
  } else {
    throw Exception('Failed to load global quote data');
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
