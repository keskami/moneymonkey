import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';
import 'package:intl/intl.dart';

class EventHistory extends StatefulWidget {
  final List<RandomEventTaken> eventsTaken;
  final double screenHeightUnit;
  final double screenWidthUnit;

  const EventHistory(
      {Key? key,
      required this.eventsTaken,
      required this.screenHeightUnit,
      required this.screenWidthUnit})
      : super(key: key);

  @override
  _EventHistoryState createState() => _EventHistoryState();
}

class _EventHistoryState extends State<EventHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidthUnit * 517,
      height: widget.screenHeightUnit * 540,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: widget.screenHeightUnit * 24,
                left: widget.screenWidthUnit * 32),
            child: Text(
              "Event History",
              style: GoogleFonts.baloo2(
                  fontSize: widget.screenWidthUnit * 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: widget.screenHeightUnit * 24,
                  left: widget.screenWidthUnit * 32),
              child: Container(
                width: widget.screenWidthUnit * 428,
                height: widget.screenHeightUnit * 400,
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.eventsTaken
                        .map((event) => RandomEventHistoryDropdown(
                              eventTaken: event,
                              screenHeightUnit: widget.screenHeightUnit,
                              screenWidthUnit: widget.screenWidthUnit,
                            ))
                        .toList(),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class RandomEventHistoryDropdown extends StatefulWidget {
  final RandomEventTaken eventTaken;
  final double screenHeightUnit;
  final double screenWidthUnit;

  const RandomEventHistoryDropdown(
      {Key? key,
      required this.eventTaken,
      required this.screenHeightUnit,
      required this.screenWidthUnit})
      : super(key: key);

  @override
  _RandomEventHistoryDropdownState createState() =>
      _RandomEventHistoryDropdownState();
}

class _RandomEventHistoryDropdownState
    extends State<RandomEventHistoryDropdown> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.screenHeightUnit * 20),
      child: Container(
        height: clicked
            ? widget.screenHeightUnit * 210
            : widget.screenHeightUnit * 50,
        width: widget.screenWidthUnit * 428,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateFormat.MMMM().format(widget.eventTaken.trigerDay)} ${widget.eventTaken.trigerDay.day}, ${widget.eventTaken.trigerDay.year}',
                  style: GoogleFonts.baloo2(
                      fontSize: widget.screenHeightUnit * 32,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(108, 108, 108, 1)),
                ),
                SizedBox(
                  width: widget.screenWidthUnit * 28,
                ),
                Text(
                  "${widget.eventTaken.name}",
                  style: GoogleFonts.baloo2(
                      fontSize: widget.screenHeightUnit * 32,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      clicked = !clicked;
                    });
                  },
                  child: Icon(
                    clicked ? Icons.chevron_right : Icons.expand_more,
                    color: Colors.black,
                    size: widget.screenHeightUnit * 50,
                  ),
                ),
              ],
            ),
            clicked
                ? Container(
                    width: widget.screenWidthUnit * 428,
                    height: widget.screenHeightUnit * 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: widget.screenHeightUnit * 10,
                          horizontal: widget.screenWidthUnit * 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.eventTaken.choiceTaken}",
                                style: GoogleFonts.baloo2(
                                    fontSize: widget.screenHeightUnit * 26,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Spacer(),
                              widget.eventTaken.moneyEffect == 0
                                  ? Text(
                                      "",
                                      style: GoogleFonts.baloo2(
                                          fontSize:
                                              widget.screenHeightUnit * 26,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    )
                                  : widget.eventTaken.moneyEffect > 0
                                      ? Text(
                                          "\$${widget.eventTaken.moneyEffect}",
                                          style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 26,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  0, 199, 129, 1)),
                                        )
                                      : Text(
                                          "-\$${(widget.eventTaken.moneyEffect).abs()}",
                                          style: GoogleFonts.baloo2(
                                              fontSize:
                                                  widget.screenHeightUnit * 26,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Color.fromRGBO(255, 0, 0, 1)),
                                        ),
                            ],
                          ),
                          Text(
                            "${widget.eventTaken.discription}",
                            style: GoogleFonts.baloo2(
                                fontSize: widget.screenHeightUnit * 26,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(108, 108, 108, 1)),
                          ),
                          SizedBox(
                            height: widget.screenHeightUnit * 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: widget.screenHeightUnit * 40,
                                child: IntrinsicWidth(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: widget.eventTaken.effect1Amount >
                                                0
                                            ? Color.fromRGBO(242, 255, 245, .7)
                                            : Color.fromRGBO(255, 243, 243, 1),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 1,
                                          color: widget.eventTaken
                                                      .effect1Amount >
                                                  0
                                              ? Color.fromRGBO(0, 199, 129, 1)
                                              : Color.fromRGBO(255, 0, 0, 1),
                                        )),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: widget.screenWidthUnit * 18),
                                        Text(
                                          '${widget.eventTaken.effect1}: ',
                                          style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 22,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          '${widget.eventTaken.effect1Amount}',
                                          style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 22,
                                            fontWeight: FontWeight.w500,
                                            color: widget.eventTaken
                                                        .effect1Amount >
                                                    0
                                                ? Color.fromRGBO(0, 199, 129, 1)
                                                : Color.fromRGBO(255, 0, 0, 1),
                                          ),
                                        ),
                                        SizedBox(
                                            width: widget.screenWidthUnit * 18),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: widget.screenWidthUnit * 11,
                              ),
                              SizedBox(
                                height: widget.screenHeightUnit * 40,
                                child: IntrinsicWidth(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: widget.eventTaken.effect2Amount >
                                                0
                                            ? Color.fromRGBO(242, 255, 245, .7)
                                            : Color.fromRGBO(255, 243, 243, 1),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 1,
                                          color: widget.eventTaken
                                                      .effect2Amount >
                                                  0
                                              ? Color.fromRGBO(30, 213, 58, 1)
                                              : Color.fromRGBO(243, 52, 52, 1),
                                        )),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: widget.screenWidthUnit * 18),
                                        Text(
                                          '${widget.eventTaken.effect2}: ',
                                          style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 22,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          '${widget.eventTaken.effect2Amount}',
                                          style: GoogleFonts.baloo2(
                                            fontSize:
                                                widget.screenHeightUnit * 22,
                                            fontWeight: FontWeight.w500,
                                            color: widget.eventTaken
                                                        .effect2Amount >
                                                    0
                                                ? Color.fromRGBO(30, 213, 58, 1)
                                                : Color.fromRGBO(
                                                    243, 52, 52, 1),
                                          ),
                                        ),
                                        SizedBox(
                                            width: widget.screenWidthUnit * 18),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                : Container()
          ],
        ),
      ),
    );
  }
}
