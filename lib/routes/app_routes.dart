import 'package:get/get.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/add_expense_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const home = '/home';
  static const addExpense = '/addExpense';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(
      name: AppRoutes.addExpense,
      page: () => AddExpenseScreen(type: 'expense'), // ❌ remove const
    ),
  ];
}
