import 'package:get/get.dart';
import 'package:money_monkey/Friends/comingSoonPage.dart';
import 'package:money_monkey/Invest/Screens/discover_screen.dart';
import 'package:money_monkey/Invest/Screens/real_estate_screen.dart';

class InvestController extends GetxController {
  RxInt pageIndex = 0.obs;
  var Pages = [
    DiscoverScreen(),
    ComingSoonPage(),
    RealEstateScreen(),
  ];
}
