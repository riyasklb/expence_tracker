import 'package:expence_tracker/app/data/reposities/expence_repository.dart';

import 'package:expence_tracker/app/domain/entity/expence_entity.dart';


class GetExpenses {
  final ExpenseRepository repository;

  GetExpenses(this.repository);

  Future<List<ExpenseEntity>> call() async {
    return await repository.getExpenses();
  }
}
