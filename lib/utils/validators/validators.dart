import 'dart:core';

import 'package:flutter/material.dart';

/// VotixValidators provides a comprehensive set of validation functions
/// for the Votix application, following modern Flutter best practices.
///
/// This class uses a functional approach to validation, making it easy to
/// compose validators and create custom validation logic.
class VotixValidators {
  /// Core validation result type that includes error message and validation state
  static ValidationResult validate({
    required String? value,
    required List<Validator> validators,
    String customErrorMessage = '',
  }) {
    // Skip validation for null or empty values unless required validator is present
    if ((value == null || value.isEmpty) &&
        !validators.any((v) => v == VotixValidators.required())) {
      return ValidationResult.valid();
    }

    // Apply each validator in sequence
    for (final validator in validators) {
      final result = validator(value);
      if (!result.isValid) {
        // Return custom error message if provided, otherwise use the validator's message
        return customErrorMessage.isNotEmpty
            ? ValidationResult(isValid: false, message: customErrorMessage)
            : result;
      }
    }

    return ValidationResult.valid();
  }

  /// Required field validator
  static Validator required({String message = 'This field is required'}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult(isValid: false, message: message);
      }
      return ValidationResult.valid();
    };
  }

  /// Email validator with modern RFC 5322 compliant regex
  static Validator email({String message = 'Enter a valid email address'}) {
    // This regex covers most valid email formats including international domains
    final emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );

    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      if (!emailRegex.hasMatch(value)) {
        return ValidationResult(isValid: false, message: message);
      }

      return ValidationResult.valid();
    };
  }

  /// Phone number validator with flexible format support
  static Validator phone({
    String message = 'Enter a valid phone number',
    int minDigits = 10,
    int maxDigits = 15,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      // Extract only digits for validation
      final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

      if (digitsOnly.length < minDigits || digitsOnly.length > maxDigits) {
        return ValidationResult(isValid: false, message: message);
      }

      return ValidationResult.valid();
    };
  }

  /// Password validator with customizable strength requirements
  static Validator password({
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumbers = true,
    bool requireSpecialChars = true,
    String? message,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      final List<String> validationIssues = [];

      if (value.length < minLength) {
        validationIssues.add('at least $minLength characters');
      }

      if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
        validationIssues.add('an uppercase letter');
      }

      if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
        validationIssues.add('a lowercase letter');
      }

      if (requireNumbers && !value.contains(RegExp(r'[0-9]'))) {
        validationIssues.add('a number');
      }

      if (requireSpecialChars &&
          !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        validationIssues.add('a special character');
      }

      if (validationIssues.isNotEmpty) {
        final customMessage =
            message ?? 'Password must contain ${validationIssues.join(', ')}';
        return ValidationResult(isValid: false, message: customMessage);
      }

      return ValidationResult.valid();
    };
  }

  /// URL validator
  static Validator url({String message = 'Enter a valid URL'}) {
    final urlRegex = RegExp(
      r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      if (!urlRegex.hasMatch(value)) {
        return ValidationResult(isValid: false, message: message);
      }

      return ValidationResult.valid();
    };
  }

  /// Min length validator
  static Validator minLength(int length, {String? message}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      if (value.length < length) {
        final customMessage = message ?? 'Must be at least $length characters';
        return ValidationResult(isValid: false, message: customMessage);
      }

      return ValidationResult.valid();
    };
  }

  /// Max length validator
  static Validator maxLength(int length, {String? message}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      if (value.length > length) {
        final customMessage =
            message ?? 'Must be no more than $length characters';
        return ValidationResult(isValid: false, message: customMessage);
      }

      return ValidationResult.valid();
    };
  }

  /// Exact length validator
  static Validator exactLength(int length, {String? message}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      if (value.length != length) {
        final customMessage = message ?? 'Must be exactly $length characters';
        return ValidationResult(isValid: false, message: customMessage);
      }

      return ValidationResult.valid();
    };
  }

  /// Numeric validator (integers only)
  static Validator integer({String message = 'Enter a valid whole number'}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      if (int.tryParse(value) == null) {
        return ValidationResult(isValid: false, message: message);
      }

      return ValidationResult.valid();
    };
  }

  /// Decimal validator (floating point numbers)
  static Validator decimal({String message = 'Enter a valid number'}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      if (double.tryParse(value) == null) {
        return ValidationResult(isValid: false, message: message);
      }

      return ValidationResult.valid();
    };
  }

  /// Range validator for numeric values
  static Validator range({
    required num min,
    required num max,
    String? message,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      final numValue = num.tryParse(value);
      if (numValue == null) {
        return ValidationResult(
          isValid: false,
          message: 'Enter a valid number',
        );
      }

      if (numValue < min || numValue > max) {
        final customMessage = message ?? 'Must be between $min and $max';
        return ValidationResult(isValid: false, message: customMessage);
      }

      return ValidationResult.valid();
    };
  }

  /// Match validator (compares with another value)
  static Validator match(
      String? Function() getCompareValue, {
        String message = 'Values do not match',
      }) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      final compareValue = getCompareValue();
      if (value != compareValue) {
        return ValidationResult(isValid: false, message: message);
      }

      return ValidationResult.valid();
    };
  }

  /// Date validator
  static Validator date({
    String message = 'Enter a valid date',
    DateTime? minDate,
    DateTime? maxDate,
    String? minDateMessage,
    String? maxDateMessage,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      final date = DateTime.tryParse(value);
      if (date == null) {
        return ValidationResult(isValid: false, message: message);
      }

      if (minDate != null && date.isBefore(minDate)) {
        final customMessage =
            minDateMessage ?? 'Date must be after ${_formatDate(minDate)}';
        return ValidationResult(isValid: false, message: customMessage);
      }

      if (maxDate != null && date.isAfter(maxDate)) {
        final customMessage =
            maxDateMessage ?? 'Date must be before ${_formatDate(maxDate)}';
        return ValidationResult(isValid: false, message: customMessage);
      }

      return ValidationResult.valid();
    };
  }

  /// Pattern validator (regex)
  static Validator pattern(RegExp pattern, {required String message}) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      if (!pattern.hasMatch(value)) {
        return ValidationResult(isValid: false, message: message);
      }

      return ValidationResult.valid();
    };
  }

  /// Custom validator that takes a function
  static Validator custom(
      bool Function(String? value) validate, {
        required String message,
      }) {
    return (String? value) {
      if (!validate(value)) {
        return ValidationResult(isValid: false, message: message);
      }
      return ValidationResult.valid();
    };
  }

  /// Username validator (alphanumeric with optional underscores and dashes)
  static Validator username({
    String message =
    'Username must only contain letters, numbers, underscores and dashes',
    int minLength = 3,
    int maxLength = 20,
  }) {
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_-]+$');

    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      if (value.length < minLength) {
        return ValidationResult(
          isValid: false,
          message: 'Username must be at least $minLength characters',
        );
      }

      if (value.length > maxLength) {
        return ValidationResult(
          isValid: false,
          message: 'Username must be no more than $maxLength characters',
        );
      }

      if (!usernameRegex.hasMatch(value)) {
        return ValidationResult(isValid: false, message: message);
      }

      return ValidationResult.valid();
    };
  }

  /// Credit card validator
  static Validator creditCard({
    String message = 'Enter a valid credit card number',
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      // Remove spaces and dashes
      final cleanedValue = value.replaceAll(RegExp(r'[\s-]'), '');

      // Check if it's a valid length and all digits
      if (!RegExp(r'^[0-9]{13,19}$').hasMatch(cleanedValue)) {
        return ValidationResult(isValid: false, message: message);
      }

      // Apply Luhn algorithm (mod 10 check)
      int sum = 0;
      bool alternate = false;

      for (int i = cleanedValue.length - 1; i >= 0; i--) {
        int n = int.parse(cleanedValue[i]);
        if (alternate) {
          n *= 2;
          if (n > 9) {
            n = (n % 10) + 1;
          }
        }
        sum += n;
        alternate = !alternate;
      }

      if (sum % 10 != 0) {
        return ValidationResult(isValid: false, message: message);
      }

      return ValidationResult.valid();
    };
  }

  /// Postal/Zip code validator with country support
  static Validator postalCode({
    String? countryCode,
    String message = 'Enter a valid postal/zip code',
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return ValidationResult.valid();
      }

      // Define country-specific formats
      final Map<String, RegExp> postalFormats = {
        'US': RegExp(r'^\d{5}(-\d{4})?$'),
        'CA': RegExp(r'^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$'),
        'UK': RegExp(
          r'^[A-Z]{1,2}[0-9][A-Z0-9]? ?[0-9][A-Z]{2}$',
          caseSensitive: false,
        ),
        'NG': RegExp(r'^\d{6}$'),
        // Add more countries as needed
      };

      // If no country specified or country not in list, use generic validation
      if (countryCode == null || !postalFormats.containsKey(countryCode)) {
        // Generic check - alphanumeric, reasonable length
        if (!RegExp(r'^[a-zA-Z0-9\s-]{3,10}$').hasMatch(value)) {
          return ValidationResult(isValid: false, message: message);
        }
      } else {
        // Country-specific validation
        if (!postalFormats[countryCode]!.hasMatch(value)) {
          return ValidationResult(isValid: false, message: message);
        }
      }

      return ValidationResult.valid();
    };
  }

  /// Helper function to format dates for error messages
  static String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Creates a multi-field validator for form validation
  static FormFieldValidator<T> createValidator<T>({
    required List<Validator> validators,
    String? customErrorMessage,
  }) {
    return (T? value) {
      // Convert value to string (most values can be converted to string)
      final stringValue = value?.toString();

      final result = validate(
        value: stringValue,
        validators: validators,
        customErrorMessage: customErrorMessage ?? '',
      );

      return result.isValid ? null : result.message;
    };
  }
}

