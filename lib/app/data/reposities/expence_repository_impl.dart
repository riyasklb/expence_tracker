// lib/app/data/repositories/expense_repository_impl.dart

import 'package:expence_tracker/app/data/data_source/data_base_helper.dart';

import 'package:expence_tracker/app/data/model/expence_model.dart';
import 'package:expence_tracker/app/data/reposities/expence_repository.dart';
import 'package:expence_tracker/app/domain/entity/expence_entity.dart';


class ExpenseRepositoryImpl implements ExpenseRepository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<void> addExpense(ExpenseEntity expense) async {
    await dbHelper.createExpense(ExpenseModel.fromEntity(expense));
  }

  @override
  Future<void> deleteExpense(int id) async {
    await dbHelper.deleteExpense(id);
  }

  @override
  Future<List<ExpenseEntity>> getExpenses() async {
    final expenses = await dbHelper.readAllExpenses();
    return expenses.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateExpense(ExpenseEntity expense) async {
    await dbHelper.updateExpense(ExpenseModel.fromEntity(expense));
  }

  @override
  Future<List<Map<String, dynamic>>> getExpensesSummaryByType(DateTime startDate, DateTime endDate) async {
    return await dbHelper.readExpensesSummaryByType(startDate, endDate);
  }
}
