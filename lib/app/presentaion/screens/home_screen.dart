import 'package:expence_tracker/app/presentaion/controllers/expence_controllers.dart';
import 'package:expence_tracker/app/presentaion/screens/users_expence_summery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ExpenseListScreen extends StatelessWidget {
  final ExpenseController expenseController = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              expenseController.cancelNotifications();
              Get.snackbar('Notifications', 'Notifications canceled');
            },
          ),
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              Get.to(() => ExpenseSummaryScreen());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: expenseController.expenses.length,
                itemBuilder: (ctx, index) {
                  final expense = expenseController.expenses[index];
                  return ListTile(
                    title: Text(expense.description),
                    subtitle: Text(
                        '${expense.type} - ${expense.date.toIso8601String()}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('\$${expense.amount.toStringAsFixed(2)}'),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              expenseController.deleteExpense(expense.id!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _showAddExpenseDialog(context),
              child: Text('Add Expense'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    final descriptionController = TextEditingController();
    final amountController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    String selectedType = 'Other';

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedType,
                onChanged: (newValue) {
                  selectedType = newValue!;
                },
                items: <String>['Food', 'Transport', 'Entertainment', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    selectedDate = pickedDate;
                  }
                },
                child: Text('Select Date'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final description = descriptionController.text;
                final amount = double.parse(amountController.text);
                expenseController.addExpense(
                    description, amount, selectedDate, selectedType);
                Navigator.of(ctx).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
