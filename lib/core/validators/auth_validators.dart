import 'package:cos_test/core/utils/regex_utils.dart';

/// A class that contains validators for authentication-related fields.
class AuthValidators {
  static const _passwordMinLength = 6;

  /// Validates the email string. Returns an error message if:
  /// - email null or empty
  /// - email does not match the regex pattern.
  ///
  /// Otherwise, returns null.
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final matchesFormat = RegexUtils.emailRegex.hasMatch(value);
    if (!matchesFormat) {
      return 'Invalid email format';
    }

    return null;
  }

  /// Validates the password string. Returns an error message if:
  /// - password null or empty
  /// - password length is less than [_passwordMinLength].
  ///
  /// Otherwise, returns null.
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < _passwordMinLength) {
      return 'Password must be at least $_passwordMinLength characters long';
    }

    return null;
  }
}
