
import 'package:expence_tracker/app/domain/entity/expence_entity.dart';

class ExpenseModel extends ExpenseEntity {
  ExpenseModel({
    int? id,
    required String description,
    required double amount,
    required DateTime date,
    required String type,
  }) : super(id: id, description: description, amount: amount, date: date, type: type);

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      description: map['description'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type,
    };
  }

  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
      id: entity.id,
      description: entity.description,
      amount: entity.amount,
      date: entity.date,
      type: entity.type,
    );
  }

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      description: description,
      amount: amount,
      date: date,
      type: type,
    );
  }
}
