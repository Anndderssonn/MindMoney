import 'package:flutter/material.dart';
import 'package:mindmoney/domain/entities/expense_entity.dart';
import 'package:mindmoney/presentation/widgets/expenses/expense_item.dart';

class ExpensesList extends StatelessWidget {
  final List<ExpenseEntity> expenses;
  final void Function(ExpenseEntity expense) onRemoveExpense;

  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            color: Theme.of(context).colorScheme.errorContainer,
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(expense: expenses[index]),
        );
      },
    );
  }
}

class ExpenseBucket {
  final Categories category;
  final List<ExpenseEntity> expenses;

  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<ExpenseEntity> allExpenses, this.category)
    : expenses =
          allExpenses.where((expense) => expense.category == category).toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
