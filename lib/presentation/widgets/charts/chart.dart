import 'package:flutter/material.dart';
import 'package:mindmoney/domain/entities/expense_entity.dart';
import 'package:mindmoney/presentation/widgets/charts/chart_bar.dart';
import 'package:mindmoney/presentation/widgets/expenses/expenses_list.dart';

class Chart extends StatelessWidget {
  final List<ExpenseEntity> expenses;

  const Chart({super.key, required this.expenses});

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Categories.food),
      ExpenseBucket.forCategory(expenses, Categories.leisure),
      ExpenseBucket.forCategory(expenses, Categories.travel),
      ExpenseBucket.forCategory(expenses, Categories.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            Theme.of(context).colorScheme.primary.withValues(alpha: 0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final buckect in buckets)
                  ChartBar(
                    fill:
                        buckect.totalExpenses == 0
                            ? 0
                            : buckect.totalExpenses / maxTotalExpense,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children:
                buckets
                    .map(
                      (bucket) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            categoryIcons[bucket.category],
                            color:
                                isDarkMode
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
