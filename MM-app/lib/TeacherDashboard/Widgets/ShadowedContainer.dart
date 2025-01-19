import 'package:flutter/material.dart';

class ShadowedContainer extends Container {
  ShadowedContainer({
    super.key,
    super.child,
    super.width,
    super.height,
    super.decoration,
    super.margin,
    super.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
