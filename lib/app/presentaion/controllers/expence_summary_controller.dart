// controllers/expense_summary_controller.dart
import 'package:get/get.dart';
import '../../domain/db/expence_db.dart';

class ExpenseSummaryController extends GetxController {
  var weeklySummary = <Map<String, dynamic>>[].obs;
  var monthlySummary = <Map<String, dynamic>>[].obs;
  var isWeekly = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWeeklySummary();
    fetchMonthlySummary();
  }

  void fetchWeeklySummary() async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));

    final summary = await DatabaseHelper.instance.readExpensesSummaryByType(startOfWeek, endOfWeek);
    weeklySummary.value = summary;
  }

  void fetchMonthlySummary() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    final summary = await DatabaseHelper.instance.readExpensesSummaryByType(startOfMonth, endOfMonth);
    monthlySummary.value = summary;
  }

  void toggleSummaryType() {
    isWeekly.value = !isWeekly.value;
  }
}
