/// A centralized size system for consistent spacing and sizing in Votix.
///
/// Use this for padding, margins, font sizes, icons, etc.
/// It keeps your UI consistent and easily scalable.
class VotixSizes {
  // Base unit (you can scale everything relative to this)
  static const double base = 8.0;

  // Spacing
  static const double xs = base * 0.5; // 4.0
  static const double sm = base;       // 8.0
  static const double md = base * 2;   // 16.0
  static const double lg = base * 3;   // 24.0
  static const double xl = base * 4;   // 32.0
  static const double xxl = base * 5;  // 40.0

  // Font sizes
  static const double fontXs = 10.0;
  static const double fontSm = 12.0;
  static const double fontMd = 14.0;
  static const double fontLg = 18.0;
  static const double fontXl = 22.0;
  static const double fontXxl = 28.0;

  // Icon sizes
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  // Border radius
  static const double radiusSm = 6.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 24.0;

  // Flexible helper
  static double scale(double multiplier) => base * multiplier;

/// Usage:
/// `padding: EdgeInsets.all(VotixSizes.md)` (16.0)
/// `SizedBox(height: VotixSizes.scale(2.5))` (20.0)
}
