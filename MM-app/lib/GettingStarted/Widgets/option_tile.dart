import 'package:flutter/widgets.dart';
import 'package:money_monkey/themes/color_themes.dart';

class CustomOptionTile extends StatelessWidget {
  const CustomOptionTile({
    super.key,
    required this.isSelected,
    required this.childWidget,
  });
  final bool isSelected;
  final Widget childWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: isSelected ? 2 : 1,
          color: isSelected
              ? LightTheme().primaryBlue
              : Color.fromARGB(255, 178, 182, 182),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
        color: const Color.fromARGB(
          255,
          242,
          243,
          243,
        ),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: childWidget,
    );
  }
}
