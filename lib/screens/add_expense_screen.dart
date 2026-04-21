import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/expense_controller.dart';
import '../models/expense_model.dart';
import '../widgets/category_chip.dart';

class AddExpenseScreen extends StatefulWidget {
  final String type; // income / expense
  const AddExpenseScreen({super.key, required this.type});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final ExpenseController controller = Get.find<ExpenseController>();

  String _title = '';
  double _amount = 0;
  DateTime _date = DateTime.now();
  String? _category;

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final expenseCategories = [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Others',
  ];
  final incomeCategories = ['Salary', 'Business', 'Freelance', 'Gift'];

  @override
  void initState() {
    super.initState();

    final categories = widget.type == 'income'
        ? incomeCategories
        : expenseCategories;
    _category = categories.isNotEmpty ? categories.first : 'Others';

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selected != null) setState(() => _date = selected);
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      if (_category == null || _category!.isEmpty) {
        Get.snackbar(
          'Error',
          'Please select a category',
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        return;
      }

      _formKey.currentState!.save();
      controller.addExpense(
        Expense(
          title: _title,
          amount: _amount,
          date: _date,
          type: widget.type,
          category: _category!,
        ),
      );

      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.type == 'income'
        ? incomeCategories
        : expenseCategories;

    final theme = Theme.of(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Scaffold(
          backgroundColor:
              theme.scaffoldBackgroundColor, // ✅ dark mode compatible
          appBar: AppBar(title: Text('Add ${widget.type.toUpperCase()}')),
          body: _category == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        TextFormField(
                          decoration: _inputDecoration(
                            'Title',
                            Icons.title,
                            theme,
                          ),
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                          onSaved: (v) => _title = v!,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: _inputDecoration(
                            'Amount',
                            Icons.attach_money,
                            theme,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) =>
                              v!.isEmpty || double.tryParse(v) == null
                              ? 'Invalid amount'
                              : null,
                          onSaved: (v) => _amount = double.parse(v!),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Select Category',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: categories
                              .map(
                                (c) => CategoryChip(
                                  label: c,
                                  isSelected: _category == c,
                                  onTap: () => setState(() {
                                    _category = c;
                                  }),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: _selectDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              border: Border.all(
                                color: theme.colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withOpacity(
                                    0.1,
                                  ),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${_date.day}/${_date.month}/${_date.year}',
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: theme.colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _save,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon,
    ThemeData theme,
  ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: theme.colorScheme.primary),
      filled: true,
      fillColor: theme.cardColor,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
