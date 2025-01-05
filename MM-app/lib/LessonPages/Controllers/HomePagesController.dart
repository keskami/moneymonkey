import 'package:get/get.dart';
import 'package:money_monkey/Friends/comingSoonPage.dart';
import 'package:money_monkey/LessonPages/Pages/LessonsHome.dart';
import 'package:money_monkey/PortfolioPages/portfolio_screen.dart';
import 'package:money_monkey/Profile/profile_page.dart';

class HomePagesController extends GetxController {
  RxInt pageIndex = 0.obs;
  var pages = [
    HomeScreen(),
    PortfolioScreen(),
    ComingSoonPage(),
    ProfileScreen(),
  ];
}
