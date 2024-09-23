import 'package:flutter/services.dart';

class ProviderInstallerHelper {
  static const platform = MethodChannel('com.example.moneyMonkey/provider');

  static Future<void> installProvider() async {
    try {
      final result = await platform.invokeMethod('installProvider');
      print(result); // Optional: handle the success message
    } on PlatformException catch (e) {
      print("Failed to install provider: '${e.message}'.");
    }
  }
}
