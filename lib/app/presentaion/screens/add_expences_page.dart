import 'package:expence_tracker/app/domain/entity/expence_entity.dart';
import 'package:expence_tracker/app/presentaion/controllers/expence_controllers.dart';
import 'package:expence_tracker/app/presentaion/screens/widgets/constants.dart';
import 'package:expence_tracker/app/presentaion/screens/widgets/custom_appbar_widget.dart';
import 'package:expence_tracker/app/presentaion/screens/widgets/custom_formfield_widget.dart';
import 'package:expence_tracker/app/presentaion/screens/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpensePage extends StatelessWidget {
  final ExpenseEntity? expense;

  AddExpensePage({this.expense});

  @override
  Widget build(BuildContext context) {
    final ExpenseController controller = Get.find<ExpenseController>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController descriptionController =
        TextEditingController(text: expense?.description ?? '');
    final TextEditingController amountController =
        TextEditingController(text: expense?.amount.toString() ?? '');

    return Scaffold(
      backgroundColor: kwhite,
      appBar: CustomAppBar(
        titleText: expense != null ? 'Edit Expense' : 'Add Expense',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTypeSelector(context, controller),
              kheight22,
              CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                controller: descriptionController,
                keyboardType: TextInputType.text,
                hintText: 'Description',
              ),
              kheight16,
              CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Amount';
                  }
                  return null;
                },
                controller: amountController,
                keyboardType: TextInputType.number,
                hintText: 'Amount',
              ),
              kheight16,
              _buildDateSelector(context, controller),
              kheight22,
              CustomButtonWidget(
                buttonText: expense != null ? 'Save Changes' : 'Add Expense',
                navigateTo: () {
                  if (_formKey.currentState!.validate()) {
                    controller.saveExpense(
                      expense: expense,
                      descriptionController: descriptionController,
                      amountController: amountController,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelector(
      BuildContext context, ExpenseController controller) {
    return Container(
      height: 50,
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

  void _showTypeDialog(
      BuildContext context, ExpenseController controller) async {
    final newValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (String value in [
                'Food',
                'Transport',
                'Entertainment',
                'Other'
              ])
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

  Widget _buildDateSelector(
      BuildContext context, ExpenseController controller) {
    return InkWell(
      onTap: () => controller.pickDate(context),
      child: Container(
        height: 50,
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
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            )),
      ),
    );
  }
}
