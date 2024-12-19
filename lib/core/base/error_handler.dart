import 'package:thrivve_assignment/core/base/exceptions.dart';

class ErrorHandler {
  /// Maps exceptions to user-friendly error messages.
  String handleError(dynamic exception) {
    if (exception is NetworkException) {
      return 'No internet connection. Please check your network and try again.';
    } else if (exception is ServerException) {
      return 'Server error: ${exception.message} (Code: ${exception.statusCode}).';
    } else if (exception is ValidationException) {
      return 'Validation error: ${_formatValidationErrors(exception.errors)}';
    } else if (exception is FormatException) {
      return 'Unexpected response format. Please try again later.';
    } else {
      // Log unexpected errors for debugging (optional)
      _logError(exception);
      return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Helper to format validation errors
  static String _formatValidationErrors(Map<String, List<String>> errors) {
    return errors.entries
        .map((entry) => '${entry.key}: ${entry.value.join(", ")}')
        .join("; ");
  }

  /// Optional: Log unexpected errors (for debugging or analytics)
  static void _logError(dynamic exception) {
    // Use your logging library here (e.g., Firebase, Sentry, etc.)
    print('Unhandled Exception: $exception');
  }
}
