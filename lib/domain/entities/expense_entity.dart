import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Categories { food, travel, leisure, work }

class ExpenseEntity {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  ExpenseEntity(
    this.category, {
    required this.title,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();
}
