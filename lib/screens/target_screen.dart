import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/target_controller.dart';
import '../controllers/expense_controller.dart';

class TargetsScreen extends StatelessWidget {
  const TargetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TargetController targetController = Get.find<TargetController>();
    final ExpenseController expenseController = Get.find<ExpenseController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Targets & Reminders")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Daily Target
          Obx(
            () => _buildTargetTile(
              "Daily Target",
              targetController.dailyTarget.value,
              () => _showTargetDialog(
                context,
                "Daily",
                targetController.setDaily,
                targetController.dailyTarget.value,
              ),
            ),
          ),
          // Monthly Target
          Obx(
            () => _buildTargetTile(
              "Monthly Target",
              targetController.monthlyTarget.value,
              () => _showTargetDialog(
                context,
                "Monthly",
                targetController.setMonthly,
                targetController.monthlyTarget.value,
              ),
            ),
          ),
          // Yearly Target
          Obx(
            () => _buildTargetTile(
              "Yearly Target",
              targetController.yearlyTarget.value,
              () => _showTargetDialog(
                context,
                "Yearly",
                targetController.setYearly,
                targetController.yearlyTarget.value,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Reminder Button
          ElevatedButton.icon(
            icon: const Icon(Icons.alarm),
            label: const Text("Check Reminder"),
            onPressed: () {
              targetController.checkReminder(
                expenseController.totalExpense.value,
              );
            },
          ),
          const SizedBox(height: 12),

          // Daily Update Button
          ElevatedButton.icon(
            icon: const Icon(Icons.update),
            label: const Text("Check Daily Update"),
            onPressed: () {
              targetController.checkDailyUpdate();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTargetTile(String title, double value, VoidCallback onTap) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text("৳${value.toStringAsFixed(2)}"),
        trailing: IconButton(icon: const Icon(Icons.edit), onPressed: onTap),
      ),
    );
  }

  void _showTargetDialog(
    BuildContext context,
    String type,
    Function(double) onSave,
    double currentValue,
  ) {
    final TextEditingController ctrl = TextEditingController(
      text: currentValue.toStringAsFixed(2),
    );
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Set $type Target"),
        content: TextField(
          autofocus: true,
          controller: ctrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Amount (৳)"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final val = double.tryParse(ctrl.text);
              if (val != null) {
                onSave(val);
              }
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
