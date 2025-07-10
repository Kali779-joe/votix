import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// VotixFormatters provides text input formatters for the Votix application
/// This includes formatters for phone numbers and currency values
class VotixFormatters {
  /// Creates a phone number formatter with customizable format
  ///
  /// The [format] parameter determines how the phone number will be formatted
  /// Use # as a placeholder for digits
  ///
  /// Example formats:
  /// - US: (###) ###-####
  /// - International: +## ### ### ####
  /// - Custom: ###-###-####
  static TextInputFormatter phoneNumberFormatter({
    String format = '(###) ###-####',
  }) {
    return _PatternFormatter(format);
  }

  /// Creates a currency formatter with customizable currency symbol and decimal places
  ///
  /// The [currencySymbol] parameter determines the currency symbol to use
  /// The [decimalPlaces] parameter determines the number of decimal places to show
  ///
  /// Example:
  /// - USD: $1,234.56
  /// - EUR: €1,234.56
  /// - No symbol: 1,234.56
  static TextInputFormatter currencyFormatter({
    String currencySymbol = '\$',
    int decimalPlaces = 2,
  }) {
    return _CurrencyFormatter(
      currencySymbol: currencySymbol,
      decimalPlaces: decimalPlaces,
    );
  }

  /// Creates a NumberFormat for formatting currency values for display
  ///
  /// Unlike the TextInputFormatter, this is used for displaying values,
  /// not for input formatting
  ///
  /// Example:
  /// ```dart
  /// final formatter = VotixFormatters.getCurrencyDisplayFormat();
  /// final formattedValue = formatter.format(1234.56); // Returns $1,234.56
  /// ```
  static NumberFormat getCurrencyDisplayFormat({
    String currencySymbol = '\$',
    int decimalPlaces = 2,
  }) {
    return NumberFormat.currency(
      symbol: currencySymbol,
      decimalDigits: decimalPlaces,
    );
  }

  /// Formats a phone number string according to the given format
  ///
  /// This is a utility method for displaying phone numbers, not for input formatting
  ///
  /// Example:
  /// ```dart
  /// final formatted = VotixFormatters.formatPhoneNumber('1234567890');
  /// // Returns (123) 456-7890
  /// ```
  static String formatPhoneNumber(
      String phoneNumber, {
        String format = '(###) ###-####',
      }) {
    // Remove all non-digit characters
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Format the phone number
    String formatted = format;
    int digitIndex = 0;

    for (
    int i = 0;
    i < formatted.length && digitIndex < digitsOnly.length;
    i++
    ) {
      if (formatted[i] == '#') {
        formatted = formatted.replaceRange(i, i + 1, digitsOnly[digitIndex]);
        digitIndex++;
      }
    }

    // Replace any remaining # with empty string
    formatted = formatted.replaceAll('#', '');

    return formatted;
  }

  /// Formats a number as currency for display
  ///
  /// This is a utility method for displaying currency, not for input formatting
  ///
  /// Example:
  /// ```dart
  /// final formatted = VotixFormatters.formatCurrency(1234.56);
  /// // Returns $1,234.56
  /// ```
  static String formatCurrency(
      double value, {
        String currencySymbol = '\$',
        int decimalPlaces = 2,
      }) {
    final formatter = NumberFormat.currency(
      symbol: currencySymbol,
      decimalDigits: decimalPlaces,
    );

    return formatter.format(value);
  }
}

/// Private class for formatting text based on a pattern
class _PatternFormatter extends TextInputFormatter {
  final String pattern;

  _PatternFormatter(this.pattern);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // If deleting text, just return as is
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Get only the digits from the new value
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Format the text
    String formatted = pattern;
    int digitIndex = 0;

    for (
    int i = 0;
    i < formatted.length && digitIndex < digitsOnly.length;
    i++
    ) {
      if (formatted[i] == '#') {
        formatted = formatted.replaceRange(i, i + 1, digitsOnly[digitIndex]);
        digitIndex++;
      }
    }

    // Trim any remaining # placeholders
    if (formatted.contains('#')) {
      formatted = formatted.substring(0, formatted.indexOf('#'));
    }

    // Return the formatted value, preserving cursor position
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Private class for formatting currency input
class _CurrencyFormatter extends TextInputFormatter {
  final String currencySymbol;
  final int decimalPlaces;

  _CurrencyFormatter({
    required this.currencySymbol,
    required this.decimalPlaces,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // If deleting text, just return as is
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }

    // Get only the digits and decimal point from the new value
    String valueText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    // Handle decimal places
    if (valueText.contains('.')) {
      final parts = valueText.split('.');
      if (parts.length > 2) {
        // Multiple decimal points, keep only the first one
        valueText = '${parts[0]}.${parts[1]}';
      }

      // Limit decimal places
      final decimalPart = parts.length > 1 ? parts[1] : '';
      if (decimalPart.length > decimalPlaces) {
        valueText = '${parts[0]}.${decimalPart.substring(0, decimalPlaces)}';
      }
    }

    // Parse as double
    double? value;
    try {
      value = double.parse(valueText.isEmpty ? '0' : valueText);
    } catch (_) {
      value = 0;
    }

    // Format the value
    final formatter = NumberFormat.currency(
      symbol: currencySymbol,
      decimalDigits: decimalPlaces,
    );

    final formatted = formatter.format(value);

    // Return the formatted value, preserving cursor position
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Example usage:
///
/// ```dart
/// // In a TextField
/// TextField(
///   inputFormatters: [
///     VotixFormatters.phoneNumberFormatter(),
///   ],
///   decoration: InputDecoration(
///     labelText: 'Phone Number',
///     hintText: '(123) 456-7890',
///   ),
/// )
///
/// // For currency input
/// TextField(
///   inputFormatters: [
///     VotixFormatters.currencyFormatter(),
///   ],
///   decoration: InputDecoration(
///     labelText: 'Amount',
///     hintText: '\$0.00',
///   ),
///   keyboardType: TextInputType.numberWithOptions(decimal: true),
/// )
///