import 'dart:math';

import 'package:flutter/material.dart';

class FontSizes {
  final double baseFontSize; // Base font size (body text size)

  FontSizes({required this.baseFontSize});

  // Factory method to create FontSizes based on BuildContext
  factory FontSizes.fromContext(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate base font size based on screen width
    final double baseFontSize = screenWidth * 0.04; // Adjust this multiplier as needed
    return FontSizes(baseFontSize: baseFontSize);
  }

  // Generate a smaller font size based on a scaling factor
  double smallerFontSize(int level) {
    // Use exponential scaling for smaller sizes
    return baseFontSize * pow(0.9, level); // Adjust 0.9 for different scaling
  }

  // Generate a larger font size based on a scaling factor
  double largerFontSize(int level) {
    // Use exponential scaling for larger sizes
    return baseFontSize * pow(1.1, level); // Adjust 1.1 for different scaling
  }
}