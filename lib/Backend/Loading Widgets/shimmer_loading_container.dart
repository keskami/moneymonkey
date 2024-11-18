import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
    required this.height,
    required this.width,
    this.base = Colors.grey,
    this.highlight = Colors.white,
  });
  final double height;
  final double width;
  final Color base;
  final Color highlight;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        height: height,
        width: width,
      ),
      baseColor: base.withOpacity(0.2),
      highlightColor: highlight.withOpacity(0.2),
    );
  }
}
