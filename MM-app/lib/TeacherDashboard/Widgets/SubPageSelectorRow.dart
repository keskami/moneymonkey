import 'package:flutter/material.dart';

class DashboardSubPageSelector extends StatelessWidget {
  DashboardSubPageSelector({
    super.key,
  });

  final List<String> subPages = [
    "Overview",
    "Lesson Management",
    "Student Performance",
    "Classroom Performance",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Expanded(
        child: Row(
          children: [
            ...subPages.map(
              (subPage) => GestureDetector(
                child: Flexible(
                  flex: 1,
                  child: Container(
                    child: Text(
                      subPage,
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
