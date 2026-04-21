import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/expense_model.dart';

class ExpenseStorage {
  static const _key = 'expenses';

  // Save all expenses to SharedPreferences
  static Future<void> saveExpenses(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = expenses.map((e) => json.encode(e.toMap())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  // Load all expenses from SharedPreferences
  static Future<List<Expense>> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    return jsonList.map((e) {
      final map = json.decode(e);
      return Expense.fromMap(map);
    }).toList();
  }
}
