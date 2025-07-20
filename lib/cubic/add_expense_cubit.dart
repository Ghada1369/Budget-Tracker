import 'package:budget_tracker/cubic/add_expense_state.dart';
import 'package:budget_tracker/models/expenses_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  AddExpenseCubit() : super(AddExpenseInitial());

  Future<void> addNote(ExpensesModel note) async {
    emit(AddExpenseLoading());
    try {
      var notesBox = Hive.box<ExpensesModel>('BudgetTracker');
      await notesBox.add(note);
      emit(AddExpenseSuccess());
    } catch (e) {
      emit(AddExpenseFailure(e.toString()));
    }
  }
}
