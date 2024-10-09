import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class TradeButton extends StatefulWidget {
  const TradeButton({
    super.key,
  });

  @override
  State<TradeButton> createState() => _TradeButtonState();
}

bool isExpanded = false;

class _TradeButtonState extends State<TradeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 0),
        width: MediaQuery.of(context).size.width / 3,
        height: isExpanded
            ? MediaQuery.of(context).size.height * 0.10
            : MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
            ),
          ],
          gradient: LinearGradient(
            colors: [
              LightTheme().primaryBlue,
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: isExpanded
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Buy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  Text(
                    'Sell',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : const Align(
                alignment: Alignment.center,
                child: Text(
                  'Trade',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
