import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef MyValidator = String? Function (String?);

class CustomFormField extends StatelessWidget {
  String label;
  bool isPassword;
  TextInputType keyboardType ;
  MyValidator validator;
  TextEditingController controller;
  CustomFormField({
    required this.label,
    required this.validator,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        //hintText: 'ddd'
      ),
    );
  }
}
