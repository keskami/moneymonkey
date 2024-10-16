import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/stock_data.dart';

class StockService {
  static const String apiKey = 'NWARSDS78TNT8VN1';
  static const String baseUrl = 'https://www.alphavantage.co/query';

  final Map<String, Map<String, List<StockData>>> _stockCache = {};
  final Map<String, int> days = {
    "24H": 24,
    "7D": 24 * 7,
    "1M": 30,
    "3M": 90,
    "1Y": 365,
    "ALL": 366,
  };

  Future<void> preloadStockData(String symbol) async {
    try {
      final intradayData = await _fetchIntradayData(symbol);
      final dailyData = await _fetchDailyData(symbol);

      if (intradayData.isNotEmpty && dailyData.isNotEmpty) {
        _stockCache[symbol] = {
          'intraday': intradayData,
          'daily': dailyData,
        };
      } else {
        print('Preload warning: Data for $symbol is incomplete.');
      }
    } catch (e) {
      print('Failed to preload data for $symbol: $e');
    }
  }

  Future<List<StockData>> _fetchIntradayData(String symbol) async {
    final url = Uri.parse(
        '$baseUrl?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=5min&outputsize=compact&apikey=$apiKey');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('Note')) {
          print(
              'API call limit reached for intraday data: ${jsonResponse['Note']}');
          return _stockCache[symbol]?['intraday'] ?? [];
        }

        if (jsonResponse.containsKey('Error Message')) {
          print(
              'Error fetching intraday data for $symbol: ${jsonResponse['Error Message']}');
          return [];
        }

        final Map<String, dynamic>? timeSeries =
            jsonResponse['Time Series (5min)'];
        if (timeSeries == null) {
          print('Intraday data is null for $symbol');
          return [];
        }

        List<StockData> stockDataList = timeSeries.entries.map((entry) {
          return StockData.fromJson(entry.value, entry.key);
        }).toList();

        stockDataList.sort((a, b) => b.date.compareTo(a.date));
        return stockDataList;
      } else {
        print(
            'Failed to load intraday data for $symbol. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Exception fetching intraday data for $symbol: $error');
      return [];
    }
  }

  Future<List<StockData>> _fetchDailyData(String symbol) async {
    final url = Uri.parse(
        '$baseUrl?function=TIME_SERIES_DAILY&symbol=$symbol&outputsize=full&apikey=$apiKey');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('Note')) {
          print(
              'API call limit reached for daily data: ${jsonResponse['Note']}');
          return _stockCache[symbol]?['daily'] ?? [];
        }

        if (jsonResponse.containsKey('Error Message')) {
          print(
              'Error fetching daily data for $symbol: ${jsonResponse['Error Message']}');
          return [];
        }

        final Map<String, dynamic>? timeSeries =
            jsonResponse['Time Series (Daily)'];
        if (timeSeries == null) {
          print('Daily data is null for $symbol');
          return [];
        }

        List<StockData> stockDataList = timeSeries.entries.map((entry) {
          return StockData.fromJson(entry.value, entry.key);
        }).toList();

        stockDataList.sort((a, b) => b.date.compareTo(a.date));
        return stockDataList;
      } else {
        print(
            'Failed to load daily data for $symbol. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Exception fetching daily data for $symbol: $error');
      return [];
    }
  }

  List<StockData> getCachedData(
      String symbol, String dataType, String duration) {
    final List<StockData>? data = _stockCache[symbol]?[dataType];

    if (data == null || data.isEmpty) {
      print('No cached data available for $symbol ($dataType)');
      return [];
    }

    if (duration == "24H" && dataType == 'intraday') {
      return data;
    } else if (dataType == 'daily') {
      int limit = days[duration] ?? data.length;
      return data.take(limit).toList();
    }

    print('Invalid duration or data type specified for $symbol');
    return [];
  }
}
