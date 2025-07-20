import 'package:hive/hive.dart';
part 'expenses_model.g.dart';

@HiveType(typeId: 0)
class ExpensesModel extends HiveObject {
  @HiveField(0)
  final String category;

  @HiveField(1)
  final double expense;

  @HiveField(2)
  final DateTime date;

  ExpensesModel({
    required this.category,
    required this.expense,
    required this.date,
  });
}
