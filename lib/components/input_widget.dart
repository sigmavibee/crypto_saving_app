import 'package:flutter/material.dart';

class InputLayout extends StatelessWidget {
  String label;
  StatefulWidget inputField;

  InputLayout(
    this.label,
    this.inputField, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          child: inputField,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

InputDecoration customInputDecoration(String hintText, {Widget? suffixIcon}) {
  return InputDecoration(
      hintText: hintText,
      suffixIcon: suffixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
}
