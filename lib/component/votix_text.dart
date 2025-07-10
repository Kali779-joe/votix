import 'package:flutter/material.dart';

import '../utils/constants/app_color.dart';


/// Text style variants to match Material 3 typography scale
enum VotixTextStyle {
  /// Display Large - Used for the largest headlines (57px)
  displayLarge,

  /// Display Medium - Used for large headlines (45px)
  displayMedium,

  /// Display Small - Used for primary headlines (36px)
  displaySmall,

  /// Headline Large - Major section headers (32px)
  headlineLarge,

  /// Headline Medium - Section headers (28px)
  headlineMedium,

  /// Headline Small - Subsection headers (24px)
  headlineSmall,

  /// Title Large - Major UI elements like screen titles (22px)
  titleLarge,

  /// Title Medium - Medium-emphasis titles (16px)
  titleMedium,

  /// Title Small - Minor titles and labels (14px)
  titleSmall,

  /// Body Large - Primary body text (16px)
  bodyLarge,

  /// Body Medium - Standard body text (14px)
  bodyMedium,

  /// Body Small - Secondary body text, captions (12px)
  bodySmall,

  /// Label Large - Primary labels (14px bold)
  labelLarge,

  /// Label Medium - Secondary labels (12px bold)
  labelMedium,

  /// Label Small - Smallest labels, auxiliary text (11px bold)
  labelSmall,
}

/// Text color variants for different contexts
enum VotixTextEmphasis {
  /// High emphasis text (primary text)
  high,

  /// Medium emphasis text (secondary text)
  medium,

  /// Low emphasis text (disabled or hint text)
  low,

  /// Primary brand color (purple in light mode)
  brand,

  /// Secondary brand color (mint)
  secondary,

  /// For errors and warnings
  error,

  /// For success messages
  success,

  /// Inverted color based on current theme (white on dark, black on light)
  inverted,
}

/// Visual decorations for text
enum VotixTextDecoration {
  /// No decoration
  none,

  /// Underlined text
  underline,

  /// Strikethrough text
  lineThrough,

  /// Overline text
  overline,

  /// Gradient text (only works with isFilled: true)
  gradient,
}

/// A professional, customizable text component that adapts to the current theme
class VotixText extends StatelessWidget {
  /// The text to display
  final String text;

  /// The typography style variant
  final VotixTextStyle style;

  /// The emphasis level affecting color
  final VotixTextEmphasis emphasis;

  /// Optional custom color (overrides emphasis)
  final Color? color;

  /// Text decoration type
  final VotixTextDecoration decoration;

  /// Whether to make text bold
  final bool isBold;

  /// Whether to make text italic
  final bool isItalic;

  /// Whether to use a gradient fill (enables ShaderMask)
  final bool isFilled;

  /// Custom gradient for gradient decoration
  final Gradient? gradient;

  /// Maximum number of lines before truncating
  final int? maxLines;

  /// How to handle overflow
  final TextOverflow overflow;

  /// Text alignment
  final TextAlign textAlign;

  /// Whether to soften text (reduce opacity)
  final bool isSoftened;

  /// Scale factor for the text (1.0 = 100%)
  final double textScaleFactor;

  /// Letter spacing adjustment
  final double? letterSpacing;

  /// Line height multiplier
  final double? lineHeight;

  /// Whether text should automatically adjust its font size to fit within its bounds
  final bool autoSize;

  /// Minimum text size for autoSize
  final double? minFontSize;

  /// Whether to selectable (for copy/paste)
  final bool selectable;

  /// Optional semantic label for accessibility
  final String? semanticLabel;

  const VotixText(
      this.text, {
        super.key,
        this.style = VotixTextStyle.bodyMedium,
        this.emphasis = VotixTextEmphasis.high,
        this.color,
        this.decoration = VotixTextDecoration.none,
        this.isBold = false,
        this.isItalic = false,
        this.isFilled = false,
        this.gradient,
        this.maxLines,
        this.overflow = TextOverflow.ellipsis,
        this.textAlign = TextAlign.start,
        this.isSoftened = false,
        this.textScaleFactor = 1.0,
        this.letterSpacing,
        this.lineHeight,
        this.autoSize = false,
        this.minFontSize,
        this.selectable = false,
        this.semanticLabel,
      });

