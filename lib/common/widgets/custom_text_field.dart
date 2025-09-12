import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.keyboardType,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        if (widget.keyboardType == TextInputType.emailAddress &&
            !EmailValidator.validate(value)) {
          return 'Enter a valid email address';
        }

        return null;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.only(top: 14),
        prefixIcon: Icon(widget.icon),
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
