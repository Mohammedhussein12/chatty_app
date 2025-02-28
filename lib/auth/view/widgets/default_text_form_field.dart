import 'package:chatty_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/app_theme.dart';

class DefaultTextFormField extends StatefulWidget {
  const DefaultTextFormField(
      {super.key,
      required this.hintText,
      this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.maxLines = 1,
      this.isPassword = false,
      this.initialValue,
      this.onChanged});

  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? initialValue;
  final void Function(String)? onChanged;
  final bool isPassword;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool obscureText = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      cursorColor: AppTheme.white,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: Theme.of(context).textTheme.titleMedium,
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: obscureText
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined),
              )
            : null,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primary),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primary),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.red),
        ),
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: AppTheme.grey.withOpacity(0.9),
            ),
      ),
    );
  }
}
