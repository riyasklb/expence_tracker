import 'package:expence_tracker/app/domain/db/expence_db.dart';
import 'package:expence_tracker/app/data/model.dart/expence_model.dart';
import 'package:get/get.dart';
import 'package:expence_tracker/app/domain/notification/notification_service.dart';

class ExpenseController extends GetxController {
  var expenses = <Expense>[].obs;
  final NotificationService notificationService = NotificationService();

  @override
  void onInit() {
    super.onInit();
    notificationService.init();
    notificationService.scheduleDailyNotification(20, 0);
    fetchExpenses();
  }

  void fetchExpenses() async {
    final result = await DatabaseHelper.instance.readAllExpenses();
    expenses.assignAll(result);
  }

  void addExpense(
      String description, double amount, DateTime date, String type) async {
    final newExpense = Expense(
      description: description,
      amount: amount,
      date: date,
      type: type,
    );
    await DatabaseHelper.instance.create(newExpense);
    fetchExpenses();
  }

  void deleteExpense(int id) async {
    await DatabaseHelper.instance.delete(id);
    fetchExpenses();
  }

  void cancelNotifications() {
    notificationService.cancelNotifications();
  }
}