  /// Convenience constructor for display text
  factory VotixText.display(
      String text, {
        Key? key,
        VotixTextStyle style = VotixTextStyle.displayMedium,
        VotixTextEmphasis emphasis = VotixTextEmphasis.high,
        Color? color,
        bool isBold = false,
        bool isItalic = false,
        bool isFilled = false,
        Gradient? gradient,
        TextAlign textAlign = TextAlign.start,
        double textScaleFactor = 1.0,
        double? letterSpacing,
        String? semanticLabel,
      }) {
    return VotixText(
      text,
      key: key,
      style: style,
      emphasis: emphasis,
      color: color,
      isBold: isBold,
      isItalic: isItalic,
      isFilled: isFilled,
      gradient: gradient,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
      letterSpacing: letterSpacing,
      semanticLabel: semanticLabel,
    );
  }

  /// Convenience constructor for headline text
  factory VotixText.headline(
      String text, {
        Key? key,
        VotixTextStyle style = VotixTextStyle.headlineMedium,
        VotixTextEmphasis emphasis = VotixTextEmphasis.high,
        Color? color,
        bool isBold = false,
        bool isItalic = false,
        bool isFilled = false,
        Gradient? gradient,
        TextAlign textAlign = TextAlign.start,
        double textScaleFactor = 1.0,
        double? letterSpacing,
        String? semanticLabel,
      }) {
    return VotixText(
      text,
      key: key,
      style: style,
      emphasis: emphasis,
      color: color,
      isBold: isBold,
      isItalic: isItalic,
      isFilled: isFilled,
      gradient: gradient,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
      letterSpacing: letterSpacing,
      semanticLabel: semanticLabel,
    );
  }

  /// Convenience constructor for title text
  factory VotixText.title(
      String text, {
        Key? key,
        VotixTextStyle style = VotixTextStyle.titleMedium,
        VotixTextEmphasis emphasis = VotixTextEmphasis.high,
        Color? color,
        bool isBold = false,
        bool isItalic = false,
        bool isFilled = false,
        Gradient? gradient,
        TextAlign textAlign = TextAlign.start,
        double textScaleFactor = 1.0,
        double? letterSpacing,
        int? maxLines,
        TextOverflow overflow = TextOverflow.ellipsis,
        String? semanticLabel,
      }) {
    return VotixText(
      text,
      key: key,
      style: style,
      emphasis: emphasis,
      color: color,
      isBold: isBold,
      isItalic: isItalic,
      isFilled: isFilled,
      gradient: gradient,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
      letterSpacing: letterSpacing,
      maxLines: maxLines,
      overflow: overflow,
      semanticLabel: semanticLabel,
    );
  }

  /// Convenience constructor for body text
  factory VotixText.body(
      String text, {
        Key? key,
        VotixTextStyle style = VotixTextStyle.bodyMedium,
        VotixTextEmphasis emphasis = VotixTextEmphasis.high,
        Color? color,
        bool isBold = false,
        bool isItalic = false,
        VotixTextDecoration decoration = VotixTextDecoration.none,
        TextAlign textAlign = TextAlign.start,
        int? maxLines,
        TextOverflow overflow = TextOverflow.ellipsis,
        double? lineHeight,
        double textScaleFactor = 1.0,
        bool isSoftened = false,
        String? semanticLabel,
      }) {
    return VotixText(
      text,
      key: key,
      style: style,
      emphasis: emphasis,
      color: color,
      isBold: isBold,
      isItalic: isItalic,
      decoration: decoration,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      lineHeight: lineHeight,
      textScaleFactor: textScaleFactor,
      isSoftened: isSoftened,
      semanticLabel: semanticLabel,
    );
  }

  /// Convenience constructor for caption and label text
  factory VotixText.label(
      String text, {
        Key? key,
        VotixTextStyle style = VotixTextStyle.labelMedium,
        VotixTextEmphasis emphasis = VotixTextEmphasis.medium,
        Color? color,
        bool isBold = false,
        bool isItalic = false,
        TextAlign textAlign = TextAlign.start,
        int? maxLines,
        TextOverflow overflow = TextOverflow.ellipsis,
        bool isSoftened = false,
        String? semanticLabel,
      }) {
    return VotixText(
      text,
      key: key,
      style: style,
      emphasis: emphasis,
      color: color,
      isBold: isBold,
      isItalic: isItalic,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      isSoftened: isSoftened,
      semanticLabel: semanticLabel,
    );
  }

