//import 'package:flutter/material.dart';

class AppConstants {
  // App name
  static const String appName = 'Expense App';

  // Default padding and spacing
  static const double defaultPadding = 16.0;
  static const double smallSpacing = 8.0;
  static const double mediumSpacing = 16.0;
  static const double largeSpacing = 24.0;

  // Animation durations
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration fadeDuration = Duration(milliseconds: 600);

  // Date format (can be used with intl package later)
  static const String dateFormat = 'dd/MM/yyyy';

  // Default categories
  static const List<String> expenseCategories = [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Others',
  ];

  static const List<String> incomeCategories = [
    'Salary',
    'Business',
    'Freelance',
    'Gift',
  ];

  // Error messages
  static const String requiredFieldError = 'This field is required';
  static const String invalidAmountError = 'Please enter a valid amount';
  static const String categoryError = 'Please select a category';
}
