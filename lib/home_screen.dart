import 'package:flutter/material.dart';
import 'expense_model.dart';
import 'expense_storage.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  void _loadExpenses() async {
    final loaded = await ExpenseStorage.loadExpenses();
    setState(() => _expenses = loaded);
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
      ExpenseStorage.saveExpenses(_expenses);
    });
  }

  void _deleteExpense(int index) {
    setState(() {
      _expenses.removeAt(index);
      ExpenseStorage.saveExpenses(_expenses);
    });
  }

  double get _totalIncome => _expenses
      .where((e) => e.type == 'income')
      .fold(0, (sum, e) => sum + e.amount);

  double get _totalExpense => _expenses
      .where((e) => e.type == 'expense')
      .fold(0, (sum, e) => sum + e.amount);

  double get _balance => _totalIncome - _totalExpense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Headline
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.shade300,
                    Colors.deepPurple.shade600,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Track Mind',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Manage your expenses wisely',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // Summary Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _summaryCard('Income', _totalIncome, Colors.green),
                  _summaryCard('Expense', _totalExpense, Colors.redAccent),
                  _summaryCard('Balance', _balance, Colors.blueGrey),
                ],
              ),
            ),
            SizedBox(height: 12),
            // Expense List
            Expanded(
              child: _expenses.isEmpty
                  ? Center(
                      child: Text(
                        'No expenses yet.\nTap + to add a new entry!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _expenses.length,
                      itemBuilder: (context, index) {
                        final exp = _expenses[index];
                        return Dismissible(
                          key: Key(exp.date.toIso8601String() + exp.title),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.redAccent,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (_) => _deleteExpense(index),
                          child: Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: exp.type == 'income'
                                    ? Colors.green[100]
                                    : Colors.red[100],
                                child: Icon(
                                  exp.type == 'income'
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                  color: exp.type == 'income'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              title: Text(
                                exp.title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${exp.date.day}/${exp.date.month}/${exp.date.year}',
                              ),
                              trailing: Text(
                                '\$${exp.amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: exp.type == 'income'
                                      ? Colors.green
                                      : Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 12, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Income button with label
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Income',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                FloatingActionButton(
                  heroTag: 'income',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          AddExpenseScreen(onSave: _addExpense, type: 'income'),
                    ),
                  ),
                  backgroundColor: Colors.green[300],
                  child: Icon(Icons.add, size: 28),
                  tooltip: 'Add Income',
                ),
              ],
            ),
            SizedBox(width: 12),
            // Expense button with label
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Expense',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                FloatingActionButton(
                  heroTag: 'expense',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddExpenseScreen(
                        onSave: _addExpense,
                        type: 'expense',
                      ),
                    ),
                  ),
                  backgroundColor: Colors.red[300],
                  child: Icon(Icons.add, size: 28),
                  tooltip: 'Add Expense',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String title, double amount, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
