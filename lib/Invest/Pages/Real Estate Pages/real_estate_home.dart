import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Invest/Pages/discover_page.dart';

import '../../Widgets/real_estate_item.dart';

class RealEstateHome extends StatefulWidget {
  const RealEstateHome({super.key});

  @override
  State<RealEstateHome> createState() => _RealEstateHomeState();
}

class _RealEstateHomeState extends State<RealEstateHome> {
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
      "assets/real_estate/house.png",
      "assets/real_estate/stadium.png",
      "assets/real_estate/shopping_mall.png",
      "assets/real_estate/office.png",
    ],
    "assets/real_estate/center4_copy.png": [
      "assets/real_estate/house.png",
      "assets/real_estate/stadium.png",
      "assets/real_estate/shopping_mall.png",
      "assets/real_estate/office.png",
    ],
    "assets/real_estate/center3_copy.png": [
      "assets/real_estate/house.png",
      "assets/real_estate/stadium.png",
      "assets/real_estate/shopping_mall.png",
      "assets/real_estate/office.png",
    ],
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
        bottomNavigationBar: _buildBottomNavigationBar(),
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
        screenHeight * 0.07,
        0,
        screenHeight * 0.2,
      ),
      itemCount: itemEntries.length,
      itemBuilder: (context, index) {
        bool isEven = index % 2 == 0;
        final item = itemEntries[index];

        return Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.04,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    isEven ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: screenWidth * 0.29,
                  ),
                  RealEstateItem(
                    center: item.key,
                    neighbours: item.value,
                    start: !isEven,
                  ),
                  SizedBox(
                    width: screenWidth * 0.29,
                  ),
                ],
              ),
              SizedBox(
                height: item.value.length.toDouble() * 25,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiscoverPage(),
                  ));
            },
            child: Text(
              "Discover",
              style: GoogleFonts.baloo2(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => MarketScreen(),
              //     ));
            },
            child: Text(
              "Markets",
              style: GoogleFonts.baloo2(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Real Estate",
              style: GoogleFonts.baloo2(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
