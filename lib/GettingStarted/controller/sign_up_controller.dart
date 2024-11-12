import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:money_monkey/GettingStarted/Pages/SignUpPages/sud_email.dart';
import 'package:money_monkey/GettingStarted/Pages/SignUpPages/sud_name.dart';
import 'package:money_monkey/GettingStarted/Pages/SignUpPages/sud_password.dart';
import 'package:money_monkey/GettingStarted/Pages/SignUpPages/sud_phone_number.dart';
import 'package:money_monkey/GettingStarted/Pages/SignUpPages/sud_username.dart';

class SignUpController extends GetxController {
  RxInt pageIndex = 0.obs;

  var pages = [
    SUDetailsNamePage(),
    SUDetailsUsernamePage(),
    SUDetailsPhoneNumberPage(),
    SUDetailsEmailPage(),
    SUDetailsPasswordPage(),
  ];

  RxString name = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
  RxString username = "".obs;
  RxString phoneNumber = "".obs;
}
