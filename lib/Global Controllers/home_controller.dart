import 'package:get/get.dart';
import 'package:money_monkey/Friends/comingSoonPage.dart';
import 'package:money_monkey/Lesson%20Flow/Screens/home.dart';
import 'package:money_monkey/PortfolioPages/portfolio_screen.dart';
import 'package:money_monkey/Profile/profile_page.dart';

class HomeController extends GetxController {
  var pages = [
    HomeScreen(),
    PortfolioScreen(),
    ComingSoonPage(),
    ProfileScreen(),
  ];
  RxInt pageIndex = 0.obs;
}
