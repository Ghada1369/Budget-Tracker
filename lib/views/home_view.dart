import 'package:budget_tracker/views/history_view.dart';
import 'package:budget_tracker/widgets/activity_container.dart';
import 'package:budget_tracker/widgets/expense_list.dart';
import 'package:budget_tracker/widgets/floating_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static const routeName = 'homeScreen';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      floatingActionButton: const FloatingButton(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Welcome',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onBackground,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, HistoryView.routeName);
                      },
                      icon: Icon(
                        Icons.history,
                        color: colorScheme.primary,
                        size: 35,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Ready to track your budget?',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onBackground,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                const ActivityContainer(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Today\'s Expenses',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const ExpenseList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
