import 'package:get/get.dart';

class LanguageController extends GetxController {
  var language = "English".obs;
  var currency = "৳ BDT".obs;
  var dailyReminder = false.obs;

  void setLanguage(String lang) => language.value = lang;
  void setCurrency(String curr) => currency.value = curr;
  void setDailyReminder(bool val) => dailyReminder.value = val;
}
