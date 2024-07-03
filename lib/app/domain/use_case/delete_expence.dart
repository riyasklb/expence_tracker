// lib/app/domain/usecases/delete_expense.dart

import 'package:expence_tracker/app/data/reposities/expence_repository.dart';


class DeleteExpense {
  final ExpenseRepository repository;

  DeleteExpense(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteExpense(id);
  }
}
