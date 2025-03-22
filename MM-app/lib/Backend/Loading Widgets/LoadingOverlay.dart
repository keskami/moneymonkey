import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/TeacherDashboard/Controllers/TeacherDashboardController.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  
  const LoadingOverlay({
    Key? key,
    required this.child, required bool isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TeacherDashboardController controller = Get.find<TeacherDashboardController>();
    
    return Stack(
      children: [
        // The main content
        child,
        
        // Loading overlay
        Obx(() => controller.isLoading.value 
          ? Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text(
                          'Loading data...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Fetching the latest information from Firebase',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : SizedBox.shrink()
        ),
      ],
    );
  }
}