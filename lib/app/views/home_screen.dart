import 'package:expence_tracker/app/db/expence_db.dart';
import 'package:expence_tracker/app/model.dart/expence_model.dart';
import 'package:expence_tracker/app/notification/notification_service.dart';
import 'package:expence_tracker/app/views/users_expence_summery.dart';
import 'package:flutter/material.dart';

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  @override
  void initState() {
    // TODO: implement initStateR
    super.initState();
     NotificationService().init();
  NotificationService().scheduleDailyNotification(20, 0);
    _fetchExpenses();
  }

  List<Expense> _expenses = [];
  void _fetchExpenses() async {
    final expenses = await DatabaseHelper.instance.readAllExpenses();
    setState(() {
      _expenses = expenses;
    });
  }



  void _deleteExpense(int id) async {
    await DatabaseHelper.instance.delete(id);
    setState(() {
      _fetchExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            NotificationService().cancelNotifications();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Notifications canceled')),
            );
          },
        ),
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ExpenseSummaryScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (ctx, index) {
                final expense = _expenses[index];
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
                        onPressed: () => _deleteExpense(expense.id!),
                      ),
                    ],
                  ),
                );
              },
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
    String selectedType = 'Other'; // Default type

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
                  setState(() {
                    selectedType = newValue!;
                  });
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
                    setState(() {
                      selectedDate = pickedDate;
                    });
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
                _addExpense(description, amount, selectedDate, selectedType);
                Navigator.of(ctx).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addExpense(
      String description, double amount, DateTime date, String type) async {
    final newExpense = Expense(
        description: description, amount: amount, date: date, type: type);
    await DatabaseHelper.instance.create(newExpense);
    _fetchExpenses(); // Refresh the list after adding a new expense
  }
}
