import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.errorText,
    this.keyboardType,
    this.obscureText = false,
    this.prefix,
    this.suffix,
    this.textInputAction,
    this.validator,
    this.onSaved,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final String? hint;
  final String? errorText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        border: const OutlineInputBorder(),
        suffixIcon: suffix,
        prefixIcon: loadPrefixIcon(prefix),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: hint,
        errorText: errorText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.grey),
      ),
    );
  }

  loadPrefixIcon(prefix) {
    if (prefix != null) {
      return prefix;
    }
  }
}
