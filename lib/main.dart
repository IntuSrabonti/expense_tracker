import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/expense_controller.dart';
import 'controllers/theme_controller.dart';
import 'controllers/target_controller.dart';
import 'controllers/language_controller.dart';
import 'screens/splash_screen.dart';
//import 'screens/targets_screen.dart'; // ✅ add this
import 'utils/app_themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TargetController());
  Get.put(ExpenseController());
  Get.put(ThemeController());
  Get.put(LanguageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TRACK MiND',
        home: const SplashScreen(), // ✅ now recognized
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: themeController.themeMode.value,
      ),
    );
  }
}
