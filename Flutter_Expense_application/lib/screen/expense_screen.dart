import 'package:flutter/material.dart';
import 'package:flutter_application_expense/database/expense_database.dart';
import 'package:flutter_application_expense/model/expense.dart';
import 'package:flutter_application_expense/screen/add_expense.dart';
import 'package:flutter_application_expense/screen/expense_edit.dart';
import 'package:flutter_application_expense/widget/expense_detail_card.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  late List<Expense> expenses;
  late Expense expense;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    refresh();
  }

  @override
  void dispose() {
    ExpenseDatabase.instance.close();

    super.dispose();
  }

  Future refresh() async {
    setState(() => isLoading = true);

    expenses = await ExpenseDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 244, 246, 1),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 20,
                  child: Container(
                    height: 240,
                    width: 350,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Colors.blue, Colors.redAccent]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7, // blur radius
                              offset: const Offset(0, 2))
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            SizedBox(
                              width: 110,
                              height: 80,
                            ),
                            Text(
                              'expense.category',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  letterSpacing: 0.8),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 50,
                              height: 20,
                            ),
                            Text(
                              '\$',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  letterSpacing: 0.8),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "expense",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  letterSpacing: 0.8),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  height: 10,
                                  width: 10,
                                ),
                                const Image(
                                  image:
                                      AssetImage('assets/iconimage/incom.png'),
                                  height: 30,
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  children: const [
                                    Text(
                                      'Incom',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white30,
                                          letterSpacing: 0.8),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '25,000,000',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          letterSpacing: 0.8),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(width: 30),
                            Row(
                              children: [
                                const SizedBox(
                                  height: 10,
                                  width: 10,
                                ),
                                const Image(
                                  image: AssetImage(
                                      'assets/iconimage/expense.png'),
                                  height: 30,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  children: const [
                                    Text(
                                      'Expense',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white30,
                                          letterSpacing: 0.8),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '25,000,000',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          letterSpacing: 0.8),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : expenses.isEmpty
                          ? const Text(
                              'No Expenses',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 24),
                            )
                          : buildExpense())),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          const SizedBox(width: 30),
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          // SizedBox(width: 70),
          Padding(
            padding: const EdgeInsets.only(bottom: 25, left: 80.5),
            child: InkWell(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddExpense()));
                refresh();
              },
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Colors.blue, Colors.redAccent]),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7, // blur radius
                        offset: const Offset(0, 2))
                  ],
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white70,
                ),
              ),
            ),
          ),

          const SizedBox(width: 70),
          IconButton(onPressed: () {}, icon: const Icon(Icons.bar_chart))
        ],
      ),
    );
  }

  Widget buildExpense() => ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        refresh();
        final expense = expenses[index];

        return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ExpenseEdit(expenseID: expense.id!)));

              print('tap');
            },
            child: ExpenseDetailCard(expense: expense));
      });
}
