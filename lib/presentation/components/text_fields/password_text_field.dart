import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../../../core/services/utils/custom_sizer.dart';

class PasswordTextField extends StatefulWidget {
  final String label;
  final String placeholder;

  const PasswordTextField({
    Key? key,
    required this.label,
    required this.placeholder,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getHeight(4)),
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16.dp,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextField(
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
        SizedBox(height: getHeight(2)),
      ],
    );
  }
}
