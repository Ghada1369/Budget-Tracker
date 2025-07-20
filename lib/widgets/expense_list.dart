import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:budget_tracker/models/expenses_model.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder(
      valueListenable: Hive.box<ExpensesModel>('BudgetTracker').listenable(),
      builder: (context, Box<ExpensesModel> box, _) {
        final allExpenses = box.values.toList();

        return SizedBox(
          height: 500,
          child: ListView.builder(
            itemCount: allExpenses.length,
            itemBuilder: (context, index) {
              final item = allExpenses[index];

              return Card(
                color: theme.cardColor,
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    item.category,
                    style: TextStyle(
                      color: theme.textTheme.titleLarge?.color,
                      fontSize: 17,
                    ),
                  ),
                  subtitle: Text(
                    '${item.expense.toStringAsFixed(2)} EG',
                    style: TextStyle(
                      color: theme.textTheme.bodyMedium?.color,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: theme.iconTheme.color),
                    onPressed: () {
                      item.delete();
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
