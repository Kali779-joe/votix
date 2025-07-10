import 'package:flutter/material.dart';

/// VotixColors contains all color constants and gradients for the Votix application
class VotixColors {
  // Primary brand colors
  static const Color primaryPurple = Color(0xFF30094C);
  static const Color primaryMint = Color(0xFF47C599);

  // Secondary colors - refined for professional look
  static const Color secondaryPurple = Color(0xFF4A1A6C);
  static const Color secondaryMint = Color(0xFF2DA37C);
  static const Color softLavender = Color(0xFF8456A7);

  // Tertiary colors - expanded professional palette
  static const Color accentTeal = Color(0xFF1E7B8F);
  static const Color warmGold = Color(0xFFF3B941);
  static const Color softCoral = Color(0xFFE67D72);
  static const Color deepBlue = Color(0xFF19365A);
  static const Color paleRose = Color(0xFFF2D8D5);

  // Light theme colors - refined for modern UI
  static const Color lightBackground = Color(0xFFF8F7FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF2E2E3A);
  static const Color lightDivider = Color(0xFFEAE7F2);
  static const Color lightDisabled = Color(0xFFB2AEC9);
  static const Color lightCard = Color(0xFFFCFBFF);
  static const Color lightOverlay = Color(0xFFF0EDF7);

  // Surface container colors for light theme (Material 3)
  static const Color lightSurfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainerLow = Color(0xFFF8F7FC);
  static const Color lightSurfaceContainer = Color(0xFFF5F3FA);
  static const Color lightSurfaceContainerHigh = Color(0xFFF0EEF7);
  static const Color lightSurfaceContainerHighest = Color(0xFFEBE8F2);

  // Dark theme colors - gentler on eyes
  static const Color darkBackground = Color(0xFF121016);
  static const Color darkSurface = Color(0xFF1E1926);
  static const Color darkOnSurface = Color(0xFFE5E1F0);
  static const Color darkDivider = Color(0xFF302A3A);
  static const Color darkDisabled = Color(0xFF4B4559);
  static const Color darkCard = Color(0xFF251D2E);
  static const Color darkOverlay = Color(0xFF1A1621);

  // Surface container colors for dark theme (Material 3)
  static const Color darkSurfaceContainerLowest = Color(0xFF121016);
  static const Color darkSurfaceContainerLow = Color(0xFF1A1621);
  static const Color darkSurfaceContainer = Color(0xFF1E1926);
  static const Color darkSurfaceContainerHigh = Color(0xFF251D2E);
  static const Color darkSurfaceContainerHighest = Color(0xFF2D2336);

  // Slightly desaturated mint for dark mode (less harsh)
  static const Color darkModeMint = Color(0xFF3DB68C);

  // Transparent versions for overlays (non-const)
  static Color lightOverlay50 = const Color(0xFFF0EDF7).withAlpha(128);
  static Color darkOverlay50 = const Color(0xFF1A1621).withAlpha(128);

  // Error and success states
  static const Color error = Color(0xFFE67D72);
  static const Color success = Color(0xFF47C599);
  static const Color warning = Color(0xFFF3B941);
  static const Color info = Color(0xFF1E7B8F);

  // Text colors for different surfaces
  static const Color lightTextPrimary = Color(0xFF2E2E3A);
  static const Color lightTextSecondary = Color(0xFF6E6D80);
  static const Color darkTextPrimary = Color(0xFFE5E1F0);
  static const Color darkTextSecondary = Color(0xFFB4ADC1);

  // Gradient definitions (non-const to avoid method invocation errors)
  static final LinearGradient primaryGradient = LinearGradient(
    colors: const [primaryPurple, secondaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final LinearGradient mintGradient = LinearGradient(
    colors: const [primaryMint, secondaryMint],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final LinearGradient featureGradient = LinearGradient(
    colors: const [primaryPurple, accentTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final LinearGradient ctaGradient = LinearGradient(
    colors: const [warmGold, softCoral],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Button and interactive element gradients
  static final LinearGradient primaryButtonGradient = LinearGradient(
    colors: const [primaryPurple, secondaryPurple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static final LinearGradient secondaryButtonGradient = LinearGradient(
    colors: const [primaryMint, secondaryMint],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Special feature gradients
  static final LinearGradient votingCardGradient = LinearGradient(
    colors: [primaryPurple.withAlpha(230), accentTeal.withAlpha(179)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final LinearGradient resultsGradient = LinearGradient(
    colors: const [secondaryPurple, accentTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Professional subtle gradients
  static final LinearGradient subtleCardGradient = LinearGradient(
    colors: [lightCard, lightCard.withAlpha(240)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static final LinearGradient darkCardGradient = LinearGradient(
    colors: [darkCard.withAlpha(255), darkCard.withAlpha(230)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Modern accent gradients
  static final LinearGradient accentGradient = LinearGradient(
    colors: const [accentTeal, deepBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Get color based on brightness
  static Color getBackgroundColor(Brightness brightness) {
    return brightness == Brightness.light ? lightBackground : darkBackground;
  }

  static Color getSurfaceColor(Brightness brightness) {
    return brightness == Brightness.light ? lightSurface : darkSurface;
  }

  static Color getCardColor(Brightness brightness) {
    return brightness == Brightness.light ? lightCard : darkCard;
  }

  static Color getTextColor(Brightness brightness) {
    return brightness == Brightness.light ? lightTextPrimary : darkTextPrimary;
  }

  static Color getSecondaryTextColor(Brightness brightness) {
    return brightness == Brightness.light
        ? lightTextSecondary
        : darkTextSecondary;
  }

  static LinearGradient getCardGradient(Brightness brightness) {
    return brightness == Brightness.light
        ? subtleCardGradient
        : darkCardGradient;
  }
}
