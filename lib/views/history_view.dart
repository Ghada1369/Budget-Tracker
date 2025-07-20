import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:budget_tracker/models/expenses_model.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatelessWidget {
  static const routeName = 'historyScreen';

  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
                Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color:isDark ? Colors.white : Colors.black ,)
        ),
        backgroundColor: isDark ? Colors.black : const Color(0xDFDFDDDD),
        title: Text(
          'Expense History',
          style: textTheme.titleLarge?.copyWith(color: isDark ? Colors.white : Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<ExpensesModel>('BudgetTracker').listenable(),
        builder: (context, Box<ExpensesModel> box, _) {
          final allExpenses = box.values.toList();

          Map<String, List<ExpensesModel>> groupedByDate = {};

          for (var expense in allExpenses) {
            String formattedDate =
            DateFormat('yyyy-MM-dd').format(expense.date);
            groupedByDate.putIfAbsent(formattedDate, () => []).add(expense);
          }

          final sortedDates = groupedByDate.keys.toList()
            ..sort((a, b) => b.compareTo(a));

          return ListView.builder(
            itemCount: sortedDates.length,
            itemBuilder: (context, index) {
              final date = sortedDates[index];
              final expenses = groupedByDate[date]!;

              return ExpansionTile(
                title: Text(
                  date,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: expenses.map((e) {
                  return ListTile(
                    title: Text(
                      e.category,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    trailing: Text(
                      '${e.expense} EG',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
