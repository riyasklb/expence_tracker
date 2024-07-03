import 'package:expence_tracker/app/data/reposities/expence_repository_impl.dart';

import 'package:expence_tracker/app/domain/notification/notification_service.dart';
import 'package:expence_tracker/app/domain/use_case/add_expence.dart';
import 'package:expence_tracker/app/domain/use_case/delete_expence.dart';
import 'package:expence_tracker/app/domain/use_case/get_expence.dart';
import 'package:expence_tracker/app/domain/use_case/update_expence.dart';

import 'package:expence_tracker/app/presentaion/controllers/expence_controllers.dart';
import 'package:expence_tracker/app/presentaion/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services and repositories
  final notificationService = NotificationService();
  await notificationService.init();

  final expenseRepository = ExpenseRepositoryImpl(); // Example repository implementation

  // Initialize use cases
  final addExpenseUseCase = AddExpense(expenseRepository);
  final deleteExpenseUseCase = DeleteExpense(expenseRepository);
  final getExpensesUseCase = GetExpenses(expenseRepository);
  final updateExpenseUseCase = UpdateExpense(expenseRepository);

  // Dependency Injection
  Get.lazyPut(() => ExpenseController(
        addExpenseUseCase: addExpenseUseCase,
        deleteExpenseUseCase: deleteExpenseUseCase,
        getExpensesUseCase: getExpensesUseCase,
        updateExpenseUseCase: updateExpenseUseCase,
      ));

  // Run the app
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExpenseListScreen(),
    );
  }
}
