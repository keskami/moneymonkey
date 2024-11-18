import 'package:flutter/material.dart';
import 'package:money_monkey/Invest/Widgets/property_cluster.dart';

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
        screenHeight * 0.05,
        0,
        screenHeight * 0.2,
      ),
      itemCount: itemEntries.length,
      itemBuilder: (context, index) {
        bool isEven = index % 2 == 0;
        final item = itemEntries[index];

        return SizedBox(
          height: screenHeight * 0.15,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (index != itemEntries.length - 1)
                Positioned(
                  top: screenHeight * 0.02,
                  left: isEven ? screenWidth * 0.01 : null,
                  right: isEven ? null : screenWidth * 0.05,
                  child: PropertyCluster(
                    neighbors: item.value,
                    isLeft: isEven,
                  ),
                ),
              Positioned(
                top: screenHeight * 0.1, // Adjust for better alignment
                left: isEven ? screenWidth * 0.2 : null,
                right: isEven ? null : screenWidth * 0.25,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index == itemEntries.length - 1)
                      SizedBox(
                        width: screenWidth * 0.08,
                      ),
                    Container(
                      child: RealEstateItem(
                        center: item.key,
                        neighbours: item.value,
                        start: !isEven,
                        isFin: index > item.value.length,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
