import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Backend/Models/Academic.dart';
import 'package:money_monkey/Backend/Models/SubComponentModel.dart';
import 'package:money_monkey/Backend/Services/AcademicServices.dart';
import 'package:money_monkey/Backend/Services/DirectFirebaseService.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/ExitCheck.dart';
import 'package:money_monkey/LessonPages/SubComponentPages/Reflect.dart';

class BaseLessonController extends GetxController {
  /// Indicates whether the controller is still loading data.
  RxBool isLoading = true.obs;
  RxInt pageIndex = 0.obs;

  final DirectFirebaseService localAcademicService = DirectFirebaseService();
  final String componentId;
  final ComponentType type;

  BaseLessonController({required this.componentId, required this.type});

  // overarching dynamic pages list
  List<Widget> pages = [];

  // for Scenario Simulation
  RxInt responsibilityScore = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadConceptData(BuildContext context) async {
    try {
      // final Component data =
      //     await localAcademicService.getComponent(componentId);

      pages.add(const ExitCheck());

      pages.add(const ExitCheck());

      pages.add(const ExitCheck());

      pages.add(const ExitCheck());

      pages.add(const ExitCheck());

      // pages.add(const Reflection());
    } catch (e) {
      print("Error loading concept data: $e");
    } finally {
      isLoading.value = false; // using the inherited property
    }
  }
}
