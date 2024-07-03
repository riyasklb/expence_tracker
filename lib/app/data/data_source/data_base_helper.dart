import 'package:expence_tracker/app/data/model/expence_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE expenses ADD COLUMN type TEXT NOT NULL DEFAULT "Other"');
    }
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE expenses (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description TEXT NOT NULL,
      amount REAL NOT NULL,
      date TEXT NOT NULL,
      type TEXT NOT NULL
    )
    ''');
  }

  Future<int> createExpense(ExpenseModel expense) async {
    final db = await instance.database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<ExpenseModel?> readExpense(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'expenses',
      columns: ['id', 'description', 'amount', 'date', 'type'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ExpenseModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<ExpenseModel>> readAllExpenses() async {
    final db = await instance.database;
    final result = await db.query('expenses');
    return result.map((json) => ExpenseModel.fromMap(json)).toList();
  }

  Future<int> updateExpense(ExpenseModel expense) async {
    final db = await instance.database;
    return await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> deleteExpense(int id) async {
    final db = await instance.database;
    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ExpenseModel>> readExpensesByDateRange(DateTime startDate, DateTime endDate) async {
    final db = await instance.database;
    final result = await db.query(
      'expenses',
      where: 'date >= ? AND date <= ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
    );
    return result.map((json) => ExpenseModel.fromMap(json)).toList();
  }

  Future<List<Map<String, dynamic>>> readExpensesSummaryByType(DateTime startDate, DateTime endDate) async {
    final db = await instance.database;
    final result = await db.rawQuery(
      'SELECT type, SUM(amount) as totalAmount FROM expenses WHERE date >= ? AND date <= ? GROUP BY type',
      [startDate.toIso8601String(), endDate.toIso8601String()],
    );
    return result;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
