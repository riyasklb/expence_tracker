import 'package:get/get.dart';
import 'package:expence_tracker/app/domain/db/expence_db.dart';
import 'package:expence_tracker/app/data/model.dart/expence_model.dart';
import 'package:expence_tracker/app/domain/notification/notification_service.dart';

class ExpenseController extends GetxController {
  var expenses = <Expense>[].obs;
  final NotificationService notificationService = NotificationService();
  RxString selectedType = 'Other'.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

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

  void addExpense(String description, double amount) async {
    final newExpense = Expense(
      description: description,
      amount: amount,
      date: selectedDate.value,
      type: selectedType.value,
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

  void updateSelectedType(String newValue) {
    selectedType.value = newValue;
  }

  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }


}
