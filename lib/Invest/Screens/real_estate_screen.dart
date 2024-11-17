import 'package:flutter/material.dart';

import '../Widgets/real_estate_item.dart';

class RealEstateScreen extends StatefulWidget {
  const RealEstateScreen({super.key});

  @override
  State<RealEstateScreen> createState() => _RealEstateScreenState();
}

class _RealEstateScreenState extends State<RealEstateScreen> {
  final Map<String, List<String>> items = {
    "assets/real_estate/center1.png": [
      "assets/real_estate/house.png",
    ],
    "assets/real_estate/center2.png": [
      "assets/real_estate/hotel.png",
      "assets/real_estate/hotel_2.png",
    ],
    "assets/real_estate/center3.png": [
      "assets/real_estate/bakery.png",
      "assets/real_estate/restaurant.png",
      "assets/real_estate/donut_bakery.png",
    ],
    "assets/real_estate/center4.png": [
      "assets/real_estate/stadium.png",
      "assets/real_estate/shopping_mall.png",
      "assets/real_estate/airport.png",
    ],
    "assets/real_estate/center_complete.png": [],
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 137, 220, 142),
        body: _buildGridScreenshot(context),
      ),
    );
  }

  Widget _buildGridScreenshot(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final itemEntries = items.entries.toList();

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        0,
        screenHeight * 0.12,
        0,
        screenHeight * 0.2,
      ),
      itemCount: itemEntries.length,
      itemBuilder: (context, index) {
        bool isEven = index % 2 == 0;
        final item = itemEntries[index];

        return Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    isEven ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: screenWidth * 0.25,
                  ),
                  RealEstateItem(
                    center: item.key,
                    neighbours: item.value,
                    start: !isEven,
                    isFin: index > item.value.length,
                  ),
                  SizedBox(
                    width: screenWidth * 0.26,
                  ),
                ],
              ),
              index != item.value.length
                  ? SizedBox(
                      height: item.value.length.toDouble() * 12,
                    )
                  : SizedBox(
                      height: item.value.length.toDouble() * 6,
                    ),
            ],
          ),
        );
      },
    );
  }
}
