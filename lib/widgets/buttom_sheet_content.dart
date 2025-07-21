import 'package:budget_tracker/cubic/add_expense_cubit.dart';
import 'package:budget_tracker/models/expenses_model.dart';
import 'package:budget_tracker/widgets/category_selector.dart';
import 'package:budget_tracker/widgets/expenses_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ButtomSheetContent extends StatefulWidget {
  final ExpensesModel? existingExpense;
  final int? expenseKey;

  const ButtomSheetContent({super.key, this.existingExpense, this.expenseKey});

  @override
  State<ButtomSheetContent> createState() => _ButtomSheetContentState();
}

class _ButtomSheetContentState extends State<ButtomSheetContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? savedExpense;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.existingExpense != null) {
      selectedCategory = widget.existingExpense!.category;
      savedExpense = widget.existingExpense!.expense.toString();
    }
  }

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Choose a category',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CategorySelector(
              onCategorySelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
            const SizedBox(height: 30),
            ExpensesForm(
              formKey: _formKey,
              onSavedExpense: (value) {
                savedExpense = value;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: selectedCategory == null
                      ? null
                      : () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final updatedExpense = ExpensesModel(
                        category: selectedCategory!,
                        expense: double.parse(savedExpense!),
                        date: DateTime.now(),
                      );

                      if (widget.existingExpense != null && widget.expenseKey != null) {
                        Hive.box<ExpensesModel>('BudgetTracker')
                            .put(widget.expenseKey!, updatedExpense);
                      } else {
                        BlocProvider.of<AddExpenseCubit>(context)
                            .addNote(updatedExpense);
                      }

                      Navigator.pop(context);
                    }
                  },

                  child: Text(
                    'Ok',
                    style: TextStyle(
                      color: selectedCategory == null
                          ? Colors.grey
                          : primaryColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: textColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
