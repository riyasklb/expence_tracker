import 'package:flutter/material.dart';
import 'constants.dart'; // Assuming kwhite is defined here

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final List<Widget>? actions; // Change to List<Widget>?

  CustomAppBar({
    required this.titleText,
    this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kwhite,
      title: Text(
        titleText,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
      ),
      actions: actions ?? [], // Use empty list as default if actions is null
    );
  }
}
