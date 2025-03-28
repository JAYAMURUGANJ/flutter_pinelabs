import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RefNoInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final bool isEnabled;

  const RefNoInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]{1,15}$')),
      ],
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'BILLING REF NUMBER',
        hintStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          final RegExp regex = RegExp(r'^[a-zA-Z0-9]{1,15}$');
          if (!regex.hasMatch(value)) {
            return 'Only alphanumeric characters (max 15)';
          }
        }
        return null;
      },
    );
  }
}
