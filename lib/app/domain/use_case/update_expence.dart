import 'package:expence_tracker/app/data/reposities/expence_repository.dart';

import 'package:expence_tracker/app/domain/entity/expence_entity.dart';


class UpdateExpense {
  final ExpenseRepository repository;

  UpdateExpense(this.repository);

  Future<void> call(ExpenseEntity expense) async {
    await repository.updateExpense(expense);
  }
}
