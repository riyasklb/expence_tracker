// lib/app/domain/entity/expence_entity.dart

class ExpenseEntity {
  final int? id;
  final String description;
  final double amount;
  final DateTime date;
  final String type;

  ExpenseEntity({
    this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
  });

  // Adding copyWith method
  ExpenseEntity copyWith({
    int? id,
    String? description,
    double? amount,
    DateTime? date,
    String? type,
  }) {
    return ExpenseEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }
}
