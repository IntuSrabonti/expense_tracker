import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/expense_controller.dart';
import 'notes_screen.dart';
import 'settings_screen.dart';
import 'target_screen.dart';
import 'add_expense_screen.dart'; // ✅ income/expense add screen import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpenseController controller = Get.find<ExpenseController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText =
        Theme.of(context).textTheme.bodyMedium?.color ??
        (isDark ? Colors.white : Colors.black);
    final cardColor = isDark ? Colors.grey[900] : Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Track Mind')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Card(
            color: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Balance: ৳${controller.balance.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Income', style: TextStyle(color: primaryText)),
                          Text(
                            '৳${controller.totalIncome.toStringAsFixed(2)}',
                            style: TextStyle(color: primaryText),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Expense', style: TextStyle(color: primaryText)),
                          Text(
                            '৳${controller.totalExpense.toStringAsFixed(2)}',
                            style: TextStyle(color: primaryText),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ✅ Quick Add Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.arrow_downward,
                          color: isDark ? Colors.black : Colors.white,
                        ),
                        label: Text(
                          "Add Income",
                          style: TextStyle(
                            color: isDark ? Colors.black : Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? Colors.white : Colors.black,
                        ),
                        onPressed: () {
                          Get.to(() => const AddExpenseScreen(type: 'income'));
                        },
                      ),
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.arrow_upward,
                          color: isDark ? Colors.black : Colors.white,
                        ),
                        label: Text(
                          "Add Expense",
                          style: TextStyle(
                            color: isDark ? Colors.black : Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? Colors.white : Colors.black,
                        ),
                        onPressed: () {
                          Get.to(() => const AddExpenseScreen(type: 'expense'));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ✅ Fixed BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: isDark ? Colors.white : Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            // Home
          } else if (index == 1) {
            Get.to(() => const NotesScreen()); // Plans/Notes
          } else if (index == 2) {
            Get.to(() => const TargetsScreen()); // Targets/Reminder
          } else if (index == 3) {
            Get.to(() => const SettingsScreen());
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.note_alt), label: "Plans"),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: "Targets"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
