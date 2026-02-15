import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

enum LogType { info, success, warning, error, api }

class AppLogger {
  AppLogger._(); // Prevent instance creation

  static const int _lineLength = 100;

  static void log(
    dynamic message, {
    String title = "LOG",
    LogType type = LogType.info,
  }) {
    if (!kDebugMode) return;

    try {
      final emoji = _getEmoji(type);
      final divider = _getDivider(type);

      final formattedMessage =
          """
$divider
$emoji  $title
⏰ Time : ${DateTime.now()}
$divider
$message
$divider
""";

      _printLongString(formattedMessage);
    } catch (e) {
      developer.log("Logger Error: $e");
    }
  }

  /// ================= LOG TYPES =================

  static void info(dynamic message, {String title = "INFO"}) {
    log(message, title: title, type: LogType.info);
  }

  static void success(dynamic message, {String title = "SUCCESS"}) {
    log(message, title: title, type: LogType.success);
  }

  static void warning(dynamic message, {String title = "WARNING"}) {
    log(message, title: title, type: LogType.warning);
  }

  static void error(dynamic message, {String title = "ERROR"}) {
    log(message, title: title, type: LogType.error);
  }

  static void api(dynamic message, {String title = "API RESPONSE"}) {
    log(message, title: title, type: LogType.api);
  }

  /// ================= PRIVATE HELPERS =================

  static String _getEmoji(LogType type) {
    switch (type) {
      case LogType.info:
        return "ℹ️";
      case LogType.success:
        return "✅";
      case LogType.warning:
        return "⚠️";
      case LogType.error:
        return "❌";
      case LogType.api:
        return "🌐";
    }
  }

  static String _getDivider(LogType type) {
    switch (type) {
      case LogType.info:
        return "═" * _lineLength;
      case LogType.success:
        return "🟢" * 40;
      case LogType.warning:
        return "🟡" * 40;
      case LogType.error:
        return "🔴" * 40;
      case LogType.api:
        return "🔵" * 40;
    }
  }

  /// Prevents log cut off for large JSON
  static void _printLongString(String text) {
    const chunkSize = 800;
    for (var i = 0; i < text.length; i += chunkSize) {
      developer.log(
        text.substring(
          i,
          i + chunkSize > text.length ? text.length : i + chunkSize,
        ),
      );
    }
  }
}
