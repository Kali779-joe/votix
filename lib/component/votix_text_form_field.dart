import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants/app_color.dart';


/// Input field variants for different visual styles
enum VotixInputVariant {
  /// Standard outlined input with border
  outlined,

  /// Filled input with background color
  filled,

  /// Minimal input with underline only
  underlined,

  /// Minimal input with no border, just hint/label
  minimal,
}

/// Class representing different input types with built-in validation
enum VotixInputType {
  /// Standard text input with no special validation
  text,

  /// Email input with email validation
  email,

  /// Password input with toggle to show/hide
  password,

  /// Phone number input with formatting
  phone,

  /// Number input that only accepts digits
  number,

  /// Multi-line text input for larger content
  multiline,

  /// Search input with search icon
  search,

  /// URL input with validation
  url,
}

/// A professionally styled text input component that adapts to the current theme
/// and provides consistent styling across the application
class VotixTextField extends StatefulWidget {
  /// Controller for the text input
  final TextEditingController? controller;

  /// Label text shown above or within the input
  final String? label;

  /// Hint text shown when the input is empty
  final String? hint;

  /// Helper text shown below the input
  final String? helperText;

  /// Error text shown below the input (overrides helper text)
  final String? errorText;

  /// Icon to show at the start of the input
  final IconData? prefixIcon;

  /// Icon to show at the end of the input
  final IconData? suffixIcon;

  /// Custom widget to show at the start of the input
  final Widget? prefix;

  /// Custom widget to show at the end of the input
  final Widget? suffix;

  /// Visual style of the input
  final VotixInputVariant variant;

  /// Type of input with built-in validation
  final VotixInputType inputType;

  /// Whether the input is disabled
  final bool enabled;

  /// Whether the input is required
  final bool required;

  /// Whether the input should have focus when first displayed
  final bool autofocus;

  /// Callback when text changes
  final Function(String)? onChanged;

  /// Callback when form is submitted
  final Function(String)? onSubmitted;

  /// Validator function for form validation
  final String? Function(String?)? validator;

  /// Focus node for controlling focus
  final FocusNode? focusNode;

  /// Callback when field is tapped
  final VoidCallback? onTap;

  /// Maximum number of characters allowed
  final int? maxLength;

  /// Maximum number of lines for multiline input
  final int? maxLines;

  /// Minimum number of lines for multiline input
  final int? minLines;

  /// Text capitalization style
  final TextCapitalization capitalization;

  /// Input formatters for text formatting
  final List<TextInputFormatter>? inputFormatters;

  /// Text input action (e.g., next, done, search)
  final TextInputAction? textInputAction;

  /// Custom border radius
  final double? borderRadius;

  /// Whether to show counter for character count
  final bool showCounter;

  /// Optional custom background color
  final Color? backgroundColor;

  /// Optional custom border color
  final Color? borderColor;

  /// Optional custom text color
  final Color? textColor;

  /// Content padding
  final EdgeInsetsGeometry? contentPadding;

  const VotixTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.variant = VotixInputVariant.outlined,
    this.inputType = VotixInputType.text,
    this.enabled = true,
    this.required = false,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.focusNode,
    this.onTap,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.capitalization = TextCapitalization.none,
    this.inputFormatters,
    this.textInputAction,
    this.borderRadius,
    this.showCounter = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.contentPadding,
  });

  @override
  State<VotixTextField> createState() => _VotixTextFieldState();
}

