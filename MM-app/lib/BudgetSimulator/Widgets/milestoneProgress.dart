import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/BudgetSimulator/Backend/model.dart';

class MilestoneProgress extends StatefulWidget {
  final List<Milestone> milestones;
  final double screenWidthUnit;
  final double screenHeightUnit;
  final int startingDebt;
  int currentDebt;

  MilestoneProgress({
    required this.milestones,
    required this.screenWidthUnit,
    required this.screenHeightUnit,
    required this.startingDebt,
    required this.currentDebt,
    Key? key,
  }) : super(key: key);

  @override
  _MilestoneProgressState createState() => _MilestoneProgressState();
}

class _MilestoneProgressState extends State<MilestoneProgress> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: widget.screenHeightUnit * 12.5,
          ),
          child: Container(
            width: widget.screenWidthUnit * 470,
            height: widget.screenHeightUnit * 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Colors.black, width: .6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: widget.screenHeightUnit * 10,
                    left: widget.screenWidthUnit * 27,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Progress",
                        style: GoogleFonts.baloo2(
                          fontSize: widget.screenWidthUnit * 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        width: widget.screenWidthUnit * 290,
                        child: Text(
                          "${(((widget.startingDebt - widget.currentDebt) * 2) / widget.startingDebt * 100).clamp(0, 100).toStringAsFixed(0)}% Completed",
                          style: GoogleFonts.baloo2(
                            fontSize: widget.screenWidthUnit * 28,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(103, 103, 103, 1),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: widget.screenHeightUnit * 12),
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            width: widget.screenWidthUnit * 420,
                            height: widget.screenHeightUnit * 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(216, 216, 216, 1),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: ((1.8 *
                                        ((widget.startingDebt -
                                            widget.currentDebt)) /
                                        widget.startingDebt *
                                        100) /
                                    100)
                                .clamp(0, .9),
                            child: Container(
                              height: widget.screenHeightUnit * 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromRGBO(30, 213, 58, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    top: widget.screenHeightUnit * 15,
                  ),
                  child: Container(
                    height: widget.screenHeightUnit * 1,
                    width: widget.screenWidthUnit * 470,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: widget.screenHeightUnit * 2,
                      left: widget.screenWidthUnit * 0),
                  child: Container(
                    height: widget.screenHeightUnit * 260,
                    width: widget.screenWidthUnit * 470,
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: widget.screenWidthUnit * 27,
                          bottom: widget.screenHeightUnit * 10),
                      child: Column(
                        children: widget.milestones.map((milestone) {
                          return MilestoneSubWidget(
                              milestone: milestone,
                              screenHeightUnit: widget.screenHeightUnit,
                              screenWidthUnit: widget.screenWidthUnit);
                        }).toList(),
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MilestoneSubWidget extends StatefulWidget {
  final Milestone milestone;
  final double screenHeightUnit;
  final double screenWidthUnit;

  const MilestoneSubWidget({
    required this.milestone,
    required this.screenHeightUnit,
    required this.screenWidthUnit,
    Key? key,
  }) : super(key: key);

  @override
  _MilestoneSubWidgetState createState() => _MilestoneSubWidgetState();
}

class _MilestoneSubWidgetState extends State<MilestoneSubWidget> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.screenHeightUnit * 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: widget.screenWidthUnit * 36,
            height: widget.screenWidthUnit * 36,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CircularProgressIndicator(
                    value: (widget.milestone.currentAmount /
                        widget.milestone.goalAmount),
                    backgroundColor: Color.fromRGBO(216, 216, 216, 1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(30, 213, 58, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: widget.screenWidthUnit * 28),
            child: isClicked
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.milestone.name,
                        style: GoogleFonts.baloo2(
                          fontSize: widget.screenWidthUnit * 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.milestone.description,
                        style: GoogleFonts.baloo2(
                          fontSize: widget.screenWidthUnit * 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                : Text(
                    widget.milestone.name,
                    style: GoogleFonts.baloo2(
                      fontSize: widget.screenWidthUnit * 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: widget.screenWidthUnit * 16),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    isClicked = !isClicked;
                  });
                },
                child: isClicked
                    ? Icon(
                        Icons.arrow_forward_ios,
                        size: widget.screenHeightUnit * 24,
                      )
                    : Transform.rotate(
                        angle: 1.5708,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: widget.screenHeightUnit * 24,
                        ),
                      )),
          )
        ],
      ),
    );
  }
}
