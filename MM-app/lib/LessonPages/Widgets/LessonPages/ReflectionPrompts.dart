import 'package:flutter/material.dart';

class ReflectionPrompts extends StatelessWidget {
  final String prompt;
  final int selectedIndex;
  final int index;
  final Function(int) onTap;

  const ReflectionPrompts({
    Key? key,
    required this.prompt,
    required this.selectedIndex,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {
          onTap(index);
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: selectedIndex == index
                ? const Color(0xFFE8F6FF)
                : const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selectedIndex == index
                  ? const Color(0xFF007FFF)
                  : const Color(0xFFF2F2F2),
              width: selectedIndex == index ? 0.6 : 0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                prompt,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}