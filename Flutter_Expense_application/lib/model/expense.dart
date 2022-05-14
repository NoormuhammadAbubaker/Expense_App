//create table to store over data in field
const String tableNote = 'expenses';

class ExpenseField {
  static final List<String> values = [
    //add all field
    id, category, note, time, rupee
  ];

  static const String id = '_id';
  static const String category = 'category';
  static const String note = 'note';
  static const String time = 'time';
  static const String rupee = 'rupee';
}

class Expense {
  final int? id;
  final String category;
  final String note;
  final DateTime createdtime;
  final int rupee;
  const Expense(
      {this.id,
      required this.category,
      required this.note,
      required this.createdtime,
      required this.rupee});

  Expense copy({
    int? id,
    int? rupee,
    String? category,
    String? note,
    DateTime? createdtime,
  }) =>
      Expense(
          id: id ?? this.id,
          rupee: rupee ?? this.rupee,
          category: category ?? this.category,
          note: note ?? this.note,
          createdtime: createdtime ?? this.createdtime);

  static Expense fromJson(Map<String, Object?> json) => Expense(
      id: json[ExpenseField.id] as int?,
      category: json[ExpenseField.category] as String,
      note: json[ExpenseField.note] as String,
      rupee: json[ExpenseField.rupee] as int,
      createdtime: DateTime.parse(json[ExpenseField.time] as String));
  Map<String, Object?> toJson() => {
        ExpenseField.id: id,
        ExpenseField.category: category,
        ExpenseField.note: note,
        ExpenseField.rupee: rupee,
        ExpenseField.time: createdtime.toString(),
      };
}