/// Type definition for validator functions
typedef Validator = ValidationResult Function(String? value);

/// Result class for validation operations
class ValidationResult {
  final bool isValid;
  final String message;

  const ValidationResult({required this.isValid, this.message = ''});

  /// Factory constructor for valid results
  factory ValidationResult.valid() => const ValidationResult(isValid: true);

  /// Factory constructor for invalid results
  factory ValidationResult.invalid(String message) =>
      ValidationResult(isValid: false, message: message);
}

/// Helper class for password strength visual indicators
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;
  final List<PasswordCriterion> criteria;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
    required this.criteria,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate strength score (0-100)
    final int strengthScore = _calculateStrengthScore();
    final strengthLevel = _getStrengthLevel(strengthScore);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Strength bar
        LinearProgressIndicator(
          value: strengthScore / 100,
          backgroundColor: Colors.grey.shade200,
          color: _getStrengthColor(strengthLevel),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 8),

        // Strength label
        Text(
          'Password Strength: ${_getStrengthLabel(strengthLevel)}',
          style: TextStyle(
            color: _getStrengthColor(strengthLevel),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),

        // Criteria list
        ...criteria.map((criterion) {
          final bool isMet = criterion.validator(password);
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Icon(
                  isMet ? Icons.check_circle : Icons.circle_outlined,
                  size: 16,
                  color: isMet ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  criterion.description,
                  style: TextStyle(
                    color: isMet ? Colors.black87 : Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  int _calculateStrengthScore() {
    // Base score starts at 0
    int score = 0;

    // Calculate score based on criteria met
    int criteriaMet = 0;
    for (final criterion in criteria) {
      if (criterion.validator(password)) {
        criteriaMet++;
        score += criterion.weight;
      }
    }

    // Additional length-based scoring
    if (password.length >= 12) {
      score += 20;
    } else if (password.length >= 8) {
      score += 10;
    }

    // Cap score at 100
    return score > 100 ? 100 : score;
  }

  PasswordStrength _getStrengthLevel(int score) {
    if (score >= 80) return PasswordStrength.strong;
    if (score >= 50) return PasswordStrength.moderate;
    if (score >= 30) return PasswordStrength.weak;
    return PasswordStrength.veryWeak;
  }

  Color _getStrengthColor(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.veryWeak:
        return Colors.red.shade700;
      case PasswordStrength.weak:
        return Colors.orange;
      case PasswordStrength.moderate:
        return Colors.amber.shade600;
      case PasswordStrength.strong:
        return Colors.green.shade600;
    }
  }

  String _getStrengthLabel(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.veryWeak:
        return 'Very Weak';
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.moderate:
        return 'Moderate';
      case PasswordStrength.strong:
        return 'Strong';
    }
  }
}

/// Password criterion for strength checking
class PasswordCriterion {
  final String description;
  final bool Function(String password) validator;
  final int weight;

  const PasswordCriterion({
    required this.description,
    required this.validator,
    this.weight = 15,
  });

  /// Common criteria factory methods
  static PasswordCriterion minLength(int length) {
    return PasswordCriterion(
      description: 'At least $length characters',
      validator: (password) => password.length >= length,
      weight: 15,
    );
  }

  static PasswordCriterion hasUppercase() {
    return PasswordCriterion(
      description: 'Contains uppercase letter',
      validator: (password) => password.contains(RegExp(r'[A-Z]')),
      weight: 15,
    );
  }

  static PasswordCriterion hasLowercase() {
    return PasswordCriterion(
      description: 'Contains lowercase letter',
      validator: (password) => password.contains(RegExp(r'[a-z]')),
      weight: 15,
    );
  }

  static PasswordCriterion hasDigit() {
    return PasswordCriterion(
      description: 'Contains number',
      validator: (password) => password.contains(RegExp(r'[0-9]')),
      weight: 15,
    );
  }

  static PasswordCriterion hasSpecialChar() {
    return PasswordCriterion(
      description: 'Contains special character',
      validator: (password) =>
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
      weight: 20,
    );
  }
}

/// Password strength levels
enum PasswordStrength { veryWeak, weak, moderate, strong }
class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}
