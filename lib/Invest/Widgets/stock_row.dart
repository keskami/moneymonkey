import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/themes/color_themes.dart';

class StockRow extends StatelessWidget {
  const StockRow({
    super.key,
    required this.stockName,
    required this.growthValue,
    required this.stockValue,
    this.isSelected = false,
  });
  final String stockName;
  final double growthValue;
  final double stockValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.1,
        vertical: screenHeight * 0.017,
      ),
      decoration: BoxDecoration(
        border: isSelected
            ? Border.all(
                color: LightTheme().primaryBlue,
                width: 1,
              )
            : null,
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? Colors.white : LightTheme().primaryBackgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              stockName,
              style: GoogleFonts.baloo2(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(
              growthValue >= 0 ? Icons.trending_up : Icons.trending_down,
              color: growthValue >= 0 ? Colors.green : Colors.red,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "${growthValue.toStringAsFixed(2)}%",
              style: GoogleFonts.baloo2(
                fontSize: 12,
                color: growthValue >= 0 ? Colors.green : Colors.red,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              "🍌${stockValue.toStringAsFixed(2)}",
              style: GoogleFonts.baloo2(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
