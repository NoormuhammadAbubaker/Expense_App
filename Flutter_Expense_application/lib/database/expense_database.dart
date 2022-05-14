import 'package:flutter_application_expense/model/expense.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ExpenseDatabase {
  //2)for calling constructor create globel field
  static final ExpenseDatabase instance = ExpenseDatabase._init();
  //3 Crete new field for database
  static Database? _database; //Comes from sqflite package
  //1)create private constructor
  ExpenseDatabase._init();
  //4 open datatbase
  //Open connection to Db

  Future<Database> get database async {
    if (_database != null) return _database!; //If db exist, return current db
    _database = await _initDB('expense.db'); //else if not, create new db
    return _database!; //Return db for user later
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath(); //Get current db path
    //Can configure above to store the db on the seperate file path
    final path = join(dbPath, fileName);

    return await openDatabase(path,
        version: 1,
        onCreate:
            _createDB); //Create db according to file path and name it according to name input in constructor method, then return Db
    //openDatabase(path, version: 2, onCreate: _createDB , onUpgrade:); //Incrementing version and adding onUpgrade allows database schema to be updated when want to add new fields or so
  }

  Future _createDB(Database db, int version) async {
    //Initializing type for fields in db table
    const idType =
        'INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL'; //For Primary Key SQL
    const textType = 'TEXT ';
    //final boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER';

    //${NotesField}  accessed via class
    await db.execute('''
      CREATE TABLE $tableNote(
        ${ExpenseField.id} $idType,
        ${ExpenseField.note} $textType,
        ${ExpenseField.time} $textType,
        ${ExpenseField.category} $textType,
        ${ExpenseField.rupee} $integerType
      )
      '''); //Creating table and defining table schema
  }

  Future<Expense> create(Expense expense) async {
    //Gets reference to database
    final db = await instance.database;

    //Next 8 lines of code can be reduce to just, which is writing in query syntax --> final id = await db.insert(tableNotes, note.toJson());
    // final json = note.toJson();
    // final columns =
    //     '${NotesField.title}, ${NotesField.description}, ${NotesField.time}';
    // final values =
    //     '${json[NotesField.title]}, ${json[NotesField.description]}, ${json[NotesField.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    //db.insert(table, values) table = name of table to put, values = data to put inside
    final id = await db.insert(tableNote,
        expense.toJson()); //insert to db after convert to json object
    //after inserting data, db a unique auto generate id value;
    return expense.copy(
        id: id); //create current note object then only modify the id
  }

  Future<Expense> readNote(int id) async {
    //Single note
    final db = await instance.database;

    final maps = await db.query(
      tableNote, //Put in all the tables that you want to query
      columns: ExpenseField.values,
      where: '${ExpenseField.id} = ?',
      whereArgs: [id], //Helps prevent SQL injection, more secure approach
    );

    if (maps.isNotEmpty) {
      return Expense.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //Get collection of notes
  Future<List<Expense>> readAllNotes() async {
    final db = await instance.database;

    const orderBy = '${ExpenseField.time} ASC'; //ASC = sort ascending
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy'); SQL syntax

    final res = await db.query(tableNote,
        orderBy:
            orderBy); //Call all the object since we want all rather than individual row

    return res.map((json) => Expense.fromJson(json)).toList();
  }

  //Update statement
  Future<int> update(Expense expense) async {
    final db = await instance.database;
    return db.update(
      tableNote,
      expense.toJson(),
      where: '${ExpenseField.id} = ?',
      whereArgs: [expense.id],
    );
  }

  //Delete
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableNote,
      where: '${ExpenseField.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database; //get current database
    db.close(); //close connection with current db
  }
}
