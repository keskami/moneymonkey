import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_monkey/Invest/Widgets/bottom_navigation_bar.dart';
import 'package:money_monkey/Invest/controllers/invest_pages_controller.dart';

class InvestmentHomePage extends StatelessWidget {
  InvestmentHomePage({
    super.key,
  });
  final InvestController investController = Get.put(InvestController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => investController.Pages[investController.pageIndex.value],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(
          onPressed: () {
            investController.pageIndex.value = 0;
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black.withOpacity(0.8),
            size: 30,
          )),
      bottomNavigationBar: InvestHomeBottomNav(),
    );
  }
}
