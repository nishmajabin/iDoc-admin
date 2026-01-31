import 'package:flutter/material.dart';
import 'package:idoc_admin_side/core/constants/color.dart';
import 'package:idoc_admin_side/core/utils/validators.dart';

enum TextFieldType { username, password }

class LoginTextField extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final IconData icon;
  final TextFieldType fieldType;
  final bool isPasswordVisible;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onToggleVisibility;

  const LoginTextField({
    Key? key,
    required this.initialValue,
    required this.hintText,
    required this.icon,
    required this.fieldType,
    this.isPasswordVisible = true,
    required this.onChanged,
    this.onFieldSubmitted,
    this.onToggleVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPassword = fieldType == TextFieldType.password;

    return TextFormField(
      initialValue: initialValue,
      obscureText: isPassword ? isPasswordVisible : false,
      keyboardType: isPassword
          ? TextInputType.text
          : TextInputType.emailAddress,
      textInputAction: isPassword
          ? TextInputAction.done
          : TextInputAction.next,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(25.0),
        ),
        prefixIcon: Icon(icon, size: 23, color: primaryColor),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: onToggleVisibility,
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: primaryColor,
                ),
              )
            : null,
      ),
      validator: isPassword
          ? Validators.passwordValidator
          : (value) => Validators.nameValidator(value, 'Username'),
    );
  }
}