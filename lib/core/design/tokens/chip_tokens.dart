import 'package:flutter/material.dart';
import 'package:uniflow/core/design/tokens/lerp.dart';

/// Geometry for [DsChip], [DsBadge], and [DsChoiceBar].
@immutable
class ChipTokens extends ThemeExtension<ChipTokens> {
  const ChipTokens({
    this.heightSm = 22,
    this.heightMd = 28,
    this.heightLg = 42,
    this.paddingHSm = 10,
    this.paddingHMd = 12,
    this.paddingHLg = 22,
    this.radius = 999,
    this.gap = 8,
    this.iconSize = 14,
    this.background,
    this.foreground,
    this.selectedBackground,
    this.selectedForeground,
    this.iconColor,
  });

  final double heightSm;
  final double heightMd;
  final double heightLg;
  final double paddingHSm;
  final double paddingHMd;
  final double paddingHLg;
  final double radius;
  final double gap;
  final double iconSize;
  final Color? background;
  final Color? foreground;
  final Color? selectedBackground;
  final Color? selectedForeground;
  final Color? iconColor;

  static const standard = ChipTokens();

  @override
  ChipTokens copyWith({
    double? heightSm,
    double? heightMd,
    double? heightLg,
    double? paddingHSm,
    double? paddingHMd,
    double? paddingHLg,
    double? radius,
    double? gap,
    double? iconSize,
    Color? background,
    Color? foreground,
    Color? selectedBackground,
    Color? selectedForeground,
    Color? iconColor,
  }) {
    return ChipTokens(
      heightSm: heightSm ?? this.heightSm,
      heightMd: heightMd ?? this.heightMd,
      heightLg: heightLg ?? this.heightLg,
      paddingHSm: paddingHSm ?? this.paddingHSm,
      paddingHMd: paddingHMd ?? this.paddingHMd,
      paddingHLg: paddingHLg ?? this.paddingHLg,
      radius: radius ?? this.radius,
      gap: gap ?? this.gap,
      iconSize: iconSize ?? this.iconSize,
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      selectedBackground: selectedBackground ?? this.selectedBackground,
      selectedForeground: selectedForeground ?? this.selectedForeground,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  ChipTokens lerp(covariant ChipTokens? other, double t) {
    if (other == null) return this;

    return ChipTokens(
      heightSm: dsLerp(heightSm, other.heightSm, t),
      heightMd: dsLerp(heightMd, other.heightMd, t),
      heightLg: dsLerp(heightLg, other.heightLg, t),
      paddingHSm: dsLerp(paddingHSm, other.paddingHSm, t),
      paddingHMd: dsLerp(paddingHMd, other.paddingHMd, t),
      paddingHLg: dsLerp(paddingHLg, other.paddingHLg, t),
      radius: dsLerp(radius, other.radius, t),
      gap: dsLerp(gap, other.gap, t),
      iconSize: dsLerp(iconSize, other.iconSize, t),
      background: dsLerpColor(background, other.background, t),
      foreground: dsLerpColor(foreground, other.foreground, t),
      selectedBackground: dsLerpColor(
        selectedBackground,
        other.selectedBackground,
        t,
      ),
      selectedForeground: dsLerpColor(
        selectedForeground,
        other.selectedForeground,
        t,
      ),
      iconColor: dsLerpColor(iconColor, other.iconColor, t),
    );
  }
}
