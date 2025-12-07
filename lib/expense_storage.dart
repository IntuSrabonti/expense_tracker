import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'expense_model.dart';

class ExpenseStorage {
  static const _key = 'expenses';

  static Future<void> saveExpenses(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = expenses.map((e) => json.encode(e.toMap())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  static Future<List<Expense>> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    return jsonList.map((e) => Expense.fromMap(json.decode(e))).toList();
  }
}
