import 'package:flutter/material.dart';

class ReflectionPrompts extends StatefulWidget {
  final double height;
  final double width;
  final String prompt;
  final int selectedIndex;
  final int index;
  final Function(int) onTap;

  const ReflectionPrompts({
    Key? key,
    required this.height,
    required this.width,
    required this.prompt,
    required this.selectedIndex,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  _ReflectionPromptsState createState() => _ReflectionPromptsState();
}

class _ReflectionPromptsState extends State<ReflectionPrompts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: widget.height * 30),
        child: GestureDetector(
            onTap: () {
              widget.onTap(widget.index);
            },
            child: Container(
              width: widget.width * 400,
              decoration: BoxDecoration(
                color: widget.selectedIndex == widget.index
                    ? Color.fromRGBO(232, 246, 255, 1)
                    : Color.fromRGBO(242, 242, 242, 1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: widget.selectedIndex == widget.index
                      ? Color.fromRGBO(0, 127, 255, 1)
                      : Color.fromRGBO(242, 242, 242, 1),
                  width: widget.selectedIndex == widget.index ? .6 : 0,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: widget.width * 20,
                    right: widget.width * 20,
                    top: widget.height * 20,
                    bottom: widget.height * 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.prompt,
                    style: TextStyle(
                      fontSize: widget.height * 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )));
  }
}