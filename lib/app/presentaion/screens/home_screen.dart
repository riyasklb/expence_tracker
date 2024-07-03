import 'package:expence_tracker/app/data/reposities/expence_repository_impl.dart';
import 'package:expence_tracker/app/domain/entity/expence_entity.dart';
import 'package:expence_tracker/app/domain/use_case/add_expence.dart';
import 'package:expence_tracker/app/domain/use_case/delete_expence.dart';
import 'package:expence_tracker/app/domain/use_case/get_expence.dart';
import 'package:expence_tracker/app/domain/use_case/update_expence.dart';
import 'package:expence_tracker/app/presentaion/controllers/expence_controllers.dart';
import 'package:expence_tracker/app/presentaion/screens/add_expences_page.dart';
import 'package:expence_tracker/app/presentaion/screens/users_expence_summery.dart';
import 'package:expence_tracker/app/presentaion/screens/widgets/constants.dart';
import 'package:expence_tracker/app/presentaion/screens/widgets/custom_appbar_widget.dart';
import 'package:expence_tracker/app/presentaion/screens/widgets/custombutton.dart';
import 'package:expence_tracker/app/presentaion/screens/widgets/expence_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseListScreen extends StatelessWidget {
  final ExpenseController expenseController = Get.put(
    ExpenseController(
      addExpenseUseCase: AddExpense(ExpenseRepositoryImpl()),
      deleteExpenseUseCase: DeleteExpense(ExpenseRepositoryImpl()),
      getExpensesUseCase: GetExpenses(ExpenseRepositoryImpl()),
      updateExpenseUseCase: UpdateExpense(ExpenseRepositoryImpl()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: CustomAppBar(
        titleText: 'Track Your Expense',
        actions: [
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
          _buildExpenseList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButtonWidget(
              buttonText: 'Add Expense',
              navigateTo: () {
                Get.to(AddExpensePage());
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildExpenseList() {
    return Expanded(
      child: Obx(() {
        final expenses = expenseController.expenses.toList();
        expenses.sort((a, b) => b.date.compareTo(a.date));

        if (expenses.isEmpty) {
          return Center(child: Text('No expenses yet.'));
        } else {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: expenses.length,
            itemBuilder: (ctx, index) {
              return _buildExpenseItem(ctx, expenses[index]);
            },
          );
        }
      }),
    );
  }

  Widget _buildExpenseItem(BuildContext context, ExpenseEntity expense) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: Key(expense.id.toString()),
        background: _buildDismissibleBackground(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          expenseController.deleteExpense(expense.id!);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Expense deleted')),
          );
        },
        child: _buildExpenseCard(expense),
      ),
    );
  }

  Container _buildDismissibleBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Icon(Icons.delete, color: kwhite),
    );
  }

  Container _buildExpenseCard(ExpenseEntity expense) {
    return Container(
      decoration: BoxDecoration(
        color: kwhite,
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
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          expense.description,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        ),
        trailing:ExpenseDetailsWidget(expense: expense), 
      ),
    );
  }

 
}
