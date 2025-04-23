import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/LessonPages/NewPages/5Pages/exitCheck.dart';
import 'package:money_monkey/LessonPages/NewPages/5Pages/reflect.dart';

class NewLessonHomeUnit extends StatelessWidget {
  final double heightUnit;
  final double widthUnit;
  final int currentIndex; 

  NewLessonHomeUnit({
    Key? key,
    required this.heightUnit,
    required this.widthUnit,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widthUnit * 1500,
        height: heightUnit * 1400,
        child: Align(
          alignment: Alignment.centerLeft,
          child: CustomPaint(
            size: Size(widthUnit * 900, heightUnit * 1000),
            painter: BoxConnectorPainter(currentIndex: currentIndex),
            child: Stack(
              children: [
                Positioned(
                  top: heightUnit * 320,
                  left: widthUnit * 300,
                  child: Container(
                    width: widthUnit * 287,
                    height: heightUnit * 137,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: currentIndex > 0
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
                      padding: EdgeInsets.only(
                          left: widthUnit * 15,
                          top: heightUnit * 10,
                          right: widthUnit * 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Reflection",
                                style: GoogleFonts.baloo2(
                                  fontSize: heightUnit * 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                  currentIndex > 0
                                      ? Icons.check_circle
                                      : Icons.lock,
                                  color: currentIndex > 0
                                      ? Color.fromRGBO(25, 160, 18, 1)
                                      : currentIndex != 0
                                          ? Color.fromRGBO(53, 47, 47, 1)
                                          : Color.fromRGBO(135, 206, 235, 1),
                                  size: currentIndex == 0
                                      ? heightUnit * .01
                                      : heightUnit * 30),
                            ],
                          ),
                         
                          Text("Money Emotions & Personal Values",
                              style: GoogleFonts.baloo2(
                                fontSize: heightUnit * 16,
                                fontWeight: FontWeight.w500,
                              )),

                              GestureDetector(onTap: (){}, child: Center(
                                child: Container(
                                  width: widthUnit * 257,
                                  height: heightUnit * 43,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: .6
                                    )
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        currentIndex <= 0 ?
                                        Row(
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
                                        ) :  Text(
                                          "Review",
                                          style: GoogleFonts.baloo2(
                                            fontSize: heightUnit * 27,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                    SizedBox(width: currentIndex <= 0 ? 0 : widthUnit * 3),

                                    currentIndex <= 0 ? Container(): Icon(Icons.refresh, size: heightUnit * 27, color: Colors.black,)



                                      ],
                                    )
                                    
                                    
                                ),
                              )),
                              
                              )

                              
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: heightUnit * (330 + 205),
                  left: widthUnit * 100,
                  child: Container(
                    width: widthUnit * 287,
                    height: heightUnit * 137,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: currentIndex > 1
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
                      padding: EdgeInsets.only(
                          left: widthUnit * 15,
                          top: heightUnit * 10,
                          right: widthUnit * 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Kickoff",
                                style: GoogleFonts.baloo2(
                                  fontSize: heightUnit * 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                  currentIndex > 1
                                      ? Icons.check_circle
                                      : Icons.lock,
                                  color: currentIndex > 1
                                      ? Color.fromRGBO(25, 160, 18, 1)
                                      : currentIndex != 1
                                          ? Color.fromRGBO(53, 47, 47, 1)
                                          : Color.fromRGBO(135, 206, 235, 1),
                                  size: currentIndex == 1
                                      ? heightUnit * .01
                                      : heightUnit * 30),
                            ],
                          ),
                         
                          Text("Money Emotions & Personal Values",
                              style: GoogleFonts.baloo2(
                                fontSize: heightUnit * 16,
                                fontWeight: FontWeight.w500,
                              )),

                              GestureDetector(onTap: (){}, child: Center(
                                child: Container(
                                  width: widthUnit * 257,
                                  height: heightUnit * 43,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: .6
                                    )
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        currentIndex <= 1 ?
                                        Row(
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
                                        ) :  Text(
                                      "Review",
                                      style: GoogleFonts.baloo2(
                                        fontSize: heightUnit * 27,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: currentIndex <= 1 ? 1 : widthUnit * 3),

                                    currentIndex <= 1 ? Container(): Icon(Icons.refresh, size: heightUnit * 27, color: Colors.black,)



                                      ],
                                    )
                                    
                                    
                                ),
                              )),
                              
                              )

                              
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: heightUnit * (330 + 420),
                  left: widthUnit * 300,
                  child: Container(
                    width: widthUnit * 287,
                    height: heightUnit * 137,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: currentIndex > 2
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
                      padding: EdgeInsets.only(
                          left: widthUnit * 15,
                          top: heightUnit * 10,
                          right: widthUnit * 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Kickoff",
                                style: GoogleFonts.baloo2(
                                  fontSize: heightUnit * 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                  currentIndex > 2
                                      ? Icons.check_circle
                                      : Icons.lock,
                                  color: currentIndex > 2
                                      ? Color.fromRGBO(25, 160, 18, 1)
                                      : currentIndex != 2
                                          ? Color.fromRGBO(53, 47, 47, 1)
                                          : Color.fromRGBO(135, 206, 235, 1),
                                  size: currentIndex == 2
                                      ? heightUnit * .01
                                      : heightUnit * 30),
                            ],
                          ),
                         
                          Text("Money Emotions & Personal Values",
                              style: GoogleFonts.baloo2(
                                fontSize: heightUnit * 16,
                                fontWeight: FontWeight.w500,
                              )),

                              GestureDetector(onTap: (){}, child: Center(
                                child: Container(
                                  width: widthUnit * 257,
                                  height: heightUnit * 43,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: .6
                                    )
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        currentIndex <= 2 ?
                                        Row(
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
                                        ) :  Text(
                                      "Review",
                                      style: GoogleFonts.baloo2(
                                        fontSize: heightUnit * 27,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: currentIndex <= 2 ? 0 : widthUnit * 3),

                                    currentIndex <= 2 ? Container(): Icon(Icons.refresh, size: heightUnit * 27, color: Colors.black,)



                                      ],
                                    )
                                    
                                    
                                ),
                              )),
                              
                              )

                              
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                   top: heightUnit * (330 + 490 + 135),
                  left: widthUnit * 500,
                 
                  child: Container(
                    width: widthUnit * 287,
                    height: heightUnit * 137,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: currentIndex > 2
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
                      padding: EdgeInsets.only(
                          left: widthUnit * 15,
                          top: heightUnit * 10,
                          right: widthUnit * 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Exit Check",
                                style: GoogleFonts.baloo2(
                                  fontSize: heightUnit * 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                  currentIndex > 3
                                      ? Icons.check_circle
                                      : Icons.lock,
                                  color: currentIndex > 3
                                      ? Color.fromRGBO(25, 160, 18, 1)
                                      : currentIndex != 3
                                          ? Color.fromRGBO(53, 47, 47, 1)
                                          : Color.fromRGBO(135, 206, 235, 1),
                                  size: currentIndex == 3
                                      ? heightUnit * .01
                                      : heightUnit * 30),
                            ],
                          ),
                         
                          Text("Values-Money Connection Quiz",
                              style: GoogleFonts.baloo2(
                                fontSize: heightUnit * 16,
                                fontWeight: FontWeight.w500,
                              )),

                              GestureDetector(onTap: (){
                                if(currentIndex >= 3){
                                   Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ExitCheck(heightUnit: heightUnit, widthUnit: widthUnit), 
                                  ),
                                );

                                }
                               
                              }, child: Center(
                                child: Container(
                                  width: widthUnit * 257,
                                  height: heightUnit * 43,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: .6
                                    )
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        currentIndex <= 3 ?
                                        Row(
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
                                        ) :  Text(
                                      "Review",
                                      style: GoogleFonts.baloo2(
                                        fontSize: heightUnit * 27,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: currentIndex <= 3 ? 0 : widthUnit * 3),

                                    currentIndex <= 3 ? Container(): Icon(Icons.refresh, size: heightUnit * 27, color: Colors.black,)



                                      ],
                                    )
                                    
                                    
                                ),
                              )),
                              
                              )

                              
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                   top: heightUnit * (330 + 490 + 245 + 105),
                  left: widthUnit * 300,
                  child: Container(
                    width: widthUnit * 287,
                    height: heightUnit * 137,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: currentIndex > 4
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
                      padding: EdgeInsets.only(
                          left: widthUnit * 15,
                          top: heightUnit * 10,
                          right: widthUnit * 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Kickoff",
                                style: GoogleFonts.baloo2(
                                  fontSize: heightUnit * 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                  currentIndex > 4
                                      ? Icons.check_circle
                                      : Icons.lock,
                                  color: currentIndex > 4
                                      ? Color.fromRGBO(25, 160, 18, 1)
                                      : currentIndex != 4
                                          ? Color.fromRGBO(53, 47, 47, 1)
                                          : Color.fromRGBO(135, 206, 235, 1),
                                  size: currentIndex == 4
                                      ? heightUnit * .01
                                      : heightUnit * 30),
                            ],
                          ),
                         
                          Text("Money Emotions & Personal Values",
                              style: GoogleFonts.baloo2(
                                fontSize: heightUnit * 16,
                                fontWeight: FontWeight.w500,
                              )),

                              GestureDetector(onTap: (){
                                if(currentIndex >= 4){
                                   Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Reflection(heightUnit: heightUnit, widthUnit: widthUnit), 
                                  ),
                                );

                                }
                              }, child: Center(
                                child: Container(
                                  width: widthUnit * 257,
                                  height: heightUnit * 43,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: .6
                                    )
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        currentIndex <= 4 ?
                                        Row(
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
                                        ) :  Text(
                                      "Review",
                                      style: GoogleFonts.baloo2(
                                        fontSize: heightUnit * 27,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: currentIndex <= 4 ? 0 : widthUnit * 3),

                                    currentIndex <= 4 ? Container(): Icon(Icons.refresh, size: heightUnit * 27, color: Colors.black,)



                                      ],
                                    )
                                    
                                    
                                ),
                              )),
                              
                              )

                              
                        ],
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ));
  }
}

