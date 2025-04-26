// lesson_box.dart
import 'package:flutter/material.dart';

/// A simple rectangular lesson widget that replaces the previous polygon avatar.
/// [width] controls the overall size of the box.
/// [isActivated] toggles the unlocked / locked visual state.
/// [index] is the 0-based lesson index, used to pick the right icon from [imageLinks].
/// [imageLinks] should point to the list of lesson icon URLs (same list previously
/// supplied to `CustomPolygonRow`).
class LessonBox extends StatelessWidget {
  const LessonBox({
    Key? key,
    required this.width,
    required this.isActivated,
    required this.index,
    required this.imageLinks,
  }) : super(key: key);

  /// Box side length.
  final double width;
  final bool isActivated;
  final int index;
  final List<String> imageLinks;

  @override
  Widget build(BuildContext context) {
    // Defensive check: if index is out of range, show generic placeholder.
    final String? imageUrl = (index >= 0 && index < imageLinks.length)
        ? imageLinks[index]
        : null;

    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActivated ? const Color.fromRGBO(25, 160, 18, 1) : const Color.fromRGBO(135, 206, 235, 1),
          width: 3,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Lesson icon
          if (imageUrl != null)
            Image.network(
              imageUrl,
              width: width * 0.6,
              height: width * 0.6,
              fit: BoxFit.contain,
            ),
          // Locked overlay when not activated
          if (!isActivated)
            const Icon(
              Icons.lock,
              color: Colors.grey,
              size: 28,
            ),
        ],
      ),
    );
  }
}
