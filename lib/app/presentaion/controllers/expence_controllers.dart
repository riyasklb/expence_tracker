// lib/app/presentation/controllers/expense_controller.dart

import 'package:expence_tracker/app/domain/entity/expence_entity.dart';
import 'package:expence_tracker/app/domain/use_case/add_expence.dart';
import 'package:expence_tracker/app/domain/use_case/delete_expence.dart';
import 'package:expence_tracker/app/domain/use_case/get_expence.dart';
import 'package:expence_tracker/app/domain/use_case/update_expence.dart';

import 'package:expence_tracker/app/domain/notification/notification_service.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  var expenses = <ExpenseEntity>[].obs;
  final NotificationService notificationService = NotificationService();
  final AddExpense addExpenseUseCase;
  final DeleteExpense deleteExpenseUseCase;
  final GetExpenses getExpensesUseCase;
  final UpdateExpense updateExpenseUseCase;

  RxString selectedType = 'Other'.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  ExpenseController({
    required this.addExpenseUseCase,
    required this.deleteExpenseUseCase,
    required this.getExpensesUseCase,
    required this.updateExpenseUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    notificationService.init();
    notificationService.scheduleDailyNotification(20, 0);
    fetchExpenses();
  }

  void fetchExpenses() async {
    final result = await getExpensesUseCase();
    expenses.assignAll(result);
  }

  void addExpense(String description, double amount) async {
    final newExpense = ExpenseEntity(
      description: description,
      amount: amount,
      date: selectedDate.value,
      type: selectedType.value,
    );
    await addExpenseUseCase(newExpense);
    fetchExpenses();
  }

  void deleteExpense(int id) async {
    await deleteExpenseUseCase(id);
    fetchExpenses();
  }

  void cancelNotifications() {
    notificationService.cancelNotifications();
  }

  void updateSelectedType(String newValue) {
    selectedType.value = newValue;
  }

  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void updateExpense(ExpenseEntity updatedExpense) async {
    await updateExpenseUseCase(updatedExpense);
    fetchExpenses();
  }
}
