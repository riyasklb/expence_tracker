import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expence_tracker/app/domain/entity/expence_entity.dart';
import 'package:expence_tracker/app/presentaion/screens/add_expences_page.dart';

class ExpenseDetailsWidget extends StatelessWidget {
  final ExpenseEntity expense;

  ExpenseDetailsWidget({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${expense.date.day}/${expense.date.month}/${expense.date.year}',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
            ),
            SizedBox(height: 4),
            Text(
              '\$${expense.amount.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(width: 13),
        InkWell(
          onTap: () {
            Get.to(() => AddExpensePage(expense: expense));
          },
          child: Icon(Icons.edit, color: Colors.brown),
        ),
      ],
    );
  }
}
