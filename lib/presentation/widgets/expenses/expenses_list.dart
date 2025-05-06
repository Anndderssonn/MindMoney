import 'package:flutter/material.dart';
import 'package:mindmoney/domain/entities/expense_entity.dart';
import 'package:mindmoney/presentation/widgets/expenses/expense_item.dart';

class ExpensesList extends StatelessWidget {
  final List<ExpenseEntity> expenses;

  const ExpensesList({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return ExpenseItem(expense: expenses[index]);
      },
    );
  }
}
