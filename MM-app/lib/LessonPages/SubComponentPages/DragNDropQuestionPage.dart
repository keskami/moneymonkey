import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/GlobalWidgets/CustomSnackBars.dart';
import 'package:money_monkey/LessonPages/Controllers/PeerReflectionController.dart';
import 'package:money_monkey/LessonPages/Models/Models.dart';
import 'package:money_monkey/home.dart';

class DragNDropQuestionPage extends StatefulWidget {
  @override
  _DragNDropQuestionPageState createState() => _DragNDropQuestionPageState();
}

class _DragNDropQuestionPageState extends State<DragNDropQuestionPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = true;
  int? balance;
  int totalBanans = 0;
  PeerReflectioncontroller peerReflectionController = Get.find();

  List<String> availableItems = [];

  List<String> correct1 = [];
  List<String> correct2 = [];
  List<String> correct3 = [];
  List<String> droppedItems1 = [];
  List<String> droppedItems2 = [];
  List<String> droppedItems3 = [];
  bool loading = false;
  String question = '';
  String box1 = '';
  String box2 = '';
  String box3 = '';
  String subTitle = '';
  String correctFeedback = '';
  String incorrectFeedback = '';

  Future<void> setData(Question data) async {
    setState(() {
      question = data.data.title;
      box1 = data.data.categories[0].title;
      box2 = data.data.categories[1].title;
      box3 = data.data.categories[2].title;
      availableItems =
          List<String>.from(data.data.actions.map((item) => item.toString()));
      correct1 =
          List<String>.from(data.data.categories[0].correctActions.map((item) => item.toString()));
      correct2 =
          List<String>.from(data.data.categories[1].correctActions.map((item) => item.toString()));
      correct3 =
          List<String>.from(data.data.categories[2].correctActions.map((item) => item.toString()));
        
      correctFeedback = data.data.feedbackMessages["correct"];
      incorrectFeedback = data.data.feedbackMessages["incorrect"];
      subTitle = "Actions to Categorize:";

      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(133, 220, 64, 1),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    setData(peerReflectionController.pageData[2]);
  }

  // Method to handle moving an item back to available items
  void moveToAvailable(String item) {
    setState(() {
      // Remove from all drop zones
      droppedItems1.remove(item);
      droppedItems2.remove(item);
      droppedItems3.remove(item);
      
      // Add to available if not already there
      if (!availableItems.contains(item)) {
        availableItems.add(item);
      }
    });
  }

  Future<void> _checkCompletion() async {
    if (droppedItems1.length == correct1.length &&
        droppedItems1.every((element) => correct1.contains(element)) &&
        droppedItems2.length == correct2.length &&
        droppedItems2.every((element) => correct2.contains(element)) &&
        droppedItems3.length == correct3.length &&
        droppedItems3.every((element) => correct3.contains(element))) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(CorrectAnswerSnackBar(message: correctFeedback));
      await Future.delayed(Duration(seconds: 2));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      peerReflectionController.pageIndex.value += 1;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(WrongAnswerSnackBar(message: incorrectFeedback));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidthUnit = screenWidth / 390;
    double screenHeightUnit = screenHeight / 880;
    
    // Important: Consider the parent widget's padding (50% of total screen width)
    // The available width is approximately 50% of the screen width
    double availableWidth = screenWidth * 0.5;
    
    // Calculate container width to fit three containers with spacing
    double containerWidth = (availableWidth / 3) - 16;  // Width divided by 3 minus spacing

    return loading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              // Centered title
              Center(
                child: Text(
                  question,
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 6.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeightUnit * 26),
              // Using a Column instead of Row for smaller screens
              LayoutBuilder(
                builder: (context, constraints) {
                  // Check if we should use a column layout instead of row
                  bool useColumn = constraints.maxWidth < 600;
                  
                  if (useColumn) {
                    // Column layout for smaller screens
                    return Column(
                      children: [
                        _buildDropZone(droppedItems1, box1, screenWidthUnit, screenHeightUnit, 1, constraints.maxWidth * 0.9),
                        SizedBox(height: screenHeightUnit * 16),
                        _buildDropZone(droppedItems2, box2, screenWidthUnit, screenHeightUnit, 2, constraints.maxWidth * 0.9),
                        SizedBox(height: screenHeightUnit * 16),
                        _buildDropZone(droppedItems3, box3, screenWidthUnit, screenHeightUnit, 3, constraints.maxWidth * 0.9),
                      ],
                    );
                  } else {
                    // Row layout with smaller containers for larger screens
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildDropZone(droppedItems1, box1, screenWidthUnit, screenHeightUnit, 1, containerWidth),
                        SizedBox(width: 8),
                        _buildDropZone(droppedItems2, box2, screenWidthUnit, screenHeightUnit, 2, containerWidth),
                        SizedBox(width: 8),
                        _buildDropZone(droppedItems3, box3, screenWidthUnit, screenHeightUnit, 3, containerWidth),
                      ],
                    );
                  }
                }
              ),
              SizedBox(height: screenHeightUnit * 25),
              // Centered subtitle
              Center(
                child: Text(
                  subTitle,
                  style: GoogleFonts.baloo2(
                    fontSize: screenWidthUnit * 5,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: screenHeightUnit * 10),
              // Available items area - also make it a drop target
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
          
          // Remove from source if coming from another zone
          if (sourceZone == 1) droppedItems1.remove(item);
          if (sourceZone == 2) droppedItems2.remove(item);
          if (sourceZone == 3) droppedItems3.remove(item);
          
          // Remove from available items if coming from there
          availableItems.remove(item);
          
          // Add to this zone if not already there
          if (!droppedItems.contains(item)) {
            droppedItems.add(item);
          }
        });

        // Check if all items are placed
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
                    fontSize: screenWidthUnit * 4.5, // Smaller font size
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
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
                        child: _buildDraggableZoneItem(item, screenWidthUnit, zoneId, containerWidth),
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

  Widget _buildDraggableZoneItem(String label, double screenWidthUnit, int zoneId, double containerWidth) {
    return Draggable<Map<String, dynamic>>(
      // Include both the item and its source zone
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
      // For items from available section, no source zone
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

  Widget _buildItemContainer(String label, double screenWidthUnit, [double? maxWidth]) {
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