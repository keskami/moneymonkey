import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:moneymonkey/controller/controller.dart';

class LessonCompleteScreen extends StatefulWidget {
  @override
  _LessonCompleteScreenState createState() => _LessonCompleteScreenState();
}

class _LessonCompleteScreenState extends State<LessonCompleteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late ConfettiController _confettiController;
  bool _bananaClicked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _onBananaTap() {
    setState(() {
      _bananaClicked = true;
    });
    _controller.forward();
    _confettiController.play();
  }

  void _onScreenTap() {
    if (_bananaClicked) {
      setState(() {
        _bananaClicked = false;
      });
      _controller.reset();
      _confettiController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the progress controller to get the number of attempts
    final ProgressController progressController = Get.find<ProgressController>();
    
    
    // Determine how many stars based on the number of attempts
    int stars = progressController.attempts.value == 1 ? 3 : 2;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: _onScreenTap, // Detect tap anywhere on the screen
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 0,
                          child: Image.asset(
                            'assets/images/hang.png',
                            height: 598,
                            width: 598,
                            fit: BoxFit.contain,
                          ),
                        ),
                        // Display stars based on attempts
                        Positioned(
                          top: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(stars, (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Image.asset(
                                  'assets/images/star.png',
                                  height: 60,
                                ),
                              );
                            }),
                          ),
                        ),
                        Positioned(
                          top: 60,
                          child: Text(
                            "Lesson\n Complete!",
                            style: TextStyle(
                              fontFamily: "Baloo 2",
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Positioned(     
                          bottom: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed("/HomePage");
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 12,
                              ),
                              backgroundColor: Color(0xFF87CEEB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'CONTINUE',
                              style: TextStyle(
                                fontFamily: "Baloo 2",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _onBananaTap,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green, width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Image.asset(
                                'assets/images/bigbanana.png',
                                height: 90,
                              ),
                            ),
                            SizedBox(height: 0),
                            if (_bananaClicked)
                              Text(
                                "+10 Bananas!",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          // Add action for treasure chest
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/images/bigtreasure.png',
                            height: 90,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_bananaClicked)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              // Confetti animation
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: [Colors.yellow, Colors.orange, Colors.green],
                  numberOfParticles: 30,
                ),
              ),
              if (_bananaClicked)
                Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Lottie.asset(
                      'assets/images/specsbanana.json', // Add your Lottie file path
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
