import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../controllers/language_controller.dart';
import '../controllers/target_controller.dart';
import 'target_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final languageController = Get.find<LanguageController>();
    final targetController = Get.find<TargetController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ================= Appearance Section =================
          const Text(
            "Appearance",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Obx(
            () => SwitchListTile(
              title: const Text("Dark Mode"),
              value: themeController.themeMode.value == ThemeMode.dark,
              onChanged: (val) => themeController.toggleTheme(),
            ),
          ),
          const Divider(),

          // ================= Preferences Section =================
          const Text(
            "Preferences",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Obx(
            () => ListTile(
              title: const Text("Currency"),
              subtitle: Text("Current: ${languageController.currency.value}"),
              trailing: DropdownButton<String>(
                value: languageController.currency.value,
                items: const [
                  DropdownMenuItem(value: "৳ BDT", child: Text("৳ BDT")),
                  DropdownMenuItem(value: "\$ USD", child: Text("\$ USD")),
                  DropdownMenuItem(value: "€ EUR", child: Text("€ EUR")),
                ],
                onChanged: (val) {
                  if (val != null) languageController.setCurrency(val);
                },
              ),
            ),
          ),
          Obx(
            () => ListTile(
              title: const Text("Language"),
              subtitle: Text("Current: ${languageController.language.value}"),
              trailing: DropdownButton<String>(
                value: languageController.language.value,
                items: const [
                  DropdownMenuItem(value: "English", child: Text("English")),
                  DropdownMenuItem(value: "Bangla", child: Text("বাংলা")),
                ],
                onChanged: (val) {
                  if (val != null) languageController.setLanguage(val);
                },
              ),
            ),
          ),
          const Divider(),

          // ================= Targets & Reminders Section =================
          const Text(
            "Targets & Reminders",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Obx(
            () => SwitchListTile(
              title: const Text("Daily Reminder"),
              value: targetController.reminderEnabled.value,
              onChanged: (val) => targetController.reminderEnabled.value = val,
            ),
          ),
          const SizedBox(height: 10),

          // Example: show current targets
          Obx(
            () => ListTile(
              title: const Text("Daily Target"),
              subtitle: Text(
                "৳${targetController.dailyTarget.value.toStringAsFixed(2)}",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Get.to(() => const TargetsScreen());
                },
              ),
            ),
          ),
          Obx(
            () => ListTile(
              title: const Text("Monthly Target"),
              subtitle: Text(
                "৳${targetController.monthlyTarget.value.toStringAsFixed(2)}",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Get.to(() => const TargetsScreen());
                },
              ),
            ),
          ),
          Obx(
            () => ListTile(
              title: const Text("Yearly Target"),
              subtitle: Text(
                "৳${targetController.yearlyTarget.value.toStringAsFixed(2)}",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Get.to(() => const TargetsScreen());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
