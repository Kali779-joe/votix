import 'package:flutter/material.dart';

import '../utils/constants/app_color.dart';


/// Button variants determine the visual style of the button
enum VotixButtonVariant {
  /// Primary buttons use solid background with brand colors
  primary,

  /// Secondary buttons use mint colors instead of purple
  secondary,

  /// Outline buttons have a transparent background with colored border
  outline,

  /// Text buttons have no background or border, just text and optional icon
  text,

  /// Gradient buttons use beautiful gradients from the app theme
  gradient,
}

/// Button sizes for different contexts
enum VotixButtonSize {
  /// Small buttons for tight spaces
  small,

  /// Medium buttons for most standard uses
  medium,

  /// Large buttons for prominent actions
  large,
}

/// VotixButton is a reusable button component that adapts to the current theme
/// and provides consistent styling across the application
class VotixButton extends StatelessWidget {
  /// Text to display on the button
  final String text;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Visual style of the button
  final VotixButtonVariant variant;

  /// Size of the button
  final VotixButtonSize size;

  /// Optional icon to show before text
  final IconData? leadingIcon;

  /// Optional icon to show after text
  final IconData? trailingIcon;

  /// Whether to show a loading indicator instead of text/icons
  final bool isLoading;

  /// Optional icon size override
  final double? iconSize;

  /// Optional width to make button fill available space
  final double? width;

  /// Optional custom gradient for gradient variant
  final LinearGradient? customGradient;

  /// Optional rounded corners radius
  final double? borderRadius;

  /// Optional elevation for the button
  final double? elevation;

