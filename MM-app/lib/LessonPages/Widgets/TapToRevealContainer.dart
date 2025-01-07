import 'package:flutter/material.dart';

class TapToRevealContainer extends StatefulWidget {
  const TapToRevealContainer({
    super.key,
    required this.contents,
    required this.instructions,
    this.onTap,
  });
  final Widget contents;
  final Widget instructions;
  final void Function()? onTap;
  @override
  State<TapToRevealContainer> createState() => _TapToRevealContainerState();
}

class _TapToRevealContainerState extends State<TapToRevealContainer> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        setState(() {
          isVisible = true;
        });
        widget.onTap?.call();
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: Container(
          key: ValueKey<bool>(isVisible),
          width: double.infinity,
          height: screenHeight * 0.55,
          child: isVisible ? widget.contents : widget.instructions,
        ),
      ),
    );
  }
}