  /// Convenience constructor for gradient filled text
  factory VotixText.gradient(
      String text, {
        Key? key,
        VotixTextStyle style = VotixTextStyle.titleLarge,
        Gradient? gradient,
        bool isBold = true,
        bool isItalic = false,
        TextAlign textAlign = TextAlign.start,
        double textScaleFactor = 1.0,
        String? semanticLabel,
      }) {
    return VotixText(
      text,
      key: key,
      style: style,
      isBold: isBold,
      isItalic: isItalic,
      isFilled: true,
      decoration: VotixTextDecoration.gradient,
      gradient: gradient,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
      semanticLabel: semanticLabel,
    );
  }

  /// Convenience constructor for error text
  factory VotixText.error(
      String text, {
        Key? key,
        VotixTextStyle style = VotixTextStyle.bodySmall,
        bool isBold = false,
        TextAlign textAlign = TextAlign.start,
        int? maxLines,
        String? semanticLabel,
      }) {
    return VotixText(
      text,
      key: key,
      style: style,
      emphasis: VotixTextEmphasis.error,
      isBold: isBold,
      textAlign: textAlign,
      maxLines: maxLines,
      semanticLabel: semanticLabel ?? 'Error: $text',
    );
  }

  /// Convenience constructor for success text
  factory VotixText.success(
      String text, {
        Key? key,
        VotixTextStyle style = VotixTextStyle.bodySmall,
        bool isBold = false,
        TextAlign textAlign = TextAlign.start,
        int? maxLines,
        String? semanticLabel,
      }) {
    return VotixText(
      text,
      key: key,
      style: style,
      emphasis: VotixTextEmphasis.success,
      isBold: isBold,
      textAlign: textAlign,
      maxLines: maxLines,
      semanticLabel: semanticLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Get base text style from theme based on variant
    TextStyle textStyle = _getBaseTextStyle(theme);

    // Apply color based on emphasis
    final textColor = color ?? _getEmphasisColor(context, isDark);
    textStyle = textStyle.copyWith(color: textColor);

    // Apply weight if bold
    if (isBold) {
      textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
    }

    // Apply italic style if needed
    if (isItalic) {
      textStyle = textStyle.copyWith(fontStyle: FontStyle.italic);
    }

    // Apply text decoration
    if (decoration != VotixTextDecoration.none &&
        decoration != VotixTextDecoration.gradient) {
      textStyle = textStyle.copyWith(decoration: _getTextDecoration());
    }

    // Apply letter spacing if provided
    if (letterSpacing != null) {
      textStyle = textStyle.copyWith(letterSpacing: letterSpacing);
    }

    // Apply line height if provided
    if (lineHeight != null) {
      textStyle = textStyle.copyWith(height: lineHeight);
    }

    // Apply softened style (reduced opacity)
    if (isSoftened) {
      textStyle = textStyle.copyWith(color: textStyle.color!.withOpacity(0.7));
    }

    // Build the text widget with the computed style
    Widget textWidget;

    if (selectable) {
      textWidget = SelectableText(
        text,
        style: textStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        textScaler: TextScaler.linear(textScaleFactor),
        semanticsLabel: semanticLabel,
      );
    } else if (autoSize) {
      textWidget = _buildAutoSizeText(textStyle);
    } else {
      textWidget = Text(
        text,
        style: textStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        textScaler: TextScaler.linear(textScaleFactor),
        semanticsLabel: semanticLabel,
      );
    }

    // Apply gradient if needed (requires ShaderMask)
    if (isFilled &&
        (decoration == VotixTextDecoration.gradient || gradient != null)) {
      return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) =>
            (gradient ?? _getDefaultGradient(isDark)).createShader(bounds),
        child: textWidget,
      );
    }

