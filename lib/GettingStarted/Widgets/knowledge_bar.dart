import 'package:flutter/material.dart';

class KnowledgeBar extends StatelessWidget {
  final int strength;
  const KnowledgeBar({
    super.key,
    required this.strength,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildBar(1),
        const SizedBox(width: 2), // Space between bars
        _buildBar(2),
        const SizedBox(width: 2),
        _buildBar(3),
        const SizedBox(width: 2),
        _buildBar(4),
      ],
    );
  }

  // Function to build each bar
  Widget _buildBar(int barIndex) {
    return Container(
      width: 7, // Width of the bar
      height: barIndex * 8.0, // Height increases with the bar index
      decoration: BoxDecoration(
        color: barIndex <= strength
            ? const Color.fromARGB(255, 135, 206, 235)
            : const Color.fromARGB(
                255, 74, 91, 102), // Filled if barIndex <= strength
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
