import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({
    super.key,
    required this.property,
    required this.address,
  });

  final String property;
  final String address;

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  Map<String, Map<String, String>> propertyDetails = {
    "Modern Loft": {
      "Address": "1234 Martin Luther King Jr Blvd, Detroit, MI 48208",
      "Baths": "2",
      "Beds": "2",
      "Area": "370m",
    },
    "Rural House": {
      "Address": "456 Elm Street, Palo Alto, CA 94301",
      "Baths": "3",
      "Beds": "2",
      "Area": "370m",
    },
  };
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Image.asset(
                "assets/real_estate/house.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
                Text(
                  "1",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 4,
                  width: screenWidth * 0.6,
                  color: LightTheme().primaryBlue,
                ),
                const Spacer(),
                Text(
                  "3",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
              ],
            ),
            Text(
              widget.property,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.address,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(
                10,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Icon(
                    Icons.bathtub_outlined,
                    size: 30,
                  ),
                  Text("2"),
                  const Spacer(),
                  Icon(
                    Icons.bed,
                    size: 30,
                  ),
                  Text("2"),
                  const Spacer(),
                  Icon(
                    Icons.expand_rounded,
                    size: 30,
                  ),
                  Text("370m"),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  crossAxisCount: 2,
                  mainAxisExtent: screenHeight * 0.1,
                ),
                padding: EdgeInsets.zero,
                children: [
                  GridTile(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Property Tax",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          child: Text(
                            "🍌187.50/month",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GridTile(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Maintenance Cost",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          child: Text(
                            "🍌125/month",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GridTile(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Rental Income",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 137, 220, 142),
                          ),
                          child: Text(
                            "🍌1600/month",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GridTile(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Appreciation",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 137, 220, 142),
                          ),
                          child: Text(
                            "🍌325/month",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(1, -1),
              blurRadius: 5,
            )
          ],
        ),
        child: BottomAppBar(
          child: Row(
            children: [
              Text(
                "🍌150,000",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: LightTheme().primaryBlue,
                ),
                child: Text(
                  "Buy",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
