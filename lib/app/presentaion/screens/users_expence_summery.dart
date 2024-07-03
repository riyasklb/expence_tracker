// lib/app/presentation/screens/expense_summary_screen.dart

import 'package:expence_tracker/app/data/reposities/expence_repository_impl.dart';
import 'package:expence_tracker/app/domain/use_case/get_expence_summery_by_type.dart';
import 'package:expence_tracker/app/presentaion/controllers/expence_summary_controller.dart';
 // Import the implementation
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseSummaryScreen extends StatelessWidget {
  final ExpenseSummaryController controller = Get.put(
    ExpenseSummaryController(
      getExpensesSummaryByTypeUseCase: GetExpensesSummaryByType(
        ExpenseRepositoryImpl(), // Pass the repository implementation
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSummaryTitle(),
          _buildSummaryList(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Expense Summary',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      actions: [
        Obx(() => IconButton(
              icon: Icon(
                controller.isWeekly.value
                    ? Icons.calendar_view_month
                    : Icons.calendar_view_week,
              ),
              onPressed: controller.toggleSummaryType,
            )),
      ],
    );
  }

  Padding _buildSummaryTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => Text(
          controller.isWeekly.value ? 'Weekly Summary' : 'Monthly Summary',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Expanded _buildSummaryList() {
    return Expanded(
      child: Obx(
        () {
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
              return _buildSummaryItem(summary);
            },
          );
        },
      ),
    );
  }

  Padding _buildSummaryItem(Map<String, dynamic> summary) {
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
  }
}
