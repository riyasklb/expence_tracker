import 'package:expence_tracker/app/presentaion/controllers/expence_controllers.dart';
import 'package:expence_tracker/app/presentaion/screens/add_expences_page.dart';

import 'package:expence_tracker/app/presentaion/screens/users_expence_summery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseListScreen extends StatelessWidget {
  final ExpenseController expenseController = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Track Your Expense',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.cancel),
          //   onPressed: () {
          //     expenseController.cancelNotifications();
          //     Get.snackbar('Notifications', 'Notifications canceled');
          //   },
          // ),
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
              () {
                final expenses = expenseController.expenses.toList();
                expenses.sort((a, b) =>
                    b.date.compareTo(a.date)); // Sort by date descending

                return expenses.isEmpty
                    ? Center(
                        child: Text('No expenses yet.'),
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: expenses.length,
                        itemBuilder: (ctx, index) {
                          final expense = expenses[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Dismissible(
                              key: Key(expense.id.toString()),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                expenseController.deleteExpense(expense.id!);
                                ScaffoldMessenger.of(ctx).showSnackBar(
                                  SnackBar(content: Text('Expense deleted')),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Text(
                                    expense.type,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${expense.description}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${expense.date.day}/${expense.date.month}/${expense.date.year}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '\$${expense.amount.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              AddExpensePage(expense: expense));
                                        },
                                        child: Icon(
                                          Icons.edit_document,
                                          color: Colors.brown,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Get.to(AddExpensePage());
              },
              child: Container(
                alignment: Alignment.center,
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white,
                  ),
                ),
                child: Text(
                  'Add Expense',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
