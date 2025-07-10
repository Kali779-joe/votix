import 'package:flutter/material.dart';

import 'app_color.dart';

/// VotixTheme provides complete theme configuration for the Votix application
/// based on the color palette defined in VotixColors
class VotixTheme {
  /// Get the appropriate color scheme based on brightness
  static ColorScheme getColorScheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    if (brightness == Brightness.light) {
      return const ColorScheme(
        brightness: Brightness.light,
        primary: VotixColors.primaryPurple,
        onPrimary: Colors.white,
        primaryContainer: Color(0xFFEBE3F5),
        onPrimaryContainer: Color(0xFF30094C),
        secondary: VotixColors.primaryMint,
        onSecondary: Color(0xFF0A3323),
        secondaryContainer: Color(0xFFD9F5EA),
        onSecondaryContainer: Color(0xFF0A3323),
        tertiary: VotixColors.accentTeal,
        onTertiary: Colors.white,
        tertiaryContainer: Color(0xFFD2EDF3),
        onTertiaryContainer: Color(0xFF0A363F),
        // Using replacement for deprecated 'background'
        surface: VotixColors.lightBackground,
        // Using replacement for deprecated 'onBackground'
        onSurface: VotixColors.lightTextPrimary,
        surfaceContainerLowest: VotixColors.lightSurfaceContainerLowest,
        surfaceContainerLow: VotixColors.lightSurfaceContainerLow,
        surfaceContainer: VotixColors.lightSurfaceContainer,
        surfaceContainerHigh: VotixColors.lightSurfaceContainerHigh,
        surfaceContainerHighest: VotixColors.lightSurfaceContainerHighest,
        surfaceDim: VotixColors.lightSurface,
        surfaceBright: VotixColors.lightSurface,
        error: VotixColors.error,
        onError: Colors.white,
        errorContainer: Color(0xFFFCE8E6),
        onErrorContainer: Color(0xFF621B16),
        outline: VotixColors.lightDivider,
        outlineVariant: Color(0xFFDED9E6),
        shadow: Color(0x29000000),
        scrim: Color(0x52000000),
        inverseSurface: VotixColors.darkSurface,
        onInverseSurface: VotixColors.darkTextPrimary,
        inversePrimary: VotixColors.primaryMint,
      );
    } else {
      return const ColorScheme(
        brightness: Brightness.dark,
        primary: VotixColors.primaryPurple,
        onPrimary: Colors.white,
        primaryContainer: Color(0xFF3D1D5C),
        onPrimaryContainer: Color(0xFFEADFF8),
        secondary:
        VotixColors.darkModeMint, // Slightly desaturated mint for dark mode
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFF16594A),
        onSecondaryContainer: Color(0xFFD9F5EA),
        tertiary: VotixColors.accentTeal,
        onTertiary: Colors.white,
        tertiaryContainer: Color(0xFF164954),
        onTertiaryContainer: Color(0xFFD2EDF3),
        // Using replacement for deprecated 'background'
        surface: VotixColors.darkBackground,
        // Using replacement for deprecated 'onBackground'
        onSurface: VotixColors.darkTextPrimary,
        surfaceContainerLowest: VotixColors.darkSurfaceContainerLowest,
        surfaceContainerLow: VotixColors.darkSurfaceContainerLow,
        surfaceContainer: VotixColors.darkSurfaceContainer,
        surfaceContainerHigh: VotixColors.darkSurfaceContainerHigh,
        surfaceContainerHighest: VotixColors.darkSurfaceContainerHighest,
        surfaceDim: VotixColors.darkSurface,
        surfaceBright: VotixColors.darkSurface,
        error: VotixColors.error,
        onError: Colors.white,
        errorContainer: Color(0xFF621B16),
        onErrorContainer: Color(0xFFFCE8E6),
        outline: VotixColors.darkDivider,
        outlineVariant: Color(0xFF3E3649),
        shadow: Color(0x52000000),
        scrim: Color(0x80000000),
        inverseSurface: VotixColors.lightSurface,
        onInverseSurface: VotixColors.lightTextPrimary,
        inversePrimary: VotixColors.primaryMint,
      );
    }
  }

  /// Get the light theme
  static ThemeData getLightTheme() {
    return _getTheme(Brightness.light);
  }

  /// Get the dark theme
  static ThemeData getDarkTheme() {
    return _getTheme(Brightness.dark);
  }

  /// Internal method to construct the ThemeData
  static ThemeData _getTheme(Brightness brightness) {
    final colorScheme = getColorScheme(brightness);
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,
      scaffoldBackgroundColor: isDark
          ? VotixColors.darkBackground
          : VotixColors.lightBackground,

      // Typography
      textTheme: _getTextTheme(brightness),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: isDark
            ? VotixColors.darkSurface
            : VotixColors.lightSurface,
        foregroundColor: isDark
            ? VotixColors.darkTextPrimary
            : VotixColors.primaryPurple,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: isDark
              ? VotixColors.darkTextPrimary
              : VotixColors.primaryPurple,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
        scrolledUnderElevation: 2,
        shadowColor: colorScheme.shadow,
      ),

      // Card Theme - Updated to CardThemeData
      cardTheme: CardThemeData(
        color: isDark ? VotixColors.darkCard : VotixColors.lightCard,
        elevation: 1,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: colorScheme.shadow,
      ),

      // BottomNavigationBar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: isDark
            ? VotixColors.darkModeMint
            : VotixColors.primaryMint,
        unselectedItemColor: isDark
            ? VotixColors.darkDisabled
            : VotixColors.lightDisabled,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),

      // FloatingActionButton Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: VotixColors.primaryMint,
        foregroundColor: Colors.white,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        extendedPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
      ),

      // ElevatedButton Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: VotixColors.primaryPurple,
          foregroundColor: Colors.white,
          minimumSize: const Size(120, 48),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // OutlinedButton Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: VotixColors.primaryPurple,
          side: BorderSide(
            color: isDark
                ? VotixColors.primaryPurple.withAlpha(200)
                : VotixColors.primaryPurple,
            width: 1.5,
          ),
          minimumSize: const Size(120, 48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // TextButton Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark
              ? VotixColors.darkModeMint
              : VotixColors.primaryPurple,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Checkbox Theme - Updated to use WidgetStateProperty instead of MaterialStateProperty
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return isDark
                ? VotixColors.darkDisabled
                : VotixColors.lightDisabled;
          }
          if (states.contains(WidgetState.selected)) {
            return isDark ? VotixColors.darkModeMint : VotixColors.primaryMint;
          }
          return isDark ? VotixColors.darkDisabled : VotixColors.lightDisabled;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(
          color: isDark ? VotixColors.darkDivider : VotixColors.lightDivider,
          width: 1.5,
        ),
      ),

      // Radio Theme - Updated to use WidgetStateProperty instead of MaterialStateProperty
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return isDark
                ? VotixColors.darkDisabled
                : VotixColors.lightDisabled;
          }
          if (states.contains(WidgetState.selected)) {
            return isDark ? VotixColors.darkModeMint : VotixColors.primaryMint;
          }
          return isDark ? VotixColors.darkDisabled : VotixColors.lightDisabled;
        }),
      ),

      // Switch Theme - Updated to use WidgetStateProperty instead of MaterialStateProperty
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return isDark
                ? VotixColors.darkDisabled
                : VotixColors.lightDisabled;
          }
          if (states.contains(WidgetState.selected)) {
            return isDark ? VotixColors.darkModeMint : VotixColors.primaryMint;
          }
          return isDark ? Colors.grey.shade400 : Colors.grey.shade50;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return isDark
                ? VotixColors.darkDisabled.withAlpha(77)
                : VotixColors.lightDisabled.withAlpha(77);
          }
          if (states.contains(WidgetState.selected)) {
            return isDark
                ? VotixColors.darkModeMint.withAlpha(128)
                : VotixColors.primaryMint.withAlpha(128);
          }
          return isDark
              ? Colors.grey.shade700.withAlpha(128)
              : Colors.grey.shade300.withAlpha(128);
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.transparent;
          }
          return Colors.transparent;
        }),
      ),

      // Other Theme Elements
      dividerColor: isDark ? VotixColors.darkDivider : VotixColors.lightDivider,
      dividerTheme: DividerThemeData(
        color: isDark ? VotixColors.darkDivider : VotixColors.lightDivider,
        thickness: 1,
        space: 16,
      ),

      disabledColor: isDark
          ? VotixColors.darkDisabled
          : VotixColors.lightDisabled,

      // Dialog Theme - Updated to DialogThemeData
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        alignment: Alignment.center,
      ),

      // SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark
            ? VotixColors.darkCard
            : VotixColors.primaryPurple,
        contentTextStyle: TextStyle(
          color: isDark ? VotixColors.darkTextPrimary : Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
        elevation: 6,
        actionTextColor: isDark
            ? VotixColors.darkModeMint
            : VotixColors.primaryMint,
      ),

      // InputDecoration Theme
      inputDecorationTheme: InputDecorationTheme(
        fillColor: isDark
            ? VotixColors.darkSurface.withAlpha(204)
            : VotixColors.lightBackground,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? VotixColors.darkDivider : VotixColors.lightDivider,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? VotixColors.darkDivider : VotixColors.lightDivider,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? VotixColors.darkModeMint : VotixColors.primaryMint,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: VotixColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: VotixColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: TextStyle(
          color: isDark
              ? VotixColors.darkTextSecondary
              : VotixColors.lightTextSecondary,
          fontSize: 16,
        ),
        labelStyle: TextStyle(
          color: isDark
              ? VotixColors.darkTextSecondary
              : VotixColors.lightTextSecondary,
          fontSize: 16,
        ),
        helperStyle: TextStyle(
          color: isDark
              ? VotixColors.darkTextSecondary
              : VotixColors.lightTextSecondary,
          fontSize: 12,
        ),
        errorStyle: TextStyle(color: VotixColors.error, fontSize: 12),
      ),

      // TabBar Theme - Updated to TabBarThemeData
      tabBarTheme: TabBarThemeData(
        labelColor: isDark ? VotixColors.darkModeMint : VotixColors.primaryMint,
        unselectedLabelColor: isDark
            ? VotixColors.darkDisabled
            : VotixColors.lightDisabled,
        indicatorColor: isDark
            ? VotixColors.darkModeMint
            : VotixColors.primaryMint,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: isDark
            ? VotixColors.darkSurface
            : VotixColors.lightBackground,
        disabledColor: isDark
            ? VotixColors.darkDisabled.withAlpha(26)
            : VotixColors.lightDisabled.withAlpha(26),
        selectedColor: isDark
            ? VotixColors.darkModeMint
            : VotixColors.primaryMint,
        secondarySelectedColor: VotixColors.primaryPurple,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: TextStyle(
          color: isDark
              ? VotixColors.darkTextPrimary
              : VotixColors.lightTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        secondaryLabelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(
          color: isDark ? VotixColors.darkDivider : VotixColors.lightDivider,
          width: 1,
        ),
      ),

      // ListTile Theme
      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        selectedTileColor: isDark
            ? VotixColors.primaryPurple.withAlpha(51)
            : VotixColors.primaryPurple.withAlpha(26),
        iconColor: isDark
            ? VotixColors.darkTextPrimary
            : VotixColors.primaryPurple,
        textColor: isDark
            ? VotixColors.darkTextPrimary
            : VotixColors.lightTextPrimary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minLeadingWidth: 24,
        minVerticalPadding: 12,
      ),

      // Slider Theme
      sliderTheme: SliderThemeData(
        activeTrackColor: isDark
            ? VotixColors.darkModeMint
            : VotixColors.primaryMint,
        inactiveTrackColor: isDark
            ? VotixColors.darkDisabled.withAlpha(77)
            : VotixColors.lightDisabled.withAlpha(77),
        thumbColor: isDark ? VotixColors.darkModeMint : VotixColors.primaryMint,
        overlayColor:
        (isDark ? VotixColors.darkModeMint : VotixColors.primaryMint)
            .withAlpha(51),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
      ),

      // ProgressIndicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isDark ? VotixColors.darkModeMint : VotixColors.primaryMint,
        circularTrackColor: isDark
            ? VotixColors.darkDisabled.withAlpha(51)
            : VotixColors.lightDisabled.withAlpha(51),
        linearTrackColor: isDark
            ? VotixColors.darkDisabled.withAlpha(51)
            : VotixColors.lightDisabled.withAlpha(51),
        refreshBackgroundColor: isDark
            ? VotixColors.darkSurface
            : VotixColors.lightSurface,
      ),

      // BottomSheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isDark
            ? VotixColors.darkSurface
            : VotixColors.lightSurface,
        modalBackgroundColor: isDark
            ? VotixColors.darkSurface
            : VotixColors.lightSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        elevation: 16,
        modalElevation: 16,
      ),

      // PopupMenu Theme
      popupMenuTheme: PopupMenuThemeData(
        color: isDark ? VotixColors.darkSurface : VotixColors.lightSurface,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: TextStyle(
          color: isDark
              ? VotixColors.darkTextPrimary
              : VotixColors.lightTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      // DrawerTheme
      drawerTheme: DrawerThemeData(
        backgroundColor: isDark
            ? VotixColors.darkSurface
            : VotixColors.lightSurface,
        scrimColor: Colors.black.withAlpha(77),
        elevation: 16,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
        ),
      ),
    );
  }

  /// Custom text theme
  static TextTheme _getTextTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final textColor = isDark
        ? VotixColors.darkTextPrimary
        : VotixColors.lightTextPrimary;

    return TextTheme(
      displayLarge: TextStyle(
        color: textColor,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        color: textColor,
        fontSize: 45,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        color: textColor,
        fontSize: 36,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        color: textColor,
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: textColor,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: textColor,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: textColor,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      titleMedium: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        color: isDark
            ? VotixColors.darkTextSecondary
            : VotixColors.lightTextSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelLarge: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        color: isDark
            ? VotixColors.darkTextSecondary
            : VotixColors.lightTextSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        color: isDark
            ? VotixColors.darkTextSecondary
            : VotixColors.lightTextSecondary,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Custom gradient decorations for specific UI components
  static BoxDecoration getVotingCardDecoration() {
    return BoxDecoration(
      gradient: VotixColors.votingCardGradient,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x40000000),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    );
  }

  /// Primary button decoration with gradient
  static BoxDecoration getPrimaryButtonDecoration() {
    return BoxDecoration(
      gradient: VotixColors.primaryButtonGradient,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x29000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  /// Get an app bar decoration with gradient
  static BoxDecoration getGradientAppBarDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: const [VotixColors.primaryPurple, VotixColors.secondaryPurple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  /// Get a card decoration with gradient based on current brightness
  static BoxDecoration getCardDecoration(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BoxDecoration(
      gradient: VotixColors.getCardGradient(brightness),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      boxShadow: [
        BoxShadow(
          color: brightness == Brightness.light
              ? const Color(0x1A000000)
              : const Color(0x26000000),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

/// Example usage:
///
/// import 'package:flutter/material.dart';
/// import 'path_to_theme/app_theme.dart';
///
/// void main() {
///   runApp(MyApp());
/// }
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       title: 'Votix App',
///       theme: VotixTheme.getLightTheme(),
///       darkTheme: VotixTheme.getDarkTheme(),
///       themeMode: ThemeMode.system, // Use system settings
///       home: MyHomePage(),
///     );
///   }
/// }
