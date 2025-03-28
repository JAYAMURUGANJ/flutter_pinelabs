import 'package:flutter/material.dart';

class CustomButtonTerminal extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Duration animationDuration;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomButtonTerminal({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.animationDuration,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 15,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(buttonText, style: TextStyle(color: textColor)),
      ),
    );
  }
}
