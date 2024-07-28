import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class SkipTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SkipTextButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 14.dp,
            ),
          ),
        ),
      ],
    );
  }
}
