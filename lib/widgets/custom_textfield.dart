import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function validator;
  final Function onSaved;
  final IconButton suffixIcon;
  final bool isPassword;
  final bool isEmail;
  final focus;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.focus,
    this.isPassword = false,
    this.isEmail = false,
    this.labelText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        focusNode: focus,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.solid,
            ),
          ),
          labelText: labelText,
          filled: true,
          suffixIcon: this.suffixIcon,
          fillColor: Color(0xFFEEEEF3),
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
