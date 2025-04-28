import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A horizontal progress bar with segments and a close button.
class LessonProgressBar extends StatelessWidget {
  final int currentPage;
  final double currentProgress;
  final int totalPages;

  const LessonProgressBar({
    Key? key,
    required this.currentPage,
    required this.currentProgress,
    required this.totalPages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Row(
                children: List.generate(totalPages, (i) {
                  final target = (i < currentPage)
                      ? 1.0
                      : (i == currentPage)
                          ? currentProgress.clamp(0.0, 1.0)
                          : 0.0;
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Container(
                          height: 6,
                          color: Colors.grey.shade300,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: target),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                            builder: (context, val, _) => FractionallySizedBox(
                              widthFactor: val,
                              heightFactor: 1,
                              alignment: Alignment.centerLeft,
                              child: Container(color: const Color(0xFF007FFF)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () => Get.back(),
              tooltip: 'Close',
            ),
          ),
        ],
      ),
    );
  }
}
