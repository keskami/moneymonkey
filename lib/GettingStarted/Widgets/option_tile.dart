import 'package:flutter/widgets.dart';

class CustomOptionTile extends StatelessWidget {
  const CustomOptionTile({
    super.key,
    required this.childWidget,
  });
  final Widget childWidget;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(
          255,
          242,
          243,
          243,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: childWidget,
    );
  }
}
