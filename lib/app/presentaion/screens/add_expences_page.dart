import 'package:expence_tracker/app/domain/entity/expence_entity.dart';
import 'package:expence_tracker/app/presentaion/controllers/expence_controllers.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddExpensePage extends StatelessWidget {
  final ExpenseEntity? expense;

  AddExpensePage({this.expense});

  @override
  Widget build(BuildContext context) {
    final ExpenseController controller = Get.find<ExpenseController>();

    // Initialize text controllers with existing expense data if available
    final TextEditingController descriptionController = TextEditingController(text: expense?.description ?? '');
    final TextEditingController amountController = TextEditingController(text: expense?.amount.toString() ?? '');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          expense != null ? 'Edit Expense' : 'Add Expense',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTypeSelector(context, controller),
            SizedBox(height: 16.0),
            _buildDescriptionField(controller, descriptionController),
            SizedBox(height: 16.0),
            _buildAmountField(controller, amountController),
            SizedBox(height: 16.0),
            _buildDateSelector(context, controller),
            SizedBox(height: 16.0),
            _buildSaveButton(controller, descriptionController, amountController),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelector(BuildContext context, ExpenseController controller) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton(
        onPressed: () => _showTypeDialog(context, controller),
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(controller.selectedType.value),
            Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
        )),
      ),
    );
  }

  void _showTypeDialog(BuildContext context, ExpenseController controller) async {
    final newValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (String value in ['Food', 'Transport', 'Entertainment', 'Other'])
                ListTile(
                  title: Text(value),
                  onTap: () {
                    Get.back(result: value);
                  },
                ),
            ],
          ),
        );
      },
    );
    if (newValue != null) {
      controller.updateSelectedType(newValue);
    }
  }

  Widget _buildDescriptionField(ExpenseController controller, TextEditingController descriptionController) {
    return Container(
      height: 45,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: descriptionController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 5, left: 10),
          hintText: 'Description',
          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField(ExpenseController controller, TextEditingController amountController) {
    return Container(
      height: 45,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: amountController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 5, left: 10),
          hintText: 'Amount',
          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, ExpenseController controller) {
    return InkWell(
      onTap: () => _pickDate(context, controller),
      child: Container(
        height: 45,
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Selected Date:',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            Text(
              '${controller.selectedDate.value.day}-${controller.selectedDate.value.month}-${controller.selectedDate.value.year}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ],
        )),
      ),
    );
  }

  void _pickDate(BuildContext context, ExpenseController controller) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      controller.updateSelectedDate(pickedDate);
    }
  }

  Widget _buildSaveButton(ExpenseController controller, TextEditingController descriptionController, TextEditingController amountController) {
    return InkWell(
      onTap: () => _saveExpense(controller, descriptionController, amountController),
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: double.infinity,
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
          border: Border.all(
            width: 1.5,
            color: Colors.white,
          ),
        ),
        child: Text(
          expense != null ? 'Save Changes' : 'Add Expense',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  void _saveExpense(ExpenseController controller, TextEditingController descriptionController, TextEditingController amountController) {
    final description = descriptionController.text;
    final amount = double.tryParse(amountController.text) ?? 0.0;

    if (expense != null) {
      final updatedExpense = expense!.copyWith(
        description: description,
        amount: amount,
        date: controller.selectedDate.value,
        type: controller.selectedType.value,
      );
      controller.updateExpense(updatedExpense);
    } else {
      final newExpense = ExpenseEntity(
        description: description,
        amount: amount,
        date: controller.selectedDate.value,
        type: controller.selectedType.value,
      );
      controller.addExpense(description, amount);
    }

    Get.back();
  }
}
