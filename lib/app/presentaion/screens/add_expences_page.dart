import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expence_tracker/app/presentaion/controllers/expence_controllers.dart';

class AddExpensePage extends StatelessWidget {
  final ExpenseController expenseController = Get.put(ExpenseController());
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Expense',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: GetBuilder<ExpenseController>(
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextButton(
                  onPressed: () async {
                    final newValue = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select Type'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              for (String value
                                  in ['Food', 'Transport', 'Entertainment', 'Other'])
                                ListTile(
                                  title: Text(value),
                                  onTap: () {
                                    Get.back(result: value); // Use Get for navigation
                                  },
                                ),
                            ],
                          ),
                        );
                      },
                    );
                    if (newValue != null) {
                      controller.updateSelectedType(newValue); // Update controller state
                    }
                  },
                  child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.selectedType.value), // Display selected value
                      Icon(Icons.arrow_drop_down,
                          color: Colors.black), // Dropdown icon
                    ],
                  )),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 45,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                    hintText: 'Description',
                    hintStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    labelStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
              ),
              SizedBox(height: 16.0),
              Container(
                height: 45,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                    hintText: 'Amount',
                    hintStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    labelStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    controller.updateSelectedDate(pickedDate); // Update controller state
                  }
                },
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
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${controller.selectedDate.value.day}-${controller.selectedDate.value.month}-${controller.selectedDate.value.year}',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black),
                      ),
                    ],
                  )),
                ),
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () {
                  final description = descriptionController.text;
                  final amount =
                      double.tryParse(amountController.text) ?? 0.0;
                  controller.addExpense(description, amount);

                  Get.back(); // Close the page using GetX
                },
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
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  child: Text(
                    'Add Expense',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
