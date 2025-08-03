import 'package:flutter/foundation.dart';

// Define an enum for log types
enum _LogType {
  warning,  // Magenta
  error,    // Red
  debug,    // White
  info,     // White
  success   // Green
}

// Extension method to map each enum value to its corresponding color code
extension _LogTypeExtension on _LogType {
  String get colorCode {
    switch (this) {
      case _LogType.warning:
        return '35';  // Magenta
      case _LogType.error:
        return '31';  // Red
      case _LogType.info:
      case _LogType.debug:
        return '37';  // White
      case _LogType.success:
        return '32';  // Green
    }
  }
}

// Logger class to manage logging
class LoggerService {
  // Private constructor to prevent instantiation
  LoggerService._();

  // Static field to track if logging is enabled or disabled
  static bool _isLoggingEnabled = kDebugMode;

  // Method to toggle logging on or off
  static void toggleLogging(bool isEnabled) {
    _isLoggingEnabled = isEnabled;
  }

  // Core log function, checks the toggle and debug mode before logging
  static void _logMessage(String text, _LogType logType) {
    if (_isLoggingEnabled && kDebugMode) {
      print('[${logType.name.toUpperCase()}] \x1B[${logType.colorCode}m$text\x1B[0m');
    }
  }

  // Public logging functions
  static void logWarning(String text) {
    _logMessage(text, _LogType.warning);
  }

  static void logError(String text) {
    _logMessage(text, _LogType.error);
  }

  static void logInfo(String text) {
    _logMessage(text, _LogType.info);
  }

  static void logDebug(String text) {
    _logMessage(text, _LogType.debug);
  }

  static void logSuccess(String text) {
    _logMessage(text, _LogType.success);
  }
}
