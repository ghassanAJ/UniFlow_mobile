import 'package:flutter/material.dart';
import 'package:uniflow/core/design/tokens/lerp.dart';

/// Semantic colors for UniFlow.
///
/// Change these on [ThemeData] to restyle every design-system widget.
/// Per-widget constructor colors still win over the token.
@immutable
class ColorTokens extends ThemeExtension<ColorTokens> {
  const ColorTokens({
    required this.primary,
    required this.onPrimary,
    required this.primarySoft,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.accent,
    required this.chipBackground,
    required this.chipForeground,
    required this.border,
    required this.disabled,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.shadow,
  });

  final Color primary;
  final Color onPrimary;
  final Color primarySoft;
  final Color secondary;
  final Color onSecondary;
  final Color background;
  final Color surface;
  final Color surfaceMuted;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color accent;
  final Color chipBackground;
  final Color chipForeground;
  final Color border;
  final Color disabled;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color shadow;

  static const light = ColorTokens(
    primary: Color(0xFFFF6433),
    onPrimary: Color(0xFFFFFFFF),
    primarySoft: Color(0xFFFFE6DC),
    secondary: Color(0xFFFF9066),
    onSecondary: Color(0xFF1E2024),
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFF1F1F1),
    textPrimary: Color(0xFF1E2024),
    textSecondary: Color(0xFF737373),
    textMuted: Color(0xFFB5A9A5),
    accent: Color(0xFFD45F2E),
    chipBackground: Color(0xFFE7E5E5),
    chipForeground: Color(0xFF5A413A),
    border: Color(0xFFEEEEEE),
    disabled: Color(0xFFF5F5F5),
    success: Color(0xFF2EB67D),
    warning: Color(0xFFFFC107),
    error: Color(0xFFDC3545),
    info: Color(0xFF17A2B8),
    shadow: Color(0xFF1E2024),
  );

  static const dark = ColorTokens(
    primary: Color(0xFFFF6433),
    onPrimary: Color(0xFFFFFFFF),
    primarySoft: Color(0xFF3A241C),
    secondary: Color(0xFFFF9066),
    onSecondary: Color(0xFF1E2024),
    background: Color(0xFF121316),
    surface: Color(0xFF1E2024),
    surfaceMuted: Color(0xFF2A2D33),
    textPrimary: Color(0xFFF7F4F2),
    textSecondary: Color(0xFFB7B1AE),
    textMuted: Color(0xFF8A817C),
    accent: Color(0xFFFF9066),
    chipBackground: Color(0xFF34302E),
    chipForeground: Color(0xFFF0D2C6),
    border: Color(0xFF3A3D43),
    disabled: Color(0xFF2A2D33),
    success: Color(0xFF2EB67D),
    warning: Color(0xFFFFC107),
    error: Color(0xFFDC3545),
    info: Color(0xFF17A2B8),
    shadow: Color(0xFF000000),
  );

  @override
  ColorTokens copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primarySoft,
    Color? secondary,
    Color? onSecondary,
    Color? background,
    Color? surface,
    Color? surfaceMuted,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? accent,
    Color? chipBackground,
    Color? chipForeground,
    Color? border,
    Color? disabled,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? shadow,
  }) {
    return ColorTokens(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primarySoft: primarySoft ?? this.primarySoft,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      accent: accent ?? this.accent,
      chipBackground: chipBackground ?? this.chipBackground,
      chipForeground: chipForeground ?? this.chipForeground,
      border: border ?? this.border,
      disabled: disabled ?? this.disabled,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ColorTokens lerp(covariant ColorTokens? other, double t) {
    if (other == null) return this;

    return ColorTokens(
      primary: dsLerpColor(primary, other.primary, t)!,
      onPrimary: dsLerpColor(onPrimary, other.onPrimary, t)!,
      primarySoft: dsLerpColor(primarySoft, other.primarySoft, t)!,
      secondary: dsLerpColor(secondary, other.secondary, t)!,
      onSecondary: dsLerpColor(onSecondary, other.onSecondary, t)!,
      background: dsLerpColor(background, other.background, t)!,
      surface: dsLerpColor(surface, other.surface, t)!,
      surfaceMuted: dsLerpColor(surfaceMuted, other.surfaceMuted, t)!,
      textPrimary: dsLerpColor(textPrimary, other.textPrimary, t)!,
      textSecondary: dsLerpColor(textSecondary, other.textSecondary, t)!,
      textMuted: dsLerpColor(textMuted, other.textMuted, t)!,
      accent: dsLerpColor(accent, other.accent, t)!,
      chipBackground: dsLerpColor(chipBackground, other.chipBackground, t)!,
      chipForeground: dsLerpColor(chipForeground, other.chipForeground, t)!,
      border: dsLerpColor(border, other.border, t)!,
      disabled: dsLerpColor(disabled, other.disabled, t)!,
      success: dsLerpColor(success, other.success, t)!,
      warning: dsLerpColor(warning, other.warning, t)!,
      error: dsLerpColor(error, other.error, t)!,
      info: dsLerpColor(info, other.info, t)!,
      shadow: dsLerpColor(shadow, other.shadow, t)!,
    );
  }
}
