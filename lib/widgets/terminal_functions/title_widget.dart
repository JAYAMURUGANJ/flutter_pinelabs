import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        'TRANSACTIONS',
        style: GoogleFonts.montserrat(
          decoration: TextDecoration.underline,
          color: Colors.blue,
          fontSize: 15.0,
          fontWeight: FontWeight.normal,
          decorationColor: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
