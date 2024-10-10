import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/stock_data.dart';

class StockService {
  static const String apiKey = 'NWARSDS78TNT8VN1';
  static const String baseUrl = 'https://www.alphavantage.co/query';

  Future<List<StockData>> fetchStockData(String symbol) async {
    final url = Uri.parse(
        '$baseUrl?function=TIME_SERIES_DAILY&symbol=$symbol&outputsize=full&apikey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final Map<String, dynamic> timeSeries =
          jsonResponse['Time Series (Daily)'];

      List<StockData> stockDataList = [];
      timeSeries.forEach((date, data) {
        stockDataList.add(StockData.fromJson(data, date));
      });

      // Sort list by date in ascending order
      stockDataList.sort((a, b) => a.date.compareTo(b.date));

      return stockDataList;
    } else {
      throw Exception('Failed to load stock data');
    }
  }
}
