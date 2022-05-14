import 'package:flutter/material.dart';
import 'package:flutter_application_expense/database/expense_database.dart';
import 'package:flutter_application_expense/model/expense.dart';
import 'package:flutter_application_expense/widget/expense_from_widget.dart';

class AddEditExpense extends StatefulWidget {
  final Expense? expense;
  const AddEditExpense({Key? key, this.expense}) : super(key: key);

  @override
  _AddEditExpenseState createState() => _AddEditExpenseState();
}

class _AddEditExpenseState extends State<AddEditExpense> {
  final _formKey = GlobalKey<FormState>();
  late int rupee;
  late String note;
  late String category;

  @override
  void initState() {
    super.initState();

    rupee = widget.expense?.rupee ?? 0;
    note = widget.expense?.note ?? '';
    category = widget.expense?.category ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
            key: _formKey,
            child: ExpenseFromWidget(
                rupee: rupee,
                note: note,
                category: category,
                OnChangedRupee: (rupee) =>
                    setState(() => this.rupee = rupee.toInt()),
                OnChangedCategory: (note) => setState(() => this.note = note),
                OnChangedNote: (category) =>
                    setState(() => this.category = category))),
      );

  Widget buildButton() {
    final isFormValid = note.isNotEmpty && category.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.expense != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final expense = widget.expense!.copy(
      category: category,
      note: note,
      createdtime: DateTime.now(),
      rupee: rupee,
    );

    await ExpenseDatabase.instance.update(expense);
  }

  Future addNote() async {
    final expense = Expense(
        category: category,
        note: note,
        createdtime: DateTime.now(),
        rupee: rupee);

    await ExpenseDatabase.instance.create(expense);
  }
}
