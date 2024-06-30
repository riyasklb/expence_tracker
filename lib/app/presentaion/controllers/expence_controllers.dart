import 'package:expence_tracker/app/data/model.dart/expence_model.dart';
import 'package:expence_tracker/app/domain/db/expence_db.dart';
import 'package:expence_tracker/app/domain/notification/notification_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ExpenseController extends GetxController {
  var expenses = <Expense>[].obs;
  final NotificationService notificationService = NotificationService();
 // DatabaseHelper databaseHelper = DatabaseHelper.instance;
  RxString selectedType = 'Other'.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    notificationService.init();
    notificationService.scheduleDailyNotification(20, 0);
    fetchExpenses();
  }

   fetchExpenses() async {
    final result = await  DatabaseHelper.instance.readAllExpenses();
    expenses.assignAll(result);
  }

  void addExpense(String description, double amount) async {
    final newExpense = Expense(
      description: description,
      amount: amount,
      date: selectedDate.value,
      type: selectedType.value,
    );
    await  DatabaseHelper.instance.create(newExpense);
    fetchExpenses();
  }

  void deleteExpense(int id) async {
    await  DatabaseHelper.instance.delete(id);
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
  void updateExpense(Expense updatedExpense) async {
  await DatabaseHelper.instance.update(updatedExpense);
  fetchExpenses();
}

}
