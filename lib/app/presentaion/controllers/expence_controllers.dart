// lib/app/presentation/controllers/expense_controller.dart

import 'package:expence_tracker/app/domain/entity/expence_entity.dart';
import 'package:expence_tracker/app/domain/use_case/add_expence.dart';
import 'package:expence_tracker/app/domain/use_case/delete_expence.dart';
import 'package:expence_tracker/app/domain/use_case/get_expence.dart';
import 'package:expence_tracker/app/domain/use_case/update_expence.dart';

import 'package:expence_tracker/app/domain/notification/notification_service.dart';
import 'package:flutter/material.dart';
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

 void saveExpense(
      {required ExpenseEntity? expense,
      required TextEditingController descriptionController,
      required TextEditingController amountController}) {
    final description = descriptionController.text;
    final amount = double.tryParse(amountController.text) ?? 0.0;

    if (expense != null) {
      final updatedExpense = expense.copyWith(
        description: description,
        amount: amount,
        date: selectedDate.value,
        type: selectedType.value,
      );
      updateExpense(updatedExpense);
    } else {
      final newExpense = ExpenseEntity(
        description: description,
        amount: amount,
        date: selectedDate.value,
        type: selectedType.value,
      );
      addExpense(newExpense.description, newExpense.amount);
    }

    Get.back();
  }
  



    Future<void> pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }
}
