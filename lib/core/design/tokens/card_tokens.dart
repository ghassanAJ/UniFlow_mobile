import 'package:flutter/material.dart';
import 'package:uniflow/core/design/tokens/lerp.dart';

/// Geometry for [DsCard]. Null colors fall back to [ColorTokens].
@immutable
class CardTokens extends ThemeExtension<CardTokens> {
  const CardTokens({
    this.radius = 24,
    this.padding = 16,
    this.blur = 16,
    this.shadowY = 6,
    this.shadowAlpha = 0.08,
    this.filled,
    this.elevated,
    this.border,
  });

  final double radius;
  final double padding;
  final double blur;
  final double shadowY;
  final double shadowAlpha;
  final Color? filled;
  final Color? elevated;
  final Color? border;

  static const standard = CardTokens();

  @override
  CardTokens copyWith({
    double? radius,
    double? padding,
    double? blur,
    double? shadowY,
    double? shadowAlpha,
    Color? filled,
    Color? elevated,
    Color? border,
  }) {
    return CardTokens(
      radius: radius ?? this.radius,
      padding: padding ?? this.padding,
      blur: blur ?? this.blur,
      shadowY: shadowY ?? this.shadowY,
      shadowAlpha: shadowAlpha ?? this.shadowAlpha,
      filled: filled ?? this.filled,
      elevated: elevated ?? this.elevated,
      border: border ?? this.border,
    );
  }

  @override
  CardTokens lerp(covariant CardTokens? other, double t) {
    if (other == null) return this;

    return CardTokens(
      radius: dsLerp(radius, other.radius, t),
      padding: dsLerp(padding, other.padding, t),
      blur: dsLerp(blur, other.blur, t),
      shadowY: dsLerp(shadowY, other.shadowY, t),
      shadowAlpha: dsLerp(shadowAlpha, other.shadowAlpha, t),
      filled: dsLerpColor(filled, other.filled, t),
      elevated: dsLerpColor(elevated, other.elevated, t),
      border: dsLerpColor(border, other.border, t),
    );
  }
}
