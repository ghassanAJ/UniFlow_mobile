import 'package:flutter/material.dart';
import 'package:uniflow/core/design/design_system.dart';

/// Light and dark themes wired to the design-system tokens.
class AppTheme {
  AppTheme._();

  static ThemeData get light => _theme(Brightness.light);

  static ThemeData get dark => _theme(Brightness.dark);

  static ThemeData _theme(Brightness brightness) {
    final colors = brightness == Brightness.dark
        ? ColorTokens.dark
        : ColorTokens.light;
    final typography = TypographyTokens.standard;
    final scheme =
        ColorScheme.fromSeed(
          seedColor: colors.primary,
          brightness: brightness,
        ).copyWith(
          primary: colors.primary,
          onPrimary: colors.onPrimary,
          secondary: colors.secondary,
          onSecondary: colors.onSecondary,
          surface: colors.surface,
          error: colors.error,
          onError: colors.onPrimary,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: typography.fontFamily,
      scaffoldBackgroundColor: colors.background,
      colorScheme: scheme,
      textTheme: _textTheme(typography, colors),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      dividerColor: colors.border,
      iconTheme: IconThemeData(color: colors.textPrimary),
      extensions: <ThemeExtension<dynamic>>[
        colors,
        typography,
        ButtonTokens.standard,
        CardTokens.standard,
        ChipTokens.standard,
        FieldTokens.standard,
        IconButtonTokens.standard,
        brightness == Brightness.dark
            ? const AvatarTokens(
                backgroundColor: Color(0xFF2A2D33),
                foregroundColor: Color(0xFFF7F4F2),
                borderColor: Color(0xFF121316),
              )
            : const AvatarTokens(),
      ],
    );
  }

  static TextTheme _textTheme(TypographyTokens type, ColorTokens colors) {
    TextStyle paint(TextStyle style, Color color) =>
        style.copyWith(color: color);

    return TextTheme(
      displaySmall: paint(type.display, colors.textPrimary),
      headlineSmall: paint(type.headline, colors.textPrimary),
      titleLarge: paint(type.title, colors.textPrimary),
      titleMedium: paint(type.titleSmall, colors.textPrimary),
      bodyMedium: paint(type.body, colors.textSecondary),
      bodySmall: paint(type.caption, colors.textSecondary),
      labelLarge: paint(type.label, colors.textPrimary),
      labelSmall: paint(type.overline, colors.textPrimary),
    );
  }
}
