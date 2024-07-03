import 'package:expence_tracker/app/data/data_source/data_base_helper.dart';
import 'package:expence_tracker/app/data/model/expence_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DatabaseHelper dbHelper;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    dbHelper = DatabaseHelper.instance; // Use the singleton instance

    // Initialize database for testing
    final db = await dbHelper.database;
    await db.execute('DELETE FROM expenses'); // Clear table before running tests
  });

  tearDownAll(() async {
    await dbHelper.close();
  });

  final expense = ExpenseModel(
    description: 'Test Expense',
    amount: 10.0,
    date: DateTime.now(),
    type: 'Other',
  );

  group('DatabaseHelper', () {
    test('createExpense and readExpense', () async {
      // Create Expense
      final id = await dbHelper.createExpense(expense);
      expect(id, isNonZero);

      // Read Expense
      final readExpense = await dbHelper.readExpense(id);
      expect(readExpense, isNotNull);
      expect(readExpense?.description, 'Test Expense');
      expect(readExpense?.amount, 10.0);
    });

    test('updateExpense', () async {
      // Create Expense
      final id = await dbHelper.createExpense(expense);

      // Update Expense
      final updatedExpense = ExpenseModel(
        id: id,
        description: 'Updated Expense',
        amount: 20.0,
        date: DateTime.now(),
        type: 'Food',
      );
      final rowsAffected = await dbHelper.updateExpense(updatedExpense);
      expect(rowsAffected, 1);

      // Read Expense
      final readExpense = await dbHelper.readExpense(id);
      expect(readExpense, isNotNull);
      expect(readExpense?.description, 'Updated Expense');
      expect(readExpense?.amount, 20.0);
    });

    test('deleteExpense', () async {
      // Create Expense
      final id = await dbHelper.createExpense(expense);

      // Delete Expense
      final rowsDeleted = await dbHelper.deleteExpense(id);
      expect(rowsDeleted, 1);

      // Verify Deletion
      final readExpense = await dbHelper.readExpense(id);
      expect(readExpense, isNull);
    });

 
  });
}
