import 'package:get/get.dart';
import '../models/expense_model.dart';

class ExpenseController extends GetxController {
  var totalExpense = 0.0.obs; // ✅ RxDouble
  var totalIncome = 0.0.obs;
  var balance = 0.0.obs;

  void addExpense(Expense expense) {
    if (expense.type == "expense") {
      totalExpense.value += expense.amount;
    } else {
      totalIncome.value += expense.amount;
    }
    balance.value = totalIncome.value - totalExpense.value;
  }
}
