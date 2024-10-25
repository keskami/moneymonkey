import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controller/controller.dart';

class MonkeyProgressWidget extends StatefulWidget {
  final ProgressController progressController;

  const MonkeyProgressWidget({Key? key, required this.progressController}) : super(key: key);

  @override
  State<MonkeyProgressWidget> createState() => _MonkeyProgressWidgetState();
}

class _MonkeyProgressWidgetState extends State<MonkeyProgressWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Listen to the progress value and update the animation
    widget.progressController.progress.listen((progress) {
      _animationController.animateTo(progress, curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background line or rope to indicate the path
        Container(
          height: 4,
          width: double.infinity,
          color: Colors.grey.shade300,
        ),
        // Monkey animation positioned based on progress
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            double progress = _animationController.value;
            double position = MediaQuery.of(context).size.width * progress;
            return Positioned(
              left: position,
              child: Lottie.asset(
                'assets/images/swinging_monkey.json', // Your Lottie animation file
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ],
    );
  }
}