  const VotixButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = VotixButtonVariant.primary,
    this.size = VotixButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.iconSize,
    this.width,
    this.customGradient,
    this.borderRadius,
    this.elevation,


  });

  @override
  Widget build(BuildContext context) {
    // Get the current theme and brightness
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Define sizes based on the button size enum
    final buttonSize = _getButtonSize();
    final buttonTextStyle = _getTextStyle(theme);
    final calculatedIconSize = iconSize ?? buttonSize.height * 0.4;
    final calculatedBorderRadius = borderRadius ?? (buttonSize.height * 0.25);

    // Create the button based on variant
    switch (variant) {
      case VotixButtonVariant.gradient:
        return _buildGradientButton(
          context,
          buttonSize,
          buttonTextStyle,
          calculatedIconSize,
          calculatedBorderRadius,
        );

      case VotixButtonVariant.outline:
      case VotixButtonVariant.text:
        return _buildOutlineOrTextButton(
          context,
          buttonSize,
          buttonTextStyle,
          calculatedIconSize,
          calculatedBorderRadius,
        );

      case VotixButtonVariant.primary:
      case VotixButtonVariant.secondary:
      default:
        return _buildSolidButton(
          context,
          buttonSize,
          buttonTextStyle,
          calculatedIconSize,
          calculatedBorderRadius,
        );
    }
  }

  // Helper method to build gradient buttons
  Widget _buildGradientButton(
      BuildContext context,
      Size buttonSize,
      TextStyle buttonTextStyle,
      double iconSize,
      double borderRadius,
      ) {
    final gradient = customGradient ?? _getGradientForVariant(context);

    return Material(
      elevation: elevation ?? 2,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Container(
            width: width,
            height: buttonSize.height,
            padding: EdgeInsets.symmetric(horizontal: buttonSize.width),
            child: _buildButtonContent(
              context,
              buttonTextStyle,
              iconSize,
              Colors.white, // Text color for gradient buttons is always white
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build solid buttons (primary/secondary)
  Widget _buildSolidButton(
      BuildContext context,
      Size buttonSize,
      TextStyle buttonTextStyle,
      double iconSize,
      double borderRadius,
      ) {
    final backgroundColor = _getBackgroundColor(context);
    final foregroundColor = _getForegroundColor(context);

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width ?? buttonSize.width * 2, buttonSize.height),
        padding: EdgeInsets.symmetric(horizontal: buttonSize.width),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: _buildButtonContent(
        context,
        buttonTextStyle,
        iconSize,
        foregroundColor,
      ),
    );
  }

  // Helper method to build outline or text buttons
  Widget _buildOutlineOrTextButton(
      BuildContext context,
      Size buttonSize,
      TextStyle buttonTextStyle,
      double iconSize,
      double borderRadius,
      ) {
    final foregroundColor = _getForegroundColor(context);
    final isOutline = variant == VotixButtonVariant.outline;

    if (isOutline) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          elevation: elevation,
          foregroundColor: foregroundColor,
          minimumSize: Size(width ?? buttonSize.width * 2, buttonSize.height),
          padding: EdgeInsets.symmetric(horizontal: buttonSize.width),
          side: BorderSide(color: foregroundColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: _buildButtonContent(
          context,
          buttonTextStyle,
          iconSize,
          foregroundColor,
        ),
      );
    } else {
      return TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          elevation: elevation,
          foregroundColor: foregroundColor,
          minimumSize: Size(width ?? buttonSize.width * 2, buttonSize.height),
          padding: EdgeInsets.symmetric(
            horizontal: buttonSize.width / 2, // Less padding for text buttons
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: _buildButtonContent(
          context,
          buttonTextStyle,
          iconSize,
          foregroundColor,
        ),
      );
    }
  }

  // Helper method to build the button content (text, icons, loader)
  Widget _buildButtonContent(
      BuildContext context,
      TextStyle textStyle,
      double iconSize,
      Color contentColor,
      ) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: iconSize * 1.2,
          height: iconSize * 1.2,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(contentColor),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: iconSize, color: contentColor),
          SizedBox(width: iconSize / 2),
        ],
        Text(text, style: textStyle.copyWith(color: contentColor)),
        if (trailingIcon != null) ...[
          SizedBox(width: iconSize / 2),
          Icon(trailingIcon, size: iconSize, color: contentColor),
        ],
      ],
    );
  }

  // Get button size based on the size enum
  Size _getButtonSize() {
    switch (size) {
      case VotixButtonSize.small:
        return const Size(16, 36);
      case VotixButtonSize.large:
        return const Size(32, 56);
      case VotixButtonSize.medium:
      default:
        return const Size(24, 48);
    }
  }

  // Get text style based on the button size
  TextStyle _getTextStyle(ThemeData theme) {
    switch (size) {
      case VotixButtonSize.small:
        return theme.textTheme.labelMedium ??
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
      case VotixButtonSize.large:
        return theme.textTheme.titleMedium ??
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
      case VotixButtonSize.medium:
      default:
        return theme.textTheme.labelLarge ??
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
    }
  }

  // Get background color based on the variant and theme
  Color _getBackgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (variant) {
      case VotixButtonVariant.secondary:
        return isDark ? VotixColors.darkModeMint : VotixColors.primaryMint;
      case VotixButtonVariant.outline:
      case VotixButtonVariant.text:
        return Colors.transparent;
      case VotixButtonVariant.primary:
      case VotixButtonVariant.gradient:
      default:
        return VotixColors.primaryPurple;
    }
  }

  // Get foreground (text/icon) color based on the variant and theme
  Color _getForegroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (variant) {
      case VotixButtonVariant.primary:
      case VotixButtonVariant.gradient:
        return Colors.white;
      case VotixButtonVariant.secondary:
        return isDark ? Colors.white : VotixColors.primaryPurple;
      case VotixButtonVariant.outline:
      case VotixButtonVariant.text:
        return isDark ? VotixColors.darkModeMint : VotixColors.primaryPurple;
      default:
        return Colors.white;
    }
  }

  // Get gradient based on the variant
  LinearGradient _getGradientForVariant(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Using gradients from your VotixColors
    if (variant == VotixButtonVariant.secondary) {
      return VotixColors.secondaryButtonGradient;
    } else {
      return VotixColors.primaryButtonGradient;
    }
  }
}
