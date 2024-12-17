import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

enum ErrorCategory {
  networkError,
  serverError,
  unauthorized,
  forbidden,
  notFound,
  validationError,
  timeoutError,
  parseError,
  unknown
}

class ApiError {
  /// User-friendly error message
  final String userMessage;

  /// Technical error details
  final String? technicalDetails;

  /// Specific error category
  final ErrorCategory category;

  /// HTTP status code (if applicable)
  final int? statusCode;

  /// Field-specific errors (for validation errors)
  final Map<String, List<String>> fieldErrors;

  /// General error messages
  final List<String> generalErrors;

  ApiError({
    required this.userMessage,
    this.technicalDetails,
    required this.category,
    this.statusCode,
    this.fieldErrors = const {},
    this.generalErrors = const [],
  });

  /// Creates a user-friendly error message
  String getDisplayMessage() {
    // Prioritize user message
    if (userMessage.isNotEmpty) return userMessage;

    // Fallback to first general error
    if (generalErrors.isNotEmpty) return generalErrors.first;

    // Default error messages based on category
    switch (category) {
      case ErrorCategory.networkError:
        return 'Unable to connect. Please check your internet connection.';
      case ErrorCategory.serverError:
        return 'Server is experiencing issues. Please try again later.';
      case ErrorCategory.unauthorized:
        return 'You are not authorized to perform this action.';
      case ErrorCategory.forbidden:
        return 'Access denied.';
      case ErrorCategory.notFound:
        return 'Requested resource could not be found.';
      case ErrorCategory.validationError:
        return 'Please check your input and try again.';
      case ErrorCategory.timeoutError:
        return 'Request timed out. Please try again.';
      case ErrorCategory.parseError:
        return 'Unable to process the response.';
      case ErrorCategory.unknown:
      default:
        return 'An unexpected error occurred.';
    }
  }

  /// Check if there are any errors
  bool get hasErrors =>
      generalErrors.isNotEmpty ||
      fieldErrors.isNotEmpty ||
      technicalDetails != null;
}

/// Comprehensive API error handling utility
class ApiErrorHandler {
  /// Represents different categories of API errors

  /// Detailed error information container

  /// Handle different types of errors and convert them to a standardized ApiError
  ///
  ///
  static String extractErrorMessage(dynamic response) {
    if (response is List && response.isNotEmpty) {
      // Join the list of errors into a single string (if there are multiple errors in the list)
      return response.map((e) => e.toString()).join(', ');
    } else if (response is String) {
      // If the response is a single string, return it directly
      return response;
    } else {
      // If there's no valid error message, return a fallback error message
      return 'Unknown error';
    }
  }

  static ApiError handle(dynamic error) {
    if (error is Response<dynamic>) {
      try {
        // Determine error category
        final category = _determineErrorCategory(error.statusCode);
        final message =
            extractErrorMessage(json.decode(error.error.toString()));
        return ApiError(
          userMessage: message,
          category: category,
          statusCode: error.statusCode,
          generalErrors: [],
          fieldErrors: {},
          technicalDetails: error.error.toString(),
        );
      } catch (parseError) {
        // Fallback if JSON parsing fails
        return ApiError(
          userMessage: 'Unable to process server response',
          category: ErrorCategory.parseError,
          statusCode: error.statusCode,
          technicalDetails: error.body,
        );
      }
    }
    if (error is SocketException) {
      return ApiError(
        userMessage: 'No internet connection',
        category: ErrorCategory.networkError,
        technicalDetails: error.toString(),
      );
    }

    // Handle TimeoutException
    if (error is TimeoutException) {
      return ApiError(
        userMessage: 'Request timed out. Please try again.',
        category: ErrorCategory.timeoutError,
        technicalDetails: error.toString(),
      );
    }

    // Handle HTTP Response errors
    if (error is http.Response) {
      try {
        // Attempt to parse error response
        final jsonBody = _safelyParseJson(error.body);

        // Extract error details
        final generalErrors = _extractGeneralErrors(jsonBody);
        final fieldErrors = _extractFieldErrors(jsonBody);

        // Determine error category
        final category = _determineErrorCategory(error.statusCode);

        return ApiError(
          userMessage: _getUserFriendlyMessage(category),
          category: category,
          statusCode: error.statusCode,
          generalErrors: generalErrors,
          fieldErrors: fieldErrors,
          technicalDetails: error.body,
        );
      } catch (parseError) {
        // Fallback if JSON parsing fails
        return ApiError(
          userMessage: 'Unable to process server response',
          category: ErrorCategory.parseError,
          statusCode: error.statusCode,
          technicalDetails: error.body,
        );
      }
    }

    // Handle JSON parsing errors
    if (error is FormatException) {
      return ApiError(
        userMessage: 'Error parsing server response',
        category: ErrorCategory.parseError,
        technicalDetails: error.toString(),
      );
    }

    // Catch-all for unexpected errors
    return ApiError(
      userMessage: 'An unexpected error occurred',
      category: ErrorCategory.unknown,
      technicalDetails: error.toString(),
    );
  }

