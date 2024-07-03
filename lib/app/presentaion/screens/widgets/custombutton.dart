import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback navigateTo;

  CustomButtonWidget({required this.buttonText, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigateTo,
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
          buttonText,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
