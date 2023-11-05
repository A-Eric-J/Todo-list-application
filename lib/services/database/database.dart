import 'dart:async';
import 'dart:developer';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_application/models/todo_list.dart';

class TodoListDatabase {
  TodoListDatabase._();

  static final TodoListDatabase db = TodoListDatabase._();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initTables();
    return _database!;
  }

  /// initializing tables of database
  Future<Database> initTables() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, 'TodoList.db');
    return await openDatabase(path,
        version: 1,
        onOpen: (db) {},
        onCreate: (db, version) => _onCreateTable(db));
  }

  static void _onCreateTable(Database db) {
    /// TodoList Table
    db.execute('CREATE TABLE TodoList ('
        'id INTEGER PRIMARY KEY,'
        'text TEXT,'
        'isChecked BIT'
        ')');
  }

  /// *** Insert

  Future<int> insertTodoList(TodoList todoList) async {
    final db = await database;

    /// getting the biggest id in the table
    var table = await db.rawQuery('SELECT MAX(id)+1 as id FROM TodoList');
    dynamic id = table.first['id'];

    /// inserting to the table using the new id
    var raw = await db.rawInsert(
        'INSERT Into TodoList (id,guId,rssFeedLink)'
        ' VALUES (?,?,?)',
        <dynamic>[
          id,
          todoList.text,
          todoList.isChecked,
        ]);
    return raw;
  }

  /// *** Delete
  Future<int> deleteTodoCard(TodoList todoList) async {
    final db = await database;
    return db
        .delete('TodoList', where: 'id = ?', whereArgs: <dynamic>[todoList.id]);
  }

  /// *** Update

  Future<int> updateTodoCard(TodoList todoList) async {
    log('updatePodcast in database');
    final db = await database;
    var res = await db.update('TodoList', todoList.toJson(),
        where: 'id = ?', whereArgs: <dynamic>[todoList.id]);
    return res;
  }

  /// *** Queries
}
