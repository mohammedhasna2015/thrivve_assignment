import 'package:thrivve_assignment/core/helper/optional_mapper.dart';

class InputValidator {
  // Email validation
  static bool isValidEmail(String email) {
    if (email.trim().isEmpty) return false;
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  // Password validation
  static bool isValidPassword(String password) {
    // Checks:
    // 1. At least 8 characters
    // 2. At least one digit
    // 3. At least one uppercase letter
    if (password.isEmpty) return false;

    final hasMinLength = password.length >= 8;
    final hasDigit = password.contains(RegExp(r'\d'));
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));

    return hasMinLength && hasDigit && hasUppercase;
  }

  // Name validation
  static bool isValidName(String name) {
    return name.trim().isNotEmpty;
  }

  // US Phone number validation
  static bool isValidUSPhoneNumber(String phone) {
    // Remove all non-digit characters
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');
    return cleanPhone.length == 10;
  }

  // Comprehensive signup validation
  static Map<String, bool> validateSignUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    return {
      'email': isValidEmail(email),
      'password': isValidPassword(password),
      'name': isValidName(name),
      'phone': isValidUSPhoneNumber(phone),
    };
  }

  // Get specific error messages
  static List<String> getSignUpErrorMessages({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    final List<String> errors = [];

    if (!isValidEmail(email)) {
      errors.add('Invalid email address');
    }

    if (!isValidPassword(password)) {
      errors.add('Password must be at least 8 characters long, '
          'contain one digit and one uppercase letter');
    }

    if (!isValidName(name)) {
      errors.add('Name cannot be empty');
    }

    if (!isValidUSPhoneNumber(phone)) {
      errors.add('Invalid US phone number (10 digits required)');
    }

    return errors;
  }

  String? validatorPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (value.contains(RegExp(r'\d')).inverted) {
      return 'Password must be at least one digit';
    }
    if (value.contains(RegExp(r'[A-Z]')).inverted) {
      return 'Password must be at least one uppercase letter';
    }
    return null;
  }

  static String? validatorConfirmPassword(
      String? value, String confirmPassword) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (value.contains(RegExp(r'\d')).inverted) {
      return 'Password must be at least one digit';
    }
    if (value.contains(RegExp(r'[A-Z]')).inverted) {
      return 'Password must be at least one uppercase letter';
    }
    if (value != confirmPassword) {
      return 'Password must be the same with confirm password';
    }
    return null;
  }

  String? validatorMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your mobile number';
    }
    if (value.length != 10) {
      return 'Mobile Number must be 10 digits';
    }
    return null;
  }

  String? validatorCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your code number';
    }
    if (value.length != 6) {
      return 'Code Number must be 4 digits';
    }
    return null;
  }

  String? validatorEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter an email address';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatorName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }
}
