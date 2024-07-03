// lib/app/domain/repositories/expense_repository.dart


import 'package:expence_tracker/app/domain/entity/expence_entity.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(ExpenseEntity expense);
  Future<void> deleteExpense(int id);
  Future<List<ExpenseEntity>> getExpenses();
  Future<void> updateExpense(ExpenseEntity expense);
  Future<List<Map<String, dynamic>>> getExpensesSummaryByType(DateTime startDate, DateTime endDate);  // Add this method
}
