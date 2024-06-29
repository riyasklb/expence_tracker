import 'package:expence_tracker/app/model.dart/expence_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

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
    version: 2, // Increment the version number
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


  Future<Expense> create(Expense expense) async {
    final db = await instance.database;

    final id = await db.insert('expenses', expense.toMap());
    return expense.copyWith(id: id);
  }

  Future<Expense> readExpense(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'expenses',
      columns: ['id', 'description', 'amount', 'date', 'type'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Expense.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Expense>> readAllExpenses() async {
    final db = await instance.database;

    final result = await db.query('expenses');

    return result.map((json) => Expense.fromMap(json)).toList();
  }

  Future<int> update(Expense expense) async {
    final db = await instance.database;

    return db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Expense>> readExpensesByDateRange(DateTime startDate, DateTime endDate) async {
    final db = await instance.database;

    final result = await db.query(
      'expenses',
      where: 'date >= ? AND date <= ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
    );

    return result.map((json) => Expense.fromMap(json)).toList();
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
