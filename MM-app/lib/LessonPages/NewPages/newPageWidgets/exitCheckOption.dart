import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExitCheckOption extends StatefulWidget {
  final double heightUnit;
  final double widthUnit;
  final VoidCallback onClick;
  final String text;
  final Icon icon;
  final bool selected;

  const ExitCheckOption({
    Key? key,
    required this.heightUnit,
    required this.widthUnit,
    required this.onClick,
    required this.text,
    required this.icon,
    required this.selected,
  }) : super(key: key);

  @override
  _ExitCheckOptionState createState() => _ExitCheckOptionState();
}

class _ExitCheckOptionState extends State<ExitCheckOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
      height: widget.heightUnit * 80,
      width: widget.widthUnit * 330,
      decoration: BoxDecoration(
          color: widget.selected
              ? Color.fromRGBO(210, 233, 255, 1)
              : Color.fromRGBO(228, 228, 228, 1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: widget.selected ? Color.fromRGBO(0, 127, 255, 1) : Color.fromRGBO(228, 228, 228, 1),
              width: widget.selected ? 1 : 0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.widthUnit * 10,
          ),
          widget.icon,
          SizedBox(
            width: widget.widthUnit * 10,
          ),
          Text(
            widget.text,
            style: GoogleFonts.baloo2(
              fontSize: widget.heightUnit * 26,
              color: widget.selected
                  ? Color.fromRGBO(0, 127, 255, 1)
                  : Color.fromRGBO(112, 118, 124, 1),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    ),
    );
    
    
  }
}
