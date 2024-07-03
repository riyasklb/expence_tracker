// lib/app/domain/usecases/get_expenses_summary_by_type.dart

import 'package:expence_tracker/app/data/reposities/expence_repository.dart';


class GetExpensesSummaryByType {
  final ExpenseRepository repository;

  GetExpensesSummaryByType(this.repository);

  Future<List<Map<String, dynamic>>> call(DateTime startDate, DateTime endDate) async {
    return await repository.getExpensesSummaryByType(startDate, endDate);
  }
}
