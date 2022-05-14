import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_expense/model/expense.dart';
import 'package:intl/intl.dart';

List<IconData> IconType = [
  Icons.movie,
  Icons.food_bank,
  Icons.work,
  Icons.mode_of_travel,
  Icons.shopping_bag,
];

class ExpenseFromCard extends StatelessWidget {
  final Expense expense;
  const ExpenseFromCard({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().format(expense.createdtime);
    final categ = expense.category;
    return ListTile(
      leading: const Icon(Icons.home),
      title: Text(categ,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      trailing: Column(
        children: [
          Text(exp.toString(),
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          Text(time,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
