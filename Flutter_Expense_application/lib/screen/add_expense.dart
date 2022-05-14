import 'package:flutter/material.dart';
import 'package:flutter_application_expense/model/expense.dart';
import 'package:intl/intl.dart';
import '../database/expense_database.dart';

class AddExpense extends StatefulWidget {
  final Expense? expense;
  const AddExpense({Key? key, this.expense}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  TextEditingController expenseTextEditing = TextEditingController();
  TextEditingController noteTextEditing = TextEditingController();
  var db;
  late int expense;
  late String detail;
  late String category;
  String? chosenValue;
  var selectedItemValue = [];

  @override
  void initState() {
    super.initState();
    db = ExpenseDatabase.instance;
    // expense = widget.expense?.rupee ?? 0;
    // detail = widget.expense?.note ?? '';
    // category = widget.expense?.category ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(243, 244, 246, 1),
        body: Stack(
          children: [
            Positioned(
              top: 40,
              left: 310,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ),
            const Positioned(
              top: 130,
              left: 140,
              child: Text(
                'Add Expense',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ),
            Positioned(
              top: 190,
              left: 90,
              child: TextField(
                controller: expenseTextEditing,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.currency_rupee),
                  suffixIconColor: Colors.deepPurpleAccent,
                  hintText: '0',
                  hintStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                  fillColor: Colors.white,
                  filled: true,
                  constraints: const BoxConstraints(
                    maxHeight: 110,
                    maxWidth: 210,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(70),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            Positioned(
                top: 290,
                left: 30,
                child: InkWell(
                  onTap: () {
                    _selectDate(context);
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    color: Colors.white,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.calendar_today),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                )),

/* */

            Positioned(
              top: 360,
              left: 30,
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  focusColor: Colors.white,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.group_work),
                    prefixIconColor: Colors.deepPurpleAccent,
                    hintText: 'Note',
                    hintStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400),
                    fillColor: Colors.white,
                    filled: true,
                    constraints: const BoxConstraints(
                      maxHeight: 60,
                      maxWidth: 350,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: chosenValue,

                  //elevation: 5,
                  style: const TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: <String>[
                    "NONE",
                    "Entertainment",
                    "Food",
                    "Office",
                    "Travel",
                    "Shopping"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: const Text(
                    "Category",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  onChanged: (value) {
                    setState(() {
                      chosenValue = value;
                    });
                  },
                ),
              ),
            ),
            Positioned(
              top: 440,
              left: 30,
              child: TextField(
                controller: noteTextEditing,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.note),
                  prefixIconColor: Colors.deepPurpleAccent,
                  hintText: 'Note',
                  hintStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                  fillColor: Colors.white,
                  filled: true,
                  constraints: const BoxConstraints(
                    maxHeight: 50,
                    maxWidth: 350,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 620,
              left: 60,
              child: InkWell(
                onTap: () {
                  addNote(
                      chosenValue.toString(),
                      noteTextEditing.text,
                      selectedDate.toLocal(),
                      int.parse(expenseTextEditing.text));

                  //print(ExpenseDatabase.instance.readNote(1));
                  print(expenseTextEditing.text +
                      selectedDate.toLocal().toString() +
                      noteTextEditing.text +
                      chosenValue.toString());
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Colors.blue, Colors.redAccent]),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    'SAVE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    DatePickerEntryMode.calendar;
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}

Future addNote(
    String category, String note, DateTime dateTime, int expenserupee) async {
  var expense = Expense(
      category: category,
      note: note,
      createdtime: dateTime,
      rupee: expenserupee);

  await ExpenseDatabase.instance.create(expense);
}

class Listtile {
  String lable;
  String image;
  Listtile({required this.image, required this.lable});
}
