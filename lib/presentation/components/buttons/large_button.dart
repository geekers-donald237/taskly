import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../core/services/utils/custom_sizer.dart';

class LargeButton extends StatelessWidget {
  final String titleText;
  final VoidCallback onPressed;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;

  const LargeButton({
    super.key,
    required this.titleText,
    required this.onPressed,
    this.borderColor = Colors.transparent,
    required this.backgroundColor,
    required this.textColor,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getHeight(6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.dp),
        border: Border.all(color: borderColor),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            titleText.toUpperCase(),
            style: TextStyle(color: textColor, fontSize: fontSize.dp),
          ),
        ),
      ),
    );
  }
}
