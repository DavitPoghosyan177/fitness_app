import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;  // Validator function added

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.validator,  // Pass the validator function
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(  // Changed to TextFormField
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        suffixStyle: const TextStyle(color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: validator,  // Apply the validator function
    );
  }
}
