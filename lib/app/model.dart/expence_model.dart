class Expense {
  final int? id;
  final String description;
  final double amount;
  final DateTime date;
  final String type;

  Expense({
    this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      description: map['description'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      type: map['type'],
    );
  }

  Expense copyWith({
    int? id,
    String? description,
    double? amount,
    DateTime? date,
    String? type,
  }) {
    return Expense(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }
}
