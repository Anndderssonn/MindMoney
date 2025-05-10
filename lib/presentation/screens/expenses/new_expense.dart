import 'package:flutter/material.dart';
import 'package:mindmoney/domain/entities/expense_entity.dart';

class NewExpense extends StatefulWidget {
  final void Function(ExpenseEntity expense) onAddExpense;

  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Categories _selectedCategory = Categories.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year, now.month + 1, now.day);
    final datePicked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = datePicked;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
      _amountController.text.replaceFirst(',', '.'),
    );
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Invalid form'),
              content: const Text(
                'Please make sure a valid title, amount, date and category was entered.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
      return;
    }
    widget.onAddExpense(
      ExpenseEntity(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSapace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSapace + 16),
            child: Column(
              children: [
                if (screenWidth >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: InputDecoration(label: Text('Title')),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: InputDecoration(label: Text('Title')),
                  ),
                if (screenWidth >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items:
                            Categories.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? formatter.format(_selectedDate!)
                                  : 'Select Date',
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? formatter.format(_selectedDate!)
                                  : 'Select Date',
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                if (screenWidth >= 600)
                  Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Discard'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items:
                            Categories.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Discard'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
