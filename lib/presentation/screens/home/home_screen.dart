import 'package:flutter/material.dart';
import 'package:mindmoney/domain/entities/expense_entity.dart';
import 'package:mindmoney/presentation/screens/expenses/new_expense.dart';
import 'package:mindmoney/presentation/widgets/expenses/expenses_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ExpenseEntity> _expensesRegistered = [
    ExpenseEntity(
      title: 'Briefcase',
      amount: 35.50,
      date: DateTime.now(),
      category: Categories.work,
    ),
    ExpenseEntity(
      title: 'Forza Horizon game',
      amount: 25.99,
      date: DateTime.now(),
      category: Categories.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(ExpenseEntity expense) {
    setState(() {
      _expensesRegistered.add(expense);
    });
  }

  void _removeExpense(ExpenseEntity expense) {
    setState(() {
      _expensesRegistered.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: const Text('MindMoney'),
        ),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Text('The chart!'),
          Expanded(
            child: ExpensesList(
              expenses: _expensesRegistered,
              onRemoveExpense: _removeExpense,
            ),
          ),
        ],
      ),
    );
  }
}
