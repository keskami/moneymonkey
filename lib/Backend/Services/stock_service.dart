import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/stock_data.dart';

class StockService {
  static const String apiKey = 'M1UMAWSHLW32BUV0';
  static const String baseUrl = 'https://www.alphavantage.co/query';

  final Map<String, Map<String, List<StockData>>> _stockCache = {};
  final Map<String, int> days = {
    "24H": 24,
    "7D": 24,
    "1M": 30,
    "3M": 90,
    "1Y": 365,
    "ALL": 366,
  };
  Future<void> preloadStockData(String symbol) async {
    final intradayData = await _fetchIntradayData(symbol);
    final dailyData = await _fetchDailyData(symbol);

    _stockCache[symbol] = {
      'intraday': intradayData,
      'daily': dailyData,
    };
  }

  Future<List<StockData>> _fetchIntradayData(String symbol) async {
    final url = Uri.parse(
        '$baseUrl?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=5min&outputsize=compact&apikey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('Error Message')) {
        throw Exception('Error fetching intraday data for $symbol');
      }

      final Map<String, dynamic>? timeSeries =
          jsonResponse['Time Series (5min)'];
      if (timeSeries == null) {
        throw Exception('Intraday data is null for $symbol');
      }

      List<StockData> stockDataList = timeSeries.entries.map((entry) {
        return StockData.fromJson(entry.value, entry.key);
      }).toList();

      stockDataList.sort((a, b) => b.date.compareTo(a.date));

      return stockDataList;
    } else {
      throw Exception('Failed to load intraday data');
    }
  }

  Future<List<StockData>> _fetchDailyData(String symbol) async {
    final url = Uri.parse(
        '$baseUrl?function=TIME_SERIES_DAILY&symbol=$symbol&outputsize=full&apikey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('Error Message')) {
        throw Exception('Error fetching daily data for $symbol');
      }

      final Map<String, dynamic>? timeSeries =
          jsonResponse['Time Series (Daily)'];
      if (timeSeries == null) {
        throw Exception('Daily data is null for $symbol');
      }

      List<StockData> stockDataList = timeSeries.entries.map((entry) {
        return StockData.fromJson(entry.value, entry.key);
      }).toList();

      stockDataList.sort((a, b) => b.date.compareTo(a.date));

      return stockDataList;
    } else {
      throw Exception('Failed to load daily data');
    }
  }

  List<StockData> getCachedData(
      String symbol, String dataType, String duration) {
    final List<StockData>? data = _stockCache[symbol]?[dataType];

    if (data == null) {
      throw Exception('No cached data available for $symbol');
    }

    // Filter based on duration (e.g., 1 month, 3 months)
    if (duration == "24H" && dataType == 'intraday') {
      return data; // Full intraday data
    } else if (dataType == 'daily') {
      int limit = 0;
      if (duration == "7D") {
        limit = 7;
      } else if (duration == "1M") {
        limit = 30;
      } else if (duration == "3M") {
        limit = 90;
      } else if (duration == "1Y") {
        limit = 365;
      } else if (duration == "ALL") {
        limit = data.length;
      }

      return data.take(limit).toList();
    }

    throw Exception('Invalid duration or data type specified');
  }
}
