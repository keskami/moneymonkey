import 'package:flutter/services.dart';

class ProviderInstallerHelper {
  static const platform = MethodChannel('com.example.moneyMonkey/provider');

  static Future<void> installProvider() async {
    await platform.invokeMethod('installProvider');
  }
}
