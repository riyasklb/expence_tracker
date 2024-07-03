// import 'package:expence_tracker/app/data/reposities/expence_repository_impl.dart';
// import 'package:expence_tracker/app/data/repositories/expense_repository_impl.dart';
// import 'package:expence_tracker/app/domain/use_case/add_expence.dart';
// import 'package:expence_tracker/app/domain/usecases/add_expense.dart';
// import 'package:expence_tracker/app/presentaion/controllers/expence_controllers.dart';
// import 'package:expence_tracker/app/presentation/controllers/expense_controller.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';

// void main() {
//   group('ExpenseController', () {
//     late ExpenseController controller;
//     late AddExpense addExpenseUseCase;

//     setUp(() {
//       final expenseRepository = ExpenseRepositoryImpl(); // Example repository implementation
//       addExpenseUseCase = AddExpense(expenseRepository);
//       controller = ExpenseController(addExpenseUseCase: addExpenseUseCase);

//       // Initialize GetX bindings manually
//       Get.testMode = true;
//     });

//     test('Initial state', () {
//       expect(controller.expenses.isEmpty, true);
//     });

//     test('Add expense', () async {
//       final initialCount = controller.expenses.length;
//       await controller.addExpense('Test Expense', 100.0);

//       expect(controller.expenses.length, initialCount + 1);
//     });

//     test('Delete expense', () async {
//       final initialCount = controller.expenses.length;

//       // Assuming you have a way to add an expense for deletion
//       await controller.addExpense('Expense to delete', 50.0);
//       final expenseToDelete = controller.expenses.firstWhere((expense) => expense.description == 'Expense to delete');

//       await controller.deleteExpense(expenseToDelete.id);

//       expect(controller.expenses.length, initialCount);
//     });
//   });
// }
