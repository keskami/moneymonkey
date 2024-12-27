import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class OptionsTile extends StatefulWidget {
  OptionsTile({
    super.key,
    required this.isSelected,
    required this.childWidget,
  });
  final bool isSelected;
  final Widget childWidget;

  @override
  State<OptionsTile> createState() => _OptionsTileState();
}

class _OptionsTileState extends State<OptionsTile> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: widget.isSelected
                ? 2
                : isHovering
                    ? 2
                    : 1,
            color: widget.isSelected
                ? LightTheme().pastelGreen
                : isHovering
                    ? LightTheme().pastelGreen
                    : Color.fromARGB(255, 178, 182, 182),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
          color: widget.isSelected ? LightTheme().pastelGreen : Colors.white,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: widget.childWidget,
      ),
    );
  }
}
