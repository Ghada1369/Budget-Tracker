import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:budget_tracker/models/expenses_model.dart';

class ActivityContainer extends StatelessWidget {
  const ActivityContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ValueListenableBuilder(
      valueListenable: Hive.box<ExpensesModel>('BudgetTracker').listenable(),
      builder: (context, Box<ExpensesModel> box, _) {
        final allExpenses = box.values.toList();
        final now = DateTime.now();

        final todayExpenses = allExpenses.where((e) =>
        e.date.day == now.day &&
            e.date.month == now.month &&
            e.date.year == now.year);

        final monthExpenses = allExpenses.where((e) =>
        e.date.month == now.month && e.date.year == now.year);

        final yearExpenses = allExpenses.where((e) => e.date.year == now.year);

        final todayTotal =
        todayExpenses.fold(0.0, (sum, e) => sum + e.expense);
        final monthTotal =
        monthExpenses.fold(0.0, (sum, e) => sum + e.expense);
        final yearTotal =
        yearExpenses.fold(0.0, (sum, e) => sum + e.expense);

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Your Activity',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Icon(Icons.show_chart, color: colorScheme.onPrimary),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: buildColumn('Today', todayTotal, colorScheme)),
                    Expanded(child: buildColumn('This Month', monthTotal, colorScheme)),
                    Expanded(child: buildColumn('This Year', yearTotal, colorScheme)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column buildColumn(String label, double amount, ColorScheme colorScheme) {
    return Column(
      children: [
        Text(
          '${amount.toStringAsFixed(2)} EG',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