class _VotixTextFieldState extends State<VotixTextField> {
  bool _obscureText = true;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    // Listen for focus changes
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    // For password fields, start with obscured text
    _obscureText = widget.inputType == VotixInputType.password;
  }

  @override
  void dispose() {
    // Only dispose controller and focusNode if we created them
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Determine if showing error state
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    // Calculate input decoration based on variant and state
    final inputDecoration = _getInputDecoration(context, isDark, hasError);

    // Get the appropriate keyboard type
    final keyboardType = _getKeyboardType();

    // Get appropriate input formatters
    final formatters = _getInputFormatters();

    // Determine the maximum lines
    final maxLines = _getMaxLines();
    final minLines =
        widget.minLines ??
            (widget.inputType == VotixInputType.multiline ? 3 : 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null &&
            widget.variant == VotixInputVariant.minimal) ...[
          Row(
            children: [
              Text(
                widget.label!,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: hasError
                      ? VotixColors.error
                      : (isDark
                      ? VotixColors.darkTextSecondary
                      : VotixColors.lightTextSecondary),
                ),
              ),
              if (widget.required)
                Text(
                  ' *',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: VotixColors.error,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],

        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          style: theme.textTheme.bodyMedium?.copyWith(
            color:
            widget.textColor ??
                (isDark
                    ? VotixColors.darkTextPrimary
                    : VotixColors.lightTextPrimary),
          ),
          decoration: inputDecoration,
          keyboardType: keyboardType,
          obscureText:
          widget.inputType == VotixInputType.password && _obscureText,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          validator: widget.validator ?? _getDefaultValidator(),
          onTap: widget.onTap,
          maxLength: widget.maxLength,
          maxLines: maxLines,
          minLines: minLines,
          textCapitalization: widget.capitalization,
          inputFormatters: formatters,
          textInputAction: widget.textInputAction,
          cursorColor: isDark
              ? VotixColors.darkModeMint
              : VotixColors.primaryPurple,
        ),
      ],
    );
  }

  // Generate appropriate input decoration based on variant and state
  InputDecoration _getInputDecoration(
      BuildContext context,
      bool isDark,
      bool hasError,
      ) {
    final theme = Theme.of(context);
    final calculatedBorderRadius = widget.borderRadius ?? 12.0;

    // Determine colors based on theme, state, and custom overrides
    final bgColor =
        widget.backgroundColor ??
            (isDark
                ? VotixColors.darkSurface.withAlpha(204)
                : VotixColors.lightBackground);

    final borderColor = hasError
        ? VotixColors.error
        : (widget.borderColor ??
        (isDark ? VotixColors.darkDivider : VotixColors.lightDivider));

    final focusedBorderColor = hasError
        ? VotixColors.error
        : (isDark ? VotixColors.darkModeMint : VotixColors.primaryMint);

    // Helper/Error text styles
    final helperStyle = theme.textTheme.bodySmall?.copyWith(
      color: isDark
          ? VotixColors.darkTextSecondary
          : VotixColors.lightTextSecondary,
    );

    final errorStyle = theme.textTheme.bodySmall?.copyWith(
      color: VotixColors.error,
    );

    // Basic decoration that applies to all variants
    InputDecoration decoration = InputDecoration(
      hintText: widget.hint,
      helperText: hasError ? null : widget.helperText,
      errorText: widget.errorText,
      helperStyle: helperStyle,
      errorStyle: errorStyle,
      counterText: widget.showCounter ? null : '',
      isDense: true,
      filled: widget.variant == VotixInputVariant.filled,
      fillColor: widget.variant == VotixInputVariant.filled ? bgColor : null,
      enabled: widget.enabled,
      hintStyle: theme.textTheme.bodyMedium?.copyWith(
        color: isDark
            ? VotixColors.darkTextSecondary
            : VotixColors.lightTextSecondary,
      ),
      contentPadding:
      widget.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );

    // Handle prefix/suffix elements
    if (widget.prefixIcon != null) {
      decoration = decoration.copyWith(
        prefixIcon: Icon(
          widget.prefixIcon,
          color: hasError
              ? VotixColors.error
              : (isDark
              ? VotixColors.darkTextSecondary
              : VotixColors.lightTextSecondary),
          size: 20,
        ),
      );
    }

    if (widget.prefix != null) {
      decoration = decoration.copyWith(prefix: widget.prefix);
    }

    // For password fields, add the toggle visibility icon
    if (widget.inputType == VotixInputType.password) {
      decoration = decoration.copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: isDark
                ? VotixColors.darkTextSecondary
                : VotixColors.lightTextSecondary,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      );
    } else if (widget.suffixIcon != null) {
      decoration = decoration.copyWith(
        suffixIcon: Icon(
          widget.suffixIcon,
          color: hasError
              ? VotixColors.error
              : (isDark
              ? VotixColors.darkTextSecondary
              : VotixColors.lightTextSecondary),
          size: 20,
        ),
      );
    }

    if (widget.suffix != null) {
      decoration = decoration.copyWith(suffix: widget.suffix);
    }

    // Add label if provided (except for minimal variant which has label outside)
    if (widget.label != null && widget.variant != VotixInputVariant.minimal) {
      final labelStyle = theme.textTheme.labelLarge?.copyWith(
        color: hasError
            ? VotixColors.error
            : (isDark
            ? VotixColors.darkTextSecondary
            : VotixColors.lightTextSecondary),
      );

      decoration = decoration.copyWith(
        labelText: widget.label! + (widget.required ? ' *' : ''),
        labelStyle: labelStyle,
        floatingLabelStyle: labelStyle?.copyWith(
          color: hasError
              ? VotixColors.error
              : (_isFocused
              ? (isDark
              ? VotixColors.darkModeMint
              : VotixColors.primaryPurple)
              : labelStyle.color),
        ),
      );
    }

    // Apply border styles based on variant
    switch (widget.variant) {
      case VotixInputVariant.outlined:
        decoration = decoration.copyWith(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculatedBorderRadius),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculatedBorderRadius),
            borderSide: BorderSide(color: focusedBorderColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculatedBorderRadius),
            borderSide: BorderSide(color: VotixColors.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculatedBorderRadius),
            borderSide: BorderSide(color: VotixColors.error, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculatedBorderRadius),
            borderSide: BorderSide(
              color: isDark
                  ? VotixColors.darkDisabled
                  : VotixColors.lightDisabled,
              width: 1,
            ),
          ),
        );
        break;

      case VotixInputVariant.filled:
        decoration = decoration.copyWith(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculatedBorderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculatedBorderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculatedBorderRadius),
            borderSide: BorderSide(color: focusedBorderColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculatedBorderRadius),
            borderSide: BorderSide(color: VotixColors.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculatedBorderRadius),
            borderSide: BorderSide(color: VotixColors.error, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(calculatedBorderRadius),
            borderSide: BorderSide.none,
          ),
        );
        break;

      case VotixInputVariant.underlined:
        decoration = decoration.copyWith(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor, width: 2),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: VotixColors.error, width: 1),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: VotixColors.error, width: 2),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isDark
                  ? VotixColors.darkDisabled
                  : VotixColors.lightDisabled,
              width: 1,
            ),
          ),
        );
        break;

      case VotixInputVariant.minimal:
        decoration = decoration.copyWith(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        );
        break;
    }

    return decoration;
  }

  // Get appropriate keyboard type based on input type
  TextInputType _getKeyboardType() {
    switch (widget.inputType) {
      case VotixInputType.email:
        return TextInputType.emailAddress;
      case VotixInputType.phone:
        return TextInputType.phone;
      case VotixInputType.number:
        return TextInputType.number;
      case VotixInputType.multiline:
        return TextInputType.multiline;
      case VotixInputType.url:
        return TextInputType.url;
      case VotixInputType.search:
        return TextInputType.text;
      case VotixInputType.password:
      case VotixInputType.text:
      default:
        return TextInputType.text;
    }
  }

  // Get appropriate input formatters based on input type
  List<TextInputFormatter> _getInputFormatters() {
    final formatters = <TextInputFormatter>[];

    // Add custom formatters based on input type
    if (widget.inputType == VotixInputType.number) {
      formatters.add(FilteringTextInputFormatter.digitsOnly);
    } else if (widget.inputType == VotixInputType.phone) {
      formatters.add(FilteringTextInputFormatter.digitsOnly);
      // You could add a phone number formatter here
    }

    // Add any custom formatters provided
    if (widget.inputFormatters != null) {
      formatters.addAll(widget.inputFormatters!);
    }

    return formatters;
  }

  // Get appropriate max lines based on input type
  int? _getMaxLines() {
    if (widget.maxLines != null) {
      return widget.maxLines;
    }

    if (widget.inputType == VotixInputType.multiline) {
      return null; // Unlimited lines for multiline input
    } else if (widget.inputType == VotixInputType.password) {
      return 1; // Password fields are always single line
    }

    return 1; // Default to single line
  }

  // Get default validator based on input type
  String? Function(String?)? _getDefaultValidator() {
    if (widget.validator != null) {
      return widget.validator;
    }

    if (!widget.required) {
      return null;
    }

    // Only provide default validators for required fields
    switch (widget.inputType) {
      case VotixInputType.email:
        return (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter an email address';
          }

          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return 'Please enter a valid email address';
          }

          return null;
        };

      case VotixInputType.password:
        return (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }

          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }

          return null;
        };

      case VotixInputType.phone:
        return (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a phone number';
          }

          if (value.length < 10) {
            return 'Please enter a valid phone number';
          }

          return null;
        };

      case VotixInputType.url:
        return (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a URL';
          }

          final urlRegex = RegExp(
            r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
          );
          if (!urlRegex.hasMatch(value)) {
            return 'Please enter a valid URL';
          }

          return null;
        };

      default:
        return (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        };
    }
  }
}
