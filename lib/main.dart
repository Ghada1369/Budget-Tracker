import 'package:budget_tracker/cubic/add_expense_cubit.dart';
import 'package:budget_tracker/models/expenses_model.dart';
import 'package:budget_tracker/theme/app_theme.dart';
import 'package:budget_tracker/views/history_view.dart';
import 'package:budget_tracker/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ExpensesModelAdapter());
  await Hive.deleteBoxFromDisk('BudgetTracker');

  await Hive.openBox<ExpensesModel>('BudgetTracker');

  var settingsBox = await Hive.openBox('settings');
  await settingsBox.put('lastOpened', DateTime.now());

  runApp(const BudgetTracker());
}


class BudgetTracker extends StatelessWidget {
  const BudgetTracker({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> AddExpenseCubit(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: HomeView.routeName,
        routes: {
          HomeView.routeName: (context)=> HomeView(),
          HistoryView.routeName: (context) => const HistoryView(),
        },
      ),
    );
  }
}
