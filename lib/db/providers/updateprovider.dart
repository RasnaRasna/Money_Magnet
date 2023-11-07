import 'package:flutter/material.dart';

class updateprovider extends ChangeNotifier {
  Widget textfield({
    required TextEditingController fieldcontroller,
    String? hintText,
    String? labelText,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: fieldcontroller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText, labelText: labelText, border: InputBorder.none),
    );
  }
}
