import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/LessonPages/Controllers/Base_Lesson_Controller.dart';

class LoadingPage extends StatefulWidget {
  final Widget destinationPage;
  final Future<void> Function()? preLoadImages;
  final bool requiresController;
  final String pageType;
  final Function initializeController;

  const LoadingPage({
    Key? key,
    required this.destinationPage,
    this.preLoadImages,
    this.requiresController = false,
    required this.pageType,
    required this.initializeController,
  }) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  double targetProgress = 0.0;
  bool _controllerDataLoaded = false;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
        CurvedAnimation(parent: _progressController, curve: Curves.easeInOut));
    _startLoading();
  }

  void _updateProgress(double newProgress) {
    setState(() {
      targetProgress = newProgress;
    });
    _progressAnimation = Tween<double>(
      begin: _progressAnimation.value,
      end: newProgress,
    ).animate(
        CurvedAnimation(parent: _progressController, curve: Curves.easeInOut));
    _progressController.forward(from: 0.0);
  }

  Future<void> _startLoading() async {
    try {
      if (widget.requiresController) {
        _updateProgress(0.1);
        final BaseLessonController controller =
            await widget.initializeController();
        _updateProgress(0.3);

        // Wait until the controller finishes loading data
        while (controller.isLoading.value) {
          await Future.delayed(Duration(milliseconds: 100));
        }

        _updateProgress(0.6);
        _controllerDataLoaded = true;
      } else {
        _updateProgress(0.6);
        _controllerDataLoaded = true;
      }

      if (widget.preLoadImages != null) {
        await widget.preLoadImages!();
        _updateProgress(0.8);
      }

      _updateProgress(0.9);
      await Future.delayed(Duration(seconds: 1));
      _updateProgress(1.0);
      await Future.delayed(Duration(milliseconds: 500));

      if (mounted && _controllerDataLoaded) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => widget.destinationPage,
          ),
        );
      }
    } catch (e) {
      print("Loading error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading lesson. Please try again.'),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: _startLoading,
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Money Monkey Logo
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMoneyMonkey.png?alt=media&token=8bc3b244-749e-49bf-a663-28664c2b4714",
              height: screenHeight * 0.5,
            ),
            SizedBox(height: screenHeight * 0.05),

            // Progress Bar Container with overflow allowed
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.15,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // Progress Bar
                  Positioned(
                    top: screenHeight * 0.06,
                    left: (screenWidth * 0.2),
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.015,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: _progressAnimation.value,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  // Monkey Icon at progress end
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return Positioned(
                        left: (screenWidth * 0.2) +
                            (screenWidth * 0.4 * _progressAnimation.value) -
                            (screenHeight * 0.04),
                        top: screenHeight * 0.02,
                        child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FMonkeys%2FMM_Silhouette.png?alt=media&token=3bf54556-da0d-446e-94c6-5a5ca59e9ce5",
                          height: screenHeight * 0.08,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.03),
            Text(
              widget.pageType == 'story'
                  ? 'Loading story...'
                  : 'Loading lesson...',
              style: TextStyle(
                fontSize: screenHeight * 0.02,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
