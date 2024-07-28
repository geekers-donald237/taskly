import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:taskly/core/utils/generics/custom_sizer.dart';

class CustomButton extends StatelessWidget {
  final String titleText;
  final VoidCallback onPressed;

  const CustomButton({
    required this.titleText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getHeight(20),
      height: getHeight(5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(4.dp),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            titleText,
            style: TextStyle(color: Colors.white, fontSize: 14.dp),
          ),
        ),
      ),
    );
  }
}
