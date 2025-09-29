import 'package:flutter/material.dart';
import 'package:money_monkey/PortfolioPages/portfolio_screen.dart';
import 'package:money_monkey/Profile/profile_page.dart';
import 'package:money_monkey/home.dart';

class BaseSideOfScreen extends StatelessWidget {
  final double screenHeight;
  final double screenWidthUnit;
  final double screenHeightUnit;

  BaseSideOfScreen({
    required this.screenHeight,
    required this.screenWidthUnit,
    required this.screenHeightUnit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight,
      width: screenWidthUnit * 159,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.black,
              width: screenWidthUnit * 1.5,
            ),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenHeightUnit * 80,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Container(
                height: screenHeightUnit * 100,
                width: screenWidthUnit * 130,
                child: Center(
                  child: Container(
                    height: screenHeightUnit * 60,
                    width: screenWidthUnit * 60,
                    child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FBottom%20Navigation%20Bar%20Icons%2FLesson%20Page.png?alt=media&token=1e20b2e4-ee49-49cc-bc01-dcf08b21104b"),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PortfolioScreen()),
                );
              },
              child: Container(
                height: screenHeightUnit * 100,
                width: screenWidthUnit * 130,
                child: Center(
                  child: Container(
                    height: screenHeightUnit * 60,
                    width: screenWidthUnit * 60,
                    child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FBottom%20Navigation%20Bar%20Icons%2FPortfolio.png?alt=media&token=d2012e7d-19fb-4766-9777-ce09231e4021"),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Container(
                height: screenHeightUnit * 100,
                width: screenWidthUnit * 130,
                child: Center(
                  child: Container(
                    height: screenHeightUnit * 60,
                    width: screenWidthUnit * 60,
                    child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FBottom%20Navigation%20Bar%20Icons%2FTrading.png?alt=media&token=2037e6b1-6fb6-48af-aecf-5f288c2159b0"),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: screenHeightUnit * 100,
                width: screenWidthUnit * 100,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(225, 243, 254, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Container(
                    height: screenHeightUnit * 60,
                    width: screenWidthUnit * 60,
                    child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FBottom%20Navigation%20Bar%20Icons%2FbudgetingSimulator.png?alt=media&token=27735960-da68-4e24-ae22-4a977b929264"),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: Container(
                height: screenHeightUnit * 100,
                width: screenWidthUnit * 130,
                child: Center(
                  child: Container(
                    height: screenHeightUnit * 60,
                    width: screenWidthUnit * 60,
                    child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FBottom%20Navigation%20Bar%20Icons%2FProfile.png?alt=media&token=80ec6904-46b7-4f76-85e1-dc21531e7a7c"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
