// widgets/top_bar.dart
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/img_transparent_logo.png', height: 40),
              const SizedBox(width: 8),
            ],
          ),
          Row(
            children: [
              Image.asset('assets/images/img_monkeymoney_50.png', height: 40),
              const SizedBox(width: 8),
              const Text('3', style: TextStyle(fontSize: 18)),
            ],
          ),
          Row(
            children: [
              Image.asset('assets/images/img_monkeymoney_51.png', height: 40),
              const SizedBox(width: 8),
              const Text('3', style: TextStyle(fontSize: 18)),
            ],
          ),
          Row(
            children: [
              Image.asset('assets/images/img_monkeymoney_52.png', height: 40),
              const SizedBox(width: 8),
              const Text('3', style: TextStyle(fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }
}
