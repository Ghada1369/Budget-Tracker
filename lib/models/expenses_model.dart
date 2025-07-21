import 'package:hive/hive.dart';
part 'expenses_model.g.dart';

@HiveType(typeId: 0)
class ExpensesModel extends HiveObject {
  @HiveField(0)
  String category;

  @HiveField(1)
  double expense;

  @HiveField(2)
  DateTime date;

  ExpensesModel({
    required this.category,
    required this.expense,
    required this.date,
  });
}

