import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';
 
class DragNDropQuestionPage extends StatefulWidget {
  final String question;
  final String box1;
  final String box2;
  final String box3;
  final List<String> availableItems;
  final List<String> correct1;
  final List<String> correct2;
  final List<String> correct3;
  final String correctFeedback;
  final String incorrectFeedback;
  final String subTitle;

  const DragNDropQuestionPage({
    super.key,
    required this.question,
    required this.box1,
    required this.box2,
    required this.box3,
    required this.availableItems,
    required this.correct1,
    required this.correct2,
    required this.correct3,
    required this.correctFeedback,
    required this.incorrectFeedback,
    required this.subTitle,
  });

  @override
  _DragNDropQuestionPageState createState() => _DragNDropQuestionPageState();
}

class _DragNDropQuestionPageState extends State<DragNDropQuestionPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  final BaseLessonController baseLessonController = Get.find();

  // Local data
  List<String> droppedItems1 = [];
  List<String> droppedItems2 = [];
  List<String> droppedItems3 = [];
  late List<String> availableItems; // We'll copy from widget in initState

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(133, 220, 64, 1),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    // Initialize the available items from the widget
    availableItems = List<String>.from(widget.availableItems);
  }

  /// Move an item back to the "available" list
  void moveToAvailable(String item) {
    setState(() {
      droppedItems1.remove(item);
      droppedItems2.remove(item);
      droppedItems3.remove(item);
      if (!availableItems.contains(item)) {
        availableItems.add(item);
      }
    });
  }

  /// Check if all items are placed correctly
  Future<void> _checkCompletion() async {
    // Must match exactly in length and membership
    if (droppedItems1.length == widget.correct1.length &&
        droppedItems1.every(widget.correct1.contains) &&
        droppedItems2.length == widget.correct2.length &&
        droppedItems2.every(widget.correct2.contains) &&
        droppedItems3.length == widget.correct3.length &&
        droppedItems3.every(widget.correct3.contains)) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        CorrectAnswerSnackBar(message: widget.correctFeedback),
      );
      await Future.delayed(Duration(seconds: 2));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      baseLessonController.pageIndex.value += 1;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        WrongAnswerSnackBar(message: widget.incorrectFeedback),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;

    double availableWidth = screenWidth * 0.5;
    double containerWidth = (availableWidth / 3) - 16;

    return Column(
      children: [
        Center(
          child: Text(
            widget.question,
            style: GoogleFonts.baloo2(
              fontSize: screenWidthUnit * 6.5,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: screenHeightUnit * 26),
        // LayoutBuilder for row/column logic
        LayoutBuilder(
          builder: (context, constraints) {
            bool useColumn = constraints.maxWidth < 600;
            if (useColumn) {
              // Column layout
              return Column(
                children: [
                  _buildDropZone(
                    droppedItems1,
                    widget.box1,
                    screenWidthUnit,
                    screenHeightUnit,
                    1,
                    constraints.maxWidth * 0.9,
                  ),
                  SizedBox(height: screenHeightUnit * 16),
                  _buildDropZone(
                    droppedItems2,
                    widget.box2,
                    screenWidthUnit,
                    screenHeightUnit,
                    2,
                    constraints.maxWidth * 0.9,
                  ),
                  SizedBox(height: screenHeightUnit * 16),
                  _buildDropZone(
                    droppedItems3,
                    widget.box3,
                    screenWidthUnit,
                    screenHeightUnit,
                    3,
                    constraints.maxWidth * 0.9,
                  ),
                ],
              );
            } else {
              // Row layout
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDropZone(
                    droppedItems1,
                    widget.box1,
                    screenWidthUnit,
                    screenHeightUnit,
                    1,
                    containerWidth,
                  ),
                  SizedBox(width: 8),
                  _buildDropZone(
                    droppedItems2,
                    widget.box2,
                    screenWidthUnit,
                    screenHeightUnit,
                    2,
                    containerWidth,
                  ),
                  SizedBox(width: 8),
                  _buildDropZone(
                    droppedItems3,
                    widget.box3,
                    screenWidthUnit,
                    screenHeightUnit,
                    3,
                    containerWidth,
                  ),
                ],
              );
            }
          },
        ),
        SizedBox(height: screenHeightUnit * 25),
        Center(
          child: Text(
            widget.subTitle,
            style: GoogleFonts.baloo2(
              fontSize: screenWidthUnit * 5,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: screenHeightUnit * 10),
        // DragTarget for the "available items" area
        DragTarget<Map<String, dynamic>>(
          onAccept: (data) {
            moveToAvailable(data['item']);
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              height: screenHeightUnit * 152,
              width: availableWidth,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: candidateData.isNotEmpty
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: availableItems.map((item) {
                    return _buildDraggableItem(item, screenWidthUnit);
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDropZone(
    List<String> droppedItems,
    String label,
    double screenWidthUnit,
    double screenHeightUnit,
    int zoneId,
    double containerWidth,
  ) {
    return DragTarget<Map<String, dynamic>>(
      onAccept: (data) {
        setState(() {
          String item = data['item'];
          int sourceZone = data['sourceZone'] ?? 0;
          if (sourceZone == 1) droppedItems1.remove(item);
          if (sourceZone == 2) droppedItems2.remove(item);
          if (sourceZone == 3) droppedItems3.remove(item);
          availableItems.remove(item);
          if (!droppedItems.contains(item)) {
            droppedItems.add(item);
          }
        });
        // If no more items left, check correctness
        if (availableItems.isEmpty) {
          _checkCompletion();
        }
      },
      onWillAccept: (data) => true,
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: containerWidth,
          height: screenHeightUnit * 428,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: candidateData.isNotEmpty
                ? Colors.grey.withOpacity(0.3)
                : Colors.grey[200],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  label,
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 4.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: droppedItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: _buildDraggableZoneItem(
                          item, screenWidthUnit, zoneId, containerWidth,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDraggableZoneItem(
      String label, double screenWidthUnit, int zoneId, double containerWidth) {
    return Draggable<Map<String, dynamic>>(
      data: {'item': label, 'sourceZone': zoneId},
      feedback: Material(
        color: Colors.transparent,
        elevation: 4.0,
        child: Container(
          width: containerWidth - 16,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: screenWidthUnit * 3.6),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildItemContainer(label, screenWidthUnit, containerWidth),
      ),
      child: _buildItemContainer(label, screenWidthUnit, containerWidth),
    );
  }

  Widget _buildDraggableItem(String label, double screenWidthUnit) {
    return Draggable<Map<String, dynamic>>(
      data: {'item': label, 'sourceZone': 0},
      feedback: Material(
        color: Colors.transparent,
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: screenWidthUnit * 3.6),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildItemContainer(label, screenWidthUnit),
      ),
      child: _buildItemContainer(label, screenWidthUnit),
    );
  }

  Widget _buildItemContainer(String label, double screenWidthUnit,
      [double? maxWidth]) {
    return Container(
      padding: EdgeInsets.all(8),
      constraints: maxWidth != null
          ? BoxConstraints(maxWidth: maxWidth - 16)
          : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: screenWidthUnit * 3.6),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