  /// Safely parse JSON, returning an empty map if parsing fails
  static Map<String, dynamic> _safelyParseJson(String body) {
    try {
      return json.decode(body) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  /// Extract general error messages from JSON response
  static List<String> _extractGeneralErrors(Map<String, dynamic> json) {
    final errorKeys = [
      'error',
      'errors',
      'message',
      'messages',
      'non_field_errors',
      'detail'
    ];

    for (var key in errorKeys) {
      if (json.containsKey(key)) {
        final errors = json[key];
        if (errors is String) return [errors];
        if (errors is List) return errors.map((e) => e.toString()).toList();
      }
    }
    return [];
  }

  /// Extract field-specific errors from JSON response
  static Map<String, List<String>> _extractFieldErrors(
      Map<String, dynamic> json) {
    final fieldErrorKeys = ['field_errors', 'errors', 'validation_errors'];

    // Check predefined error keys
    for (var key in fieldErrorKeys) {
      if (json.containsKey(key)) {
        final fieldErrors = json[key];
        if (fieldErrors is Map) {
          return fieldErrors.map((key, value) => MapEntry(
              key.toString(),
              (value is List
                  ? value.map((e) => e.toString()).toList()
                  : [value.toString()])));
        }
      }
    }

    // Handle nested field errors
    return json.entries
        .where((entry) => entry.value is List || entry.value is String)
        .map((entry) => MapEntry(
            entry.key,
            (entry.value is List
                ? (entry.value as List).map((e) => e.toString()).toList()
                : [entry.value.toString()])))
        .fold({}, (map, entry) {
      map[entry.key] = entry.value;
      return map;
    });
  }

  /// Determine error category based on status code
  static ErrorCategory _determineErrorCategory(int? statusCode) {
    if (statusCode == null) return ErrorCategory.unknown;

    if (statusCode >= 500) return ErrorCategory.serverError;

    switch (statusCode) {
      case 400:
        return ErrorCategory.validationError;
      case 401:
        return ErrorCategory.unauthorized;
      case 403:
        return ErrorCategory.forbidden;
      case 404:
        return ErrorCategory.notFound;
      default:
        return ErrorCategory.unknown;
    }
  }

  /// Get user-friendly message based on error category
  static String _getUserFriendlyMessage(ErrorCategory category) {
    switch (category) {
      case ErrorCategory.networkError:
        return 'Network connection failed';
      case ErrorCategory.serverError:
        return 'Server is currently unavailable';
      case ErrorCategory.unauthorized:
        return 'Authentication failed';
      case ErrorCategory.forbidden:
        return 'Access restricted';
      case ErrorCategory.notFound:
        return 'Requested resource not found';
      case ErrorCategory.validationError:
        return 'Invalid input provided';
      case ErrorCategory.timeoutError:
        return 'Request timed out';
      case ErrorCategory.parseError:
        return 'Unable to process response';
      case ErrorCategory.unknown:
      default:
        return 'An unexpected error occurred';
    }
  }
}
