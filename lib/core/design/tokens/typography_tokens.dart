import 'package:flutter/material.dart';

enum DsTextRole {
  display,
  headline,
  title,
  titleSmall,
  body,
  caption,
  label,
  overline,
}

/// Type scale. Font sizes are design pixels; [DsText] scales them.
///
/// Text color is resolved from [ColorTokens] by role, unless a style
/// already sets a color or the widget receives one.
@immutable
class TypographyTokens extends ThemeExtension<TypographyTokens> {
  const TypographyTokens({
    required this.fontFamily,
    required this.display,
    required this.headline,
    required this.title,
    required this.titleSmall,
    required this.body,
    required this.caption,
    required this.label,
    required this.overline,
  });

  final String fontFamily;
  final TextStyle display;
  final TextStyle headline;
  final TextStyle title;
  final TextStyle titleSmall;
  final TextStyle body;
  final TextStyle caption;
  final TextStyle label;
  final TextStyle overline;

  static const standard = TypographyTokens(
    fontFamily: 'Inter',
    display: TextStyle(
      fontFamily: 'Inter',
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 1.2,
    ),
    headline: TextStyle(
      fontFamily: 'Inter',
      fontSize: 22,
      fontWeight: FontWeight.w700,
      height: 1.25,
    ),
    title: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 1.3,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    body: TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),
    caption: TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.35,
    ),
    label: TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.2,
    ),
    overline: TextStyle(
      fontFamily: 'Inter',
      fontSize: 10,
      fontWeight: FontWeight.w600,
      height: 1.2,
    ),
  );

  TextStyle styleFor(DsTextRole role) => switch (role) {
    DsTextRole.display => display,
    DsTextRole.headline => headline,
    DsTextRole.title => title,
    DsTextRole.titleSmall => titleSmall,
    DsTextRole.body => body,
    DsTextRole.caption => caption,
    DsTextRole.label => label,
    DsTextRole.overline => overline,
  };

  @override
  TypographyTokens copyWith({
    String? fontFamily,
    TextStyle? display,
    TextStyle? headline,
    TextStyle? title,
    TextStyle? titleSmall,
    TextStyle? body,
    TextStyle? caption,
    TextStyle? label,
    TextStyle? overline,
  }) {
    TextStyle pick(TextStyle current, TextStyle? override) {
      final style = override ?? current;
      if (fontFamily == null) return style;
      return style.copyWith(fontFamily: fontFamily);
    }

    return TypographyTokens(
      fontFamily: fontFamily ?? this.fontFamily,
      display: pick(this.display, display),
      headline: pick(this.headline, headline),
      title: pick(this.title, title),
      titleSmall: pick(this.titleSmall, titleSmall),
      body: pick(this.body, body),
      caption: pick(this.caption, caption),
      label: pick(this.label, label),
      overline: pick(this.overline, overline),
    );
  }

  @override
  TypographyTokens lerp(covariant TypographyTokens? other, double t) {
    if (other == null) return this;

    return TypographyTokens(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
      display: TextStyle.lerp(display, other.display, t)!,
      headline: TextStyle.lerp(headline, other.headline, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      overline: TextStyle.lerp(overline, other.overline, t)!,
    );
  }
}
