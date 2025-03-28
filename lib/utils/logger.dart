import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Logger {

  static void info(var message) {
    _log(message, LogLevel.info);
  }

  static void success(var message) {
    _log(message, LogLevel.success);
  }

  static void warning(var message) {
    _log(message, LogLevel.warning);
  }

  static void error(var message) {
    _log(message, LogLevel.error);
  }

  static void _log(var message, LogLevel level) {
    // if (kReleaseMode) return; // Disable logging in release mode

    var showMessage;
    if (message is Map || message is List) {
      showMessage = jsonEncode(message); // Convert JSON structures to string
    } else {
      showMessage = message.toString(); // Convert any other type to string
    }

    final logMessage = _getLogMessage(showMessage, level);
    debugPrint(logMessage);
  }

  static String _getLogMessage(String message, LogLevel level) {
    final currentTime = _getFormattedDateTime();
    final colorCode = _getColorCode(level);
    final methodName = _getMethodName();

    return '\x1B[${colorCode}m[$currentTime] [${level.toString().split('.').last.toUpperCase()}] ${message.toUpperCase()}\x1B[0m';
  }

  static String _getFormattedDateTime() {
    final now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} "
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  static String _getMethodName() {
    try {
      final stackTrace = StackTrace.current.toString().split('\n');
      if (stackTrace.length > 2) {
        final methodLine = stackTrace[4]; // Adjust index if needed
        final regex = RegExp(r'#\d+\s+[^\s]+\.(\w+)\s'); // Extracts method name only
        final match = regex.firstMatch(methodLine);
        if (match != null && match.groupCount > 0) {
          return match.group(1)?.toUpperCase() ?? 'UNKNOWN';
        }
      }
    } catch (e) {
      return 'UNKNOWN';
    }
    return 'UNKNOWN';
  }

  static String _getColorCode(LogLevel level) {
    switch (level) {
      case LogLevel.info:
        return '34'; // Blue
      case LogLevel.success:
        return '32'; // Green
      case LogLevel.warning:
        return '33'; // Yellow
      case LogLevel.error:
        return '31'; // Red
      default:
        return '0'; // Default (White)
    }
  }
}

enum LogLevel {
  info,
  success,
  warning,
  error,
}