class BoxConnectorPainter extends CustomPainter {
  final int currentIndex;

  // Constructor that requires the current index
  BoxConnectorPainter({required this.currentIndex});

  @override
  void paint(Canvas canvas, Size size) {
    // Define line segments
    final List<Map<String, Offset>> lineSegments = [
      {
        'start': Offset(size.width * 0.201, size.height * 0.319),
        'end': Offset(size.width * 0.155, size.height * 0.39),
      },
      {
        'start': Offset(size.width * 0.153, size.height * 0.462),
        'end': Offset(size.width * 0.201, size.height * 0.56),
      },
      {
        'start': Offset(size.width * 0.355, size.height * 0.62),
        'end': Offset(size.width * 0.4375, size.height * 0.69),
      },
      {
        'start': Offset(size.width * 0.4475, size.height * 0.77),
        'end': Offset(size.width * 0.39, size.height * 0.885),
      },
    ];

    final Color completedColor =
        Color.fromRGBO(25, 160, 18, 1); // For completed segments
    final Color incompleteColor =
        Color.fromRGBO(178, 182, 182, 1); // For future segments

    // Draw each line segment with appropriate color based on index
    for (int i = 0; i < lineSegments.length; i++) {
      Paint paint = Paint()
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;

      if (i < currentIndex) {
        // Segments before current index (completed)
        paint.color = completedColor;
      } else {
        // Future segments
        paint.color = incompleteColor;
      }

      // Draw the line with the appropriate color
      canvas.drawLine(
        lineSegments[i]['start']!,
        lineSegments[i]['end']!,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Repaint when the currentIndex changes
    return true;
  }
}