import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TargetController extends GetxController {
  var dailyTarget = 0.0.obs;
  var monthlyTarget = 0.0.obs;
  var yearlyTarget = 0.0.obs;

  var dailyUpdated = false.obs;
  var reminderEnabled = true.obs;

  // ✅ Proper setter methods
  void setDaily(double value) {
    dailyTarget.value = value;
    dailyUpdated.value = false;
  }

  void setMonthly(double value) {
    monthlyTarget.value = value;
  }

  void setYearly(double value) {
    yearlyTarget.value = value;
  }

  void setTarget(String type, double value) {
    switch (type.toLowerCase()) {
      case "daily":
        setDaily(value);
        break;
      case "monthly":
        setMonthly(value);
        break;
      case "yearly":
        setYearly(value);
        break;
    }
  }

  void markDailyUpdate() => dailyUpdated.value = true;

  void checkAllTargets(double spent) {
    if (!reminderEnabled.value) return; // ✅ Reminder বন্ধ থাকলে কিছু করবে না

    _check("Daily", spent, dailyTarget.value, Colors.black);
    _check("Monthly", spent, monthlyTarget.value, Colors.black);
    _check("Yearly", spent, yearlyTarget.value, Colors.black);
  }

  void _check(String label, double spent, double target, Color color) {
    if (target > 0) {
      if (spent > target) {
        Get.snackbar(
          "Reminder",
          "$label target crossed!",
          backgroundColor: color,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Info",
          "$label target not crossed yet.",
          backgroundColor: Colors.white,
          colorText: Colors.black,
        );
      }
    } else {
      Get.snackbar(
        "Info",
        "No $label target set yet.",
        backgroundColor: Colors.grey[300],
        colorText: Colors.black,
      );
    }
  }

  // ✅ Simplified reminder check
  void checkReminder(double spent) {
    checkAllTargets(spent);
  }

  // ✅ Daily update check
  void checkDailyUpdate() {
    if (dailyUpdated.value) {
      Get.snackbar(
        "Daily Update",
        "You already updated today's target.",
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Daily Update",
        "Today's target: ৳${dailyTarget.value}",
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
    }
  }
}
