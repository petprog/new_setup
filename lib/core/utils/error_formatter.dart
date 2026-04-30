import 'package:flutter/foundation.dart';

String formatErrorMessage(dynamic error) {
  try {
    // 0️⃣ If error itself is a string
    if (error is String) {
      return error;
    }

    if (error is Map) {
      // 1️⃣ PRIORITY: errors
      if (error.containsKey('error')) {
        final errors = error['error'];

        // errors: String
        if (errors is String && errors.trim().isNotEmpty) {
          return errors;
        }

        // errors: List
        if (errors is List && errors.isNotEmpty) {
          return errors.first.toString();
        }

        // errors: Map (e.g. { email: [...], password: [...] })
        if (errors is Map) {
          for (final value in errors.values) {
            if (value is List && value.isNotEmpty) {
              return value.first.toString();
            }
            if (value is String && value.trim().isNotEmpty) {
              return value;
            }
          }
        }
      }

      // 2️⃣ FALLBACK: message
      if (error.containsKey('message')) {
        final message = error['message'];

        if (message is String && message.trim().isNotEmpty) {
          return message;
        }

        if (message is List && message.isNotEmpty) {
          return message.first.toString();
        }
      }
    }

    return 'An unknown error occurred';
  } catch (e) {
    debugPrint('⚠️ Error formatting message: $e');
    return 'An unknown error occurred';
  }
}
