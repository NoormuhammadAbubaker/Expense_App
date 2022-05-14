import 'package:flutter/material.dart';
import 'package:flutter_application_expense/model/expense.dart';

List<IconData> IconType = [
  Icons.movie,
  Icons.food_bank,
  Icons.work,
  Icons.mode_of_travel,
  Icons.shopping_bag,
];

class ExpenseDetailCard extends StatelessWidget {
  final Expense expense;
  const ExpenseDetailCard({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime createTime = DateTime.now();
    return Card(
        elevation: 8.0,
        child: SizedBox(
          height: 70,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const CircleAvatar(
                radius: 30,
                child: Icon(Icons.ac_unit),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(expense.category,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87)),
              const SizedBox(
                width: 150,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text('\$',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        expense.rupee.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Text(
                    createTime.day.toString(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
  /*ListTile(
        title: Text(expense.category),
        leading: CircleAvatar(
          radius: 30,
          child: Icon(getIcon()),
        ),
        trailing: Text(expense.createdtime.toString()),
        subtitle: Text(expense.rupee.toString()),
      ), */

  getIcon() {
    if (expense.category == "Office") {
      const Icon(Icons.work_rounded);
    }
    if (expense.category == "Entertainment") {
      const Icon(Icons.emoji_events_rounded);
    }
    if (expense.category == "Food") {
      const Icon(Icons.food_bank);
    }
    if (expense.category == "Travel") {
      const Icon(Icons.card_travel);
    }
    if (expense.category == "Shopping") {
      const Icon(Icons.shopping_bag);
    } else {
      const Icon(Icons.error);
    }
  }
}
