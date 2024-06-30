// views/expense_summary_screen.dart
import 'package:expence_tracker/app/presentaion/controllers/expence_summary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseSummaryScreen extends StatelessWidget {
  final ExpenseSummaryController controller =
      Get.put(ExpenseSummaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Expense Summary',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        actions: [
          Obx(() => IconButton(
                icon: Icon(controller.isWeekly.value
                    ? Icons.calendar_view_month
                    : Icons.calendar_view_week),
                onPressed: controller.toggleSummaryType,
              )),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => Text(
                  controller.isWeekly.value
                      ? 'Weekly Summary'
                      : 'Monthly Summary',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ),
         Expanded(
  child: Obx(() {
    final summaries = controller.isWeekly.value
        ? controller.weeklySummary
        : controller.monthlySummary;

    if (summaries.isEmpty) {
      return Center(
        child: Text(
          'No expenses to show.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }

    return ListView.builder(
      itemCount: summaries.length,
      itemBuilder: (ctx, index) {
        final summary = summaries[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
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
                summary['type'],
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              trailing: Text(
                '\$${summary['totalAmount'].toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        );
      },
    );
  }),
),

        ],
      ),
    );
  }
}
