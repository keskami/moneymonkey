import 'package:flutter/material.dart';

class ShadowedContainer extends Container {
  ShadowedContainer({
    super.key,
    super.child,
    super.width,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
