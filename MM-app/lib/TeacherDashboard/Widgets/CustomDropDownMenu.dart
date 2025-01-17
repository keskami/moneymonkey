import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDownContainer extends StatelessWidget {
  const CustomDropDownContainer({
    super.key,
    this.initialSelection,
    required this.items,
    required this.onChanged,
    required this.width,
  });
  final List items;
  final String? initialSelection;
  final Function(String?) onChanged;
  final double width;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: screenHeight * 0.04,
      child: DropdownButtonFormField<String>(
        focusColor: Colors.white,
        autofocus: false,
        value: initialSelection,
        style: GoogleFonts.baloo2(
          fontSize: 16,
        ),
        items: items
            .map(
              (className) => DropdownMenuItem<String>(
                value: className, // Provide the value for this item
                child: Text(
                  className,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (String? value) {
          onChanged(value);
        },
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.01,
            vertical: screenHeight * 0.01,
          ),
          border: OutlineInputBorder(),
        ),
        dropdownColor: Colors.white,
      ),
    );
  }
}
