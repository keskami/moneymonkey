import 'package:flutter/material.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Services/DirectFirebaseService.dart';
import 'package:money_monkey/LessonPages/Pages/LoadingScreen/loading_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonsHomeUnit extends StatefulWidget {
  final List<Lesson> lessons;

  const LessonsHomeUnit({
    Key? key,
    required this.lessons,
  }) : super(key: key);

  @override
  State<LessonsHomeUnit> createState() => _LessonsHomeUnitState();
}

class _LessonsHomeUnitState extends State<LessonsHomeUnit> {
  late List<Future<List<Widget>>> _pageFutures;

  @override
  void initState() {
    super.initState();
    _pageFutures = widget.lessons.map((lesson) => _getPages(lesson.components)).toList();
  }

  @override
  void didUpdateWidget(LessonsHomeUnit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lessons != widget.lessons) {
      _pageFutures = widget.lessons.map((lesson) => _getPages(lesson.components)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double heightUnit = screenHeight / 1342;
    double widthUnit = screenWidth / 1920;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.lessons.length,
      itemBuilder: (context, index) {
        final lesson = widget.lessons[index];
        return FutureBuilder<List<Widget>>(
          future: _pageFutures[index],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final pageLinks = snapshot.data ?? [];
            return LessonHomeUnit_NewUI(
              heightUnit: heightUnit,
              widthUnit: widthUnit,
              currentIndex: 4, // TODO: Replace with actual lesson progress logic
              pageLinks: pageLinks,
              lesson: lesson,
            );
          },
        );
      },
    );
  }

  Future<List<Widget>> _getPages(List<String> componentIds) async {
    final List<Widget> pagesLink = [];
    if (componentIds.isEmpty) {
      return pagesLink;
    }
    final _firebaseService = DirectFirebaseService();
    for (String componentId in componentIds) {
      try {
        final component = await _firebaseService.getComponent(componentId);
        pagesLink.add(LoadingPageWrapper(type: component.type, componentId: componentId));
      } catch (e) {
        print("Error fetching component $componentId: $e");
        pagesLink.add(Container());
      }
    }
    return pagesLink;
  }
}

// -------- Merged NewUI Classes --------
// UI for individual lesson parts with zigzag layout and connectors
class LessonHomeUnit_NewUI extends StatelessWidget {
  final double heightUnit;
  final double widthUnit;
  final int currentIndex;
  final List<Widget> pageLinks;
  final dynamic lesson;

  LessonHomeUnit_NewUI({
    Key? key,
    required this.heightUnit,
    required this.widthUnit,
    required this.currentIndex,
    required this.pageLinks,
    required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double baseY = heightUnit * 320;
    final double spacingVal = heightUnit * 215;
    final double boxH = heightUnit * 137;
    final double totalHeight = baseY + spacingVal * (pageLinks.length - 1) + boxH;
    return Container(
      width: widthUnit * 1500,
      height: totalHeight,
      child: Align(
        alignment: Alignment.centerLeft,
        child: CustomPaint(
          size: Size(widthUnit * 900, totalHeight),
          painter: BoxConnectorPainter(
            currentIndex: currentIndex,
            heightUnit: heightUnit,
            widthUnit: widthUnit,
            itemCount: pageLinks.length,
          ),
          child: Stack(
            children: List.generate(pageLinks.length, (index) {
              final link = pageLinks[index];
              final double left = (index % 4 == 1)
                  ? widthUnit * 100
                  : (index % 4 == 3)
                      ? widthUnit * 500
                      : widthUnit * 300;
              final double top = baseY + spacingVal * index;
              return Positioned(
                top: top,
                left: left,
                child: _buildLessonBox(
                  context,
                  title: 'Lesson Part ${index + 1}',
                  subtitle: lesson.title ?? '',
                  isUnlocked: currentIndex > index,
                  isCurrent: currentIndex == index,
                  heightUnit: heightUnit,
                  widthUnit: widthUnit,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => link),
                    );
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildLessonBox(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isUnlocked,
    required bool isCurrent,
    required double heightUnit,
    required double widthUnit,
    required VoidCallback onTap,
  }) {
    return Container(
      width: widthUnit * 287,
      height: heightUnit * 137,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: isUnlocked
                ? Color.fromRGBO(25, 160, 18, 1)
                : Color.fromRGBO(135, 206, 235, 1),
            width: 1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: widthUnit * 15, top: heightUnit * 10, right: widthUnit * 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.baloo2(
                    fontSize: heightUnit * 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  isUnlocked ? Icons.check_circle : Icons.lock,
                  color: isUnlocked
                      ? Color.fromRGBO(25, 160, 18, 1)
                      : !isCurrent
                          ? Color.fromRGBO(53, 47, 47, 1)
                          : Color.fromRGBO(135, 206, 235, 1),
                  size: isCurrent ? heightUnit * .01 : heightUnit * 30,
                ),
              ],
            ),
            Text(
              subtitle,
              style: GoogleFonts.baloo2(
                fontSize: heightUnit * 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Center(
                child: Container(
                  width: widthUnit * 257,
                  height: heightUnit * 43,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black, width: .6),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isUnlocked
                            ? Text(
                                "Review",
                                style: GoogleFonts.baloo2(
                                  fontSize: heightUnit * 27,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              )
                            : Row(
                                children: [
                                  Text(
                                    "Start (+10 ",
                                    style: GoogleFonts.baloo2(
                                      fontSize: heightUnit * 21,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/img_monkeymoney_52.png',
                                    height: heightUnit * 22,
                                  ),
                                  Text(
                                    ")",
                                    style: GoogleFonts.baloo2(
                                      fontSize: heightUnit * 21,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(width: isUnlocked ? widthUnit * 3 : 0),
                        if (isUnlocked)
                          Icon(Icons.refresh, size: heightUnit * 27, color: Colors.black)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BoxConnectorPainter extends CustomPainter {
  final int currentIndex;
  final double heightUnit;
  final double widthUnit;
  final int itemCount;

  BoxConnectorPainter({
    required this.currentIndex,
    required this.heightUnit,
    required this.widthUnit,
    required this.itemCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double boxW = widthUnit * 287;
    final double boxH = heightUnit * 137;
    final double halfW = boxW / 2;
    final double halfH = boxH / 2;
    final double baseY = heightUnit * 320;
    final double spacing = heightUnit * 215;
    final paintDone = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Color.fromRGBO(25, 160, 18, 1);
    final paintPending = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Color.fromRGBO(178, 182, 182, 1);
    // Loop through all page links to draw connector lines dynamically
    for (int i = 0; i < itemCount - 1; i++) {
      double x1;
      switch (i % 4) {
        case 1:
          x1 = widthUnit * 100;
          break;
        case 3:
          x1 = widthUnit * 500;
          break;
        default:
          x1 = widthUnit * 300;
      }
      double x2;
      switch ((i + 1) % 4) {
        case 1:
          x2 = widthUnit * 100;
          break;
        case 3:
          x2 = widthUnit * 500;
          break;
        default:
          x2 = widthUnit * 300;
      }
      final start = Offset(x1 + halfW, baseY + spacing * i + halfH);
      final end = Offset(x2 + halfW, baseY + spacing * (i + 1) + halfH);
      // Use done style for completed links, pending otherwise
      final paint = (i < currentIndex - 1) ? paintDone : paintPending;
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant BoxConnectorPainter old) {
    return old.currentIndex != currentIndex || old.itemCount != itemCount;
  }
}