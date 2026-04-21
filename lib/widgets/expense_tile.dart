import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final String category;
  final String amount;
  final String date;
  final IconData icon;

  const ExpenseTile({
    super.key,
    required this.category,
    required this.amount,
    required this.date,
    this.icon = Icons.account_balance_wallet,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          category,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(date),
        trailing: Text(
          "\$$amount",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
