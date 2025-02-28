import 'package:get/get.dart';
import 'package:money_monkey/BudgetSimulator/Pages/budgetSimulator.dart';
import 'package:money_monkey/Friends/comingSoonPage.dart';
import 'package:money_monkey/LessonPages/Pages/LessonsHome.dart';
import 'package:money_monkey/PortfolioPages/portfolio_screen.dart';
import 'package:money_monkey/Profile/profile_page.dart';

class HomePagesController extends GetxController {
  RxInt pageIndex = 0.obs;
  var pages = [
    LessonsHome(),
    PortfolioScreen(),
    ComingSoonPage(),
    BudgetSimulator(name: 'Crush the Credit Card Debt', checkingAccountBalance: 300, savingsAccountBalance: 300, creditCardDebt: 3000, startingBalance: 600, APY: 3,),
    ProfileScreen(),
  ];
}
