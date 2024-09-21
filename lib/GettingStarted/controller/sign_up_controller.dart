import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:money_monkey/GettingStarted/Pages/SignUpPages/sud_email.dart';
import 'package:money_monkey/GettingStarted/Pages/SignUpPages/sud_name.dart';
import 'package:money_monkey/GettingStarted/Pages/SignUpPages/sud_password.dart';

class SignUpController extends GetxController {
  RxInt pageIndex = 0.obs;

  var pages = [
    SUDetailsNamePage(
      signUpController: SignUpController(),
    ), // Ensure no recursion happens here
    SUDetailsEmailPage(signUpController: SignUpController()),
    SUDetailsPasswordPage(signUpController: SignUpController()),
  ];

  RxString name = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
}
