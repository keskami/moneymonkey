import 'package:flutter/material.dart';
import 'package:money_monkey/TeacherDashboard/Widgets/ShadowedContainer.dart';

class TeacherDashoardPlaceHolderPage extends StatelessWidget {
  const TeacherDashoardPlaceHolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ShadowedContainer(
      width: screenWidth * 0.5,
      height: screenHeight * 0.7,
      child: Center(
        child: Text("Select a Class to display content."),
      ),
    );
  }
}
