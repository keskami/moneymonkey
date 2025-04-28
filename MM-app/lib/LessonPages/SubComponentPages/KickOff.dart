import 'package:flutter/material.dart';

class KickOff extends StatefulWidget {
  const KickOff({super.key});

  @override
  State<KickOff> createState() => _KickOffState();
}

class _KickOffState extends State<KickOff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kick Off'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Row(
        children: [
          Flexible(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