    return textWidget;
  }

  // Helper method to build auto-sizing text
  Widget _buildAutoSizeText(TextStyle textStyle) {
    // A simplified auto-size implementation
    // For a more robust solution, consider using the auto_size_text package
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate font size to fit width
        final textSpan = TextSpan(text: text, style: textStyle);

        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: maxLines,
        );

        // Try to fit text
        double fontSize = textStyle.fontSize!;
        final minSize = minFontSize ?? fontSize * 0.7;

        textPainter.layout(maxWidth: constraints.maxWidth);

        // If text overflows, reduce font size until it fits or reaches min size
        while (textPainter.didExceedMaxLines && fontSize > minSize) {
          fontSize -= 1;
          final newStyle = textStyle.copyWith(fontSize: fontSize);
          textPainter.text = TextSpan(text: text, style: newStyle);
          textPainter.layout(maxWidth: constraints.maxWidth);
        }

        return Text(
          text,
          style: textStyle.copyWith(fontSize: fontSize),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          textScaler: TextScaler.linear(textScaleFactor),
          semanticsLabel: semanticLabel,
        );
      },
    );
  }

  // Get the base text style from the theme based on variant
  TextStyle _getBaseTextStyle(ThemeData theme) {
    switch (style) {
      case VotixTextStyle.displayLarge:
        return theme.textTheme.displayLarge!;
      case VotixTextStyle.displayMedium:
        return theme.textTheme.displayMedium!;
      case VotixTextStyle.displaySmall:
        return theme.textTheme.displaySmall!;
      case VotixTextStyle.headlineLarge:
        return theme.textTheme.headlineLarge!;
      case VotixTextStyle.headlineMedium:
        return theme.textTheme.headlineMedium!;
      case VotixTextStyle.headlineSmall:
        return theme.textTheme.headlineSmall!;
      case VotixTextStyle.titleLarge:
        return theme.textTheme.titleLarge!;
      case VotixTextStyle.titleMedium:
        return theme.textTheme.titleMedium!;
      case VotixTextStyle.titleSmall:
        return theme.textTheme.titleSmall!;
      case VotixTextStyle.bodyLarge:
        return theme.textTheme.bodyLarge!;
      case VotixTextStyle.bodyMedium:
        return theme.textTheme.bodyMedium!;
      case VotixTextStyle.bodySmall:
        return theme.textTheme.bodySmall!;
      case VotixTextStyle.labelLarge:
        return theme.textTheme.labelLarge!;
      case VotixTextStyle.labelMedium:
        return theme.textTheme.labelMedium!;
      case VotixTextStyle.labelSmall:
        return theme.textTheme.labelSmall!;
    }
  }

  // Get color based on emphasis level
  Color _getEmphasisColor(BuildContext context, bool isDark) {
    switch (emphasis) {
      case VotixTextEmphasis.high:
        return isDark
            ? VotixColors.darkTextPrimary
            : VotixColors.lightTextPrimary;
      case VotixTextEmphasis.medium:
        return isDark
            ? VotixColors.darkTextSecondary
            : VotixColors.lightTextSecondary;
      case VotixTextEmphasis.low:
        return isDark ? VotixColors.darkDisabled : VotixColors.lightDisabled;
      case VotixTextEmphasis.brand:
        return isDark ? VotixColors.softLavender : VotixColors.primaryPurple;
      case VotixTextEmphasis.secondary:
        return isDark ? VotixColors.darkModeMint : VotixColors.primaryMint;
      case VotixTextEmphasis.error:
        return VotixColors.error;
      case VotixTextEmphasis.success:
        return VotixColors.success;
      case VotixTextEmphasis.inverted:
        return isDark
            ? VotixColors.lightTextPrimary
            : VotixColors.darkTextPrimary;
    }
  }

  // Get text decoration based on decoration type
  TextDecoration _getTextDecoration() {
    switch (decoration) {
      case VotixTextDecoration.underline:
        return TextDecoration.underline;
      case VotixTextDecoration.lineThrough:
        return TextDecoration.lineThrough;
      case VotixTextDecoration.overline:
        return TextDecoration.overline;
      case VotixTextDecoration.gradient:
      case VotixTextDecoration.none:
      default:
        return TextDecoration.none;
    }
  }

  // Get default gradient for gradient text
  Gradient _getDefaultGradient(bool isDark) {
    if (isDark) {
      return LinearGradient(
        colors: const [VotixColors.darkModeMint, VotixColors.softLavender],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return LinearGradient(
        colors: const [VotixColors.primaryPurple, VotixColors.primaryMint],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }
}
