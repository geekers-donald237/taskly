import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class BuildTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType inputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final Color fillColor;
  final Color hintColor;
  final int? maxLength;
  final Function onChange;

  const BuildTextField(
      {super.key,
        required this.hint,
        this.controller,
        required this.inputType,
        this.prefixIcon,
        this.suffixIcon,
        this.obscureText = false,
        this.enabled = true,
        this.fillColor = const Color(0xffffffff),
        this.hintColor = const Color(0xff8D9091),
        this.maxLength,
        required this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        onChange(value);
      },
      validator: (val) => val!.isEmpty ? 'required' : null,
      keyboardType: inputType,
      obscureText: obscureText,
      maxLength: maxLength,
      maxLines: inputType == TextInputType.multiline ? 3 : 1,
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        counterText: "",
        fillColor: fillColor,
        filled: true,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize: 14.dp,
          fontWeight: FontWeight.w300,
          color: hintColor,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorStyle:  TextStyle(
          fontSize: 14.dp,
          fontWeight: FontWeight.normal,
          color: Colors.red,
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 0, color: fillColor),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(width: 0, color: Theme.of(context).colorScheme.onSurface),
        ),
        border:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 0, color: Theme.of(context).colorScheme.onSurface)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: Colors.red)),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.onSurface)),
        focusColor: Theme.of(context).colorScheme.onPrimary,
        hoverColor: Theme.of(context).colorScheme.onPrimary,
      ),
      cursorColor: Theme.of(context).primaryColor,
      style:  TextStyle(
        fontSize: 14.dp,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    );
  }
}