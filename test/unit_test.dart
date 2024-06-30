import 'package:expence_tracker/app/data/model.dart/expence_model.dart';
import 'package:expence_tracker/app/domain/db/expence_db.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late DatabaseHelper databaseHelper;

  setUpAll(() {
   
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    databaseHelper = DatabaseHelper.instance;
  });

  tearDownAll(() async {
    await databaseHelper.close();
  });

  setUp(() async {
  
    await databaseHelper.database;
  });

  test('should create an expense', () async {
    final expense = Expense(
      description: 'Groceries',
      amount: 50.0,
      date: DateTime.now(),
      type: 'Food',
    );

    final createdExpense = await databaseHelper.create(expense);

    expect(createdExpense.id, isNotNull);
    expect(createdExpense.description, 'Groceries');
  });

  test('should read all expenses', () async {
    final expenses = await databaseHelper.readAllExpenses();

    expect(expenses, isA<List<Expense>>());
  });

  test('should update an expense', () async {
    final expense = Expense(
      id: 1,
      description: 'Updated',
      amount: 75.0,
      date: DateTime.now(),
      type: 'Food',
    );

    final rowsAffected = await databaseHelper.update(expense);

    expect(rowsAffected, 0);
  });

  test('should delete an expense', () async {
    final expenseId = 0;

    final rowsDeleted = await databaseHelper.delete(expenseId);

    expect(rowsDeleted, 0);
  });

  test('should read expenses by date range', () async {
    final startDate = DateTime(2023, 1, 1);
    final endDate = DateTime.now();

    final expenses = await databaseHelper.readExpensesByDateRange(startDate, endDate);

    expect(expenses, isA<List<Expense>>());
  });

  test('should read expenses summary by type', () async {
    final startDate = DateTime(2023, 1, 1);
    final endDate = DateTime.now();

    final summary = await databaseHelper.readExpensesSummaryByType(startDate, endDate);

    expect(summary, isA<List<Map<String, dynamic>>>());
  });
}
