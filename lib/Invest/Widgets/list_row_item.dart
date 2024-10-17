import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/themes/color_themes.dart';

class InvestmentOptionItem extends StatelessWidget {
  const InvestmentOptionItem({
    super.key,
    required this.investmentName,
    required this.growthValue,
    required this.investmentValue,
    this.isSelected = false,
    this.isLoading = false,
  });

  final String investmentName;
  final double growthValue;
  final double investmentValue;
  final bool isSelected;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.07,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.015,
      ),
      decoration: BoxDecoration(
        border: isSelected
            ? Border.all(color: LightTheme().primaryBlue, width: 1)
            : null,
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? Colors.white : LightTheme().primaryBackgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Stock Name
          Expanded(
            flex: 2,
            child: Text(
              investmentName,
              style: GoogleFonts.baloo2(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // Growth Indicator
          Expanded(
            flex: 1,
            child: isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(
                    growthValue > 0 ? Icons.trending_up : Icons.trending_down,
                    color: growthValue > 0 ? Colors.green : Colors.red,
                    size: 20,
                  ),
          ),
          // Growth Value
          Expanded(
            flex: 7,
            child: isLoading
                ? Text(
                    "Loading...",
                    style: GoogleFonts.baloo2(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.right,
                  )
                : Text(
                    "${growthValue.toStringAsFixed(2)}%",
                    style: GoogleFonts.baloo2(
                      fontSize: 12,
                      color: growthValue > 0 ? Colors.green : Colors.red,
                    ),
                    textAlign: TextAlign.right,
                  ),
          ),
          // Stock Value
          Expanded(
            flex: 3,
            child: Text(
              isLoading
                  ? "Loading..."
                  : "🍌${investmentValue.toStringAsFixed(2)}",
              style: GoogleFonts.baloo2(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
