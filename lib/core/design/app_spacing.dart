import 'package:flutter/widgets.dart';

/// Design System: spacing, padding, and sizing tokens for the app.
///
/// Usage:
///   padding: const EdgeInsets.all(AppSpacing.md),
///   SizedBox(height: AppSpacing.sm),
///   SizedBox(width: AppSpacing.lg),
///
/// Keep spacing values centralized here instead of scattering raw numbers
/// throughout widgets. Adjust the scale here to update the app consistently.
abstract final class AppSpacing {
  // Base spacing scale (multiples of 4).
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;
  static const double massive = 48;
  static const double giant = 64;

  // Common screen and layout spacing.
  static const double screenHorizontal = 20;
  static const double screenVertical = 24;
  static const double section = 32;
  static const double cardGap = 12;
  static const double listItemGap = 12;
  static const double formFieldGap = 16;
  static const double buttonContentGap = 8;

  // Common edge insets.
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
    vertical: screenVertical,
  );

  static const EdgeInsets screenHorizontalPadding = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
  );

  static const EdgeInsets screenVerticalPadding = EdgeInsets.symmetric(
    vertical: screenVertical,
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(lg);

  static const EdgeInsets compactCardPadding = EdgeInsets.all(md);

  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: xxl,
    vertical: md,
  );

  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  // Common border radius values, kept here for consistent component geometry.
  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusPill = 999;

  // Common icon sizes (these are sizes, not spacing).
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconLg = 24;
  static const double iconXl = 32;
}
