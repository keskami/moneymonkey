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
  String property = "";

  // Property details map
  Map<String, Map<String, String>> propertyDetails = {
    "Modern Loft": {
      "Address": "1234 Martin Luther King Jr Blvd, Detroit, MI 48208",
      "Baths": "2",
      "Beds": "2",
      "Area": "370m",
      "Property Tax": "187.5",
      "Maintenance Cost": "125",
      "Rental Income": "1600",
      "Appreciation": "325",
    },
    "Rural House": {
      "Address": "456 Elm Street, Palo Alto, CA 94301",
      "Baths": "3",
      "Beds": "2",
      "Area": "370m",
      "Property Tax": "2821",
      "Maintenance Cost": "2821",
      "Rental Income": "29000",
      "Appreciation": "15000",
    },
  };

  @override
  void initState() {
    super.initState();
    property = widget.property;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Get the details for the selected property
    final selectedPropertyDetails = propertyDetails[property] ?? {};

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: screenHeight * 0.05,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black.withOpacity(0.8),
              size: 30,
            ),
          )),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          screenWidth * 0.05,
          0,
          screenWidth * 0.05,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property image
            Container(
              width: double.infinity,
              height: screenHeight * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Image.asset(
                property == "Modern Loft"
                    ? "assets/real_estate/house.png"
                    : "assets/real_estate/rural_house.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Property navigation controls
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      property = "Modern Loft";
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                ),
                Text(
                  property == "Modern Loft" ? "1" : "2",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  height: 4,
                  width: screenWidth * 0.55,
                  color: LightTheme().primaryBlue,
                ),
                const Spacer(),
                Text(
                  "2",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      property = "Rural House";
                    });
                  },
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),

            Text(
              property,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              selectedPropertyDetails["Address"] ?? "",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Icon(Icons.bathtub_outlined, size: 30),
                  Text(selectedPropertyDetails["Baths"] ?? "N/A"),
                  const Spacer(),
                  Icon(Icons.bed, size: 30),
                  Text(selectedPropertyDetails["Beds"] ?? "N/A"),
                  const Spacer(),
                  Icon(Icons.expand_rounded, size: 30),
                  Text(selectedPropertyDetails["Area"] ?? "N/A"),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  crossAxisCount: 2,
                  mainAxisExtent: screenHeight * 0.1,
                ),
                padding: EdgeInsets.zero,
                children: [
                  _buildGridTile("Property Tax",
                      "🍌${selectedPropertyDetails["Property Tax"]}/month"),
                  _buildGridTile("Maintenance Cost",
                      "🍌${selectedPropertyDetails["Maintenance Cost"]}/month"),
                  _buildGridTile("Rental Income",
                      "🍌${selectedPropertyDetails["Rental Income"]}/month"),
                  _buildGridTile("Appreciation",
                      "🍌${selectedPropertyDetails["Appreciation"]}/month"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildGridTile(String title, String value) {
    return GridTile(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: title == "Appreciation" || title == "Rental Income"
                  ? Color.fromARGB(255, 137, 220, 142)
                  : Colors.red,
            ),
            child: Text(
              value,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
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
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: LightTheme().primaryBlue,
              ),
              child: Text(
                "Buy",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
