import 'package:expence_tracker/app/db/expence_db.dart';
import 'package:flutter/material.dart';


class ExpenseSummaryScreen extends StatefulWidget {
  @override
  _ExpenseSummaryScreenState createState() => _ExpenseSummaryScreenState();
}

class _ExpenseSummaryScreenState extends State<ExpenseSummaryScreen> {
  List<Map<String, dynamic>> _weeklySummary = [];
  List<Map<String, dynamic>> _monthlySummary = [];
  bool _isWeekly = true;

  @override
  void initState() {
    super.initState();
    _fetchWeeklySummary();
    _fetchMonthlySummary();
  }

  void _fetchWeeklySummary() async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));

    final summary = await DatabaseHelper.instance.readExpensesSummaryByType(startOfWeek, endOfWeek);
    setState(() {
      _weeklySummary = summary;
    });
  }

  void _fetchMonthlySummary() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    final summary = await DatabaseHelper.instance.readExpensesSummaryByType(startOfMonth, endOfMonth);
    setState(() {
      _monthlySummary = summary;
    });
  }

  void _toggleSummaryType() {
    setState(() {
      _isWeekly = !_isWeekly;
    });
  }

  @override
  Widget build(BuildContext context) {
    final summaries = _isWeekly ? _weeklySummary : _monthlySummary;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Summary'),
        actions: [
          IconButton(
            icon: Icon(_isWeekly ? Icons.calendar_view_month : Icons.calendar_view_week),
            onPressed: _toggleSummaryType,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _isWeekly ? 'Weekly Summary' : 'Monthly Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: summaries.length,
              itemBuilder: (ctx, index) {
                final summary = summaries[index];
                return ListTile(
                  title: Text(summary['type']),
                  trailing: Text('\$${summary['totalAmount'].toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
