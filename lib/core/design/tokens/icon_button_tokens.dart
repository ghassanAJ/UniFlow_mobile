import 'package:flutter/material.dart';
import 'package:uniflow/core/design/tokens/lerp.dart';

/// Geometry for [DsIconButton]. Null colors fall back to [ColorTokens].
@immutable
class IconButtonTokens extends ThemeExtension<IconButtonTokens> {
  const IconButtonTokens({
    this.size = 38,
    this.iconSize = 16,
    this.radius = 12,
    this.badgeSize = 8,
    this.softBackground,
    this.softForeground,
    this.filledBackground,
    this.filledForeground,
    this.ghostForeground,
    this.badgeColor,
  });

  final double size;
  final double iconSize;
  final double radius;
  final double badgeSize;
  final Color? softBackground;
  final Color? softForeground;
  final Color? filledBackground;
  final Color? filledForeground;
  final Color? ghostForeground;
  final Color? badgeColor;

  static const standard = IconButtonTokens();

  @override
  IconButtonTokens copyWith({
    double? size,
    double? iconSize,
    double? radius,
    double? badgeSize,
    Color? softBackground,
    Color? softForeground,
    Color? filledBackground,
    Color? filledForeground,
    Color? ghostForeground,
    Color? badgeColor,
  }) {
    return IconButtonTokens(
      size: size ?? this.size,
      iconSize: iconSize ?? this.iconSize,
      radius: radius ?? this.radius,
      badgeSize: badgeSize ?? this.badgeSize,
      softBackground: softBackground ?? this.softBackground,
      softForeground: softForeground ?? this.softForeground,
      filledBackground: filledBackground ?? this.filledBackground,
      filledForeground: filledForeground ?? this.filledForeground,
      ghostForeground: ghostForeground ?? this.ghostForeground,
      badgeColor: badgeColor ?? this.badgeColor,
    );
  }

  @override
  IconButtonTokens lerp(covariant IconButtonTokens? other, double t) {
    if (other == null) return this;

    return IconButtonTokens(
      size: dsLerp(size, other.size, t),
      iconSize: dsLerp(iconSize, other.iconSize, t),
      radius: dsLerp(radius, other.radius, t),
      badgeSize: dsLerp(badgeSize, other.badgeSize, t),
      softBackground: dsLerpColor(softBackground, other.softBackground, t),
      softForeground: dsLerpColor(softForeground, other.softForeground, t),
      filledBackground: dsLerpColor(
        filledBackground,
        other.filledBackground,
        t,
      ),
      filledForeground: dsLerpColor(
        filledForeground,
        other.filledForeground,
        t,
      ),
      ghostForeground: dsLerpColor(ghostForeground, other.ghostForeground, t),
      badgeColor: dsLerpColor(badgeColor, other.badgeColor, t),
    );
  }
}
