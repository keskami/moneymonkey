import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/stock_data.dart';

class StockService {
  static const String apiKey = 'NWARSDS78TNT8VN1';
  static const String baseUrl = 'https://www.alphavantage.co/query';

  Future<List<StockData>> fetchStockData(String symbol) async {
    final url = Uri.parse(
        '$baseUrl?function=TIME_SERIES_DAILY&symbol=$symbol&outputsize=full&apikey=$apiKey');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Check if there's an error message or missing 'Time Series (Daily)'
        if (jsonResponse.containsKey('Error Message')) {
          print('Error from API: ${jsonResponse['Error Message']}');
          throw Exception('Error fetching stock data for $symbol');
        } else if (!jsonResponse.containsKey('Time Series (Daily)')) {
          print(
              'No time series data in the response for $symbol: $jsonResponse');
          throw Exception('No stock data available for $symbol');
        }

        final Map<String, dynamic>? timeSeries =
            jsonResponse['Time Series (Daily)'] as Map<String, dynamic>?;

        if (timeSeries == null) {
          throw Exception('Time series data is null for $symbol');
        }

        List<StockData> stockDataList = timeSeries.entries.map((entry) {
          return StockData.fromJson(entry.value, entry.key);
        }).toList();

        // Sort list by date in ascending order
        stockDataList.sort((a, b) => b.date.compareTo(a.date));

        return stockDataList;
      } else {
        print('Failed to load stock data: ${response.statusCode}');
        throw Exception('Failed to load stock data');
      }
    } catch (e) {
      print('Exception occurred while fetching stock data: $e');
      throw Exception('Error fetching stock data for $symbol');
    }
  }
}
