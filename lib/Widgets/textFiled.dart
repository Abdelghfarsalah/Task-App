import 'package:flutter/material.dart';

class textFoemfiled extends StatelessWidget {
  final Icon prefixIcon;
  final Icon? suffixIcon;
  final String label;
  final TextEditingController? controller;
  final String hint;
  final void Function()? onTap;
  final Function? onchanged;
  final String? Function(String?)?  valitator;
  final TextInputType texttype;
  const textFoemfiled(
      {super.key,
      required this.texttype,
      this.controller,
      this.onTap,
      required this.hint,
      required this.label,
      this.onchanged,
      required this.prefixIcon,
      this.suffixIcon,
      required this.valitator});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: valitator,
      keyboardType: texttype,
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        label: Text(label),
        
        hintText: hint,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.black,
        border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
