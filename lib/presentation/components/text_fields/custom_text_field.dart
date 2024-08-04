import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../../../core/services/utils/custom_sizer.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.placeholder,
    this.controller

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getHeight(4)),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.dp,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle:
                TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.onSecondary),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.surface),
            ),
          ),
        ),
        SizedBox(height: getHeight(0.5)),
      ],
    );
  }
}
