// lib/app/domain/usecases/add_expense.dart

import 'package:expence_tracker/app/data/reposities/expence_repository.dart';

import 'package:expence_tracker/app/domain/entity/expence_entity.dart';


class AddExpense {
  final ExpenseRepository repository;

  AddExpense(this.repository);

  Future<void> call(ExpenseEntity expense) async {
    return await repository.addExpense(expense);
  }
}
