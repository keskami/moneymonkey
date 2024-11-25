import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/Invest/controllers/invest_pages_controller.dart';

class InvestHomeBottomNav extends StatelessWidget {
  InvestHomeBottomNav({
    super.key,
  });
  final InvestController investController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                investController.pageIndex.value = 0;
              },
              child: Text(
                "Discover",
                style: GoogleFonts.baloo2(
                  fontSize: 18,
                  fontWeight: investController.pageIndex.value == 0
                      ? FontWeight.bold
                      : null,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                investController.pageIndex.value = 1;
              },
              child: Text(
                "Markets",
                style: GoogleFonts.baloo2(
                  fontSize: 18,
                  fontWeight: investController.pageIndex.value == 1
                      ? FontWeight.bold
                      : null,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                investController.pageIndex.value = 2;
              },
              child: Text("Real Estate",
                  style: GoogleFonts.baloo2(
                    fontSize: 18,
                    fontWeight: investController.pageIndex.value == 2
                        ? FontWeight.bold
                        : null,
                    color: Colors.black,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
